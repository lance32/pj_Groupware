package com.sp.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

public class SocketHandler extends TextWebSocketHandler{
	private final Logger logger=LoggerFactory.getLogger(SocketHandler.class);
	
	// 접속한 게스트 (접속아이디, 게스트정보)
	private Map<String, GuestInfo> guestMap = new Hashtable<>();
	//채팅방 정보 (개설아이디, 채팅방정보)
	private Map<String, RoomInfo> roomMap = new Hashtable<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	//WebSocket 의 연결이 열리고 사용준비될 때
		super.afterConnectionEstablished(session);
		
		logger.info("add session id: "+session.getId()+", ip: "
				+session.getRemoteAddress().getHostName());
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	//WebSocket 의 연결이 닫혔을때
		super.afterConnectionClosed(session, status);
		removeGuest(session);
		this.logger.info("remove session id: " + session.getId());
	}
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
	//클라이언트로부터 메시지가 도착했을때
		super.handleMessage(session, message);
		
		// 클라이언트로부터 메시지가 도착했을 때 호출
		JSONObject jsonReceive = null;
		try {
			jsonReceive = (JSONObject) JSONSerializer.toJSON(message.getPayload());
		}catch (Exception e) {
		}
		if(jsonReceive==null) return;
		
		String type=jsonReceive.getString("type");
		if(type==null) return;
		
		if(type.equals("conn")) {
			// 처음 접속한 경우
			connectServer(session, jsonReceive);
		} else if(type.equals("room")) {
			// 채팅 메인화면 - 채팅방 리스트
			receiveRoom(session, jsonReceive);
		} else if(type.equals("talk")) {
			// 채팅방 - 채팅
			receiveTalk(session, jsonReceive);
		}
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	}
	
	protected void connectServer(WebSocketSession session, JSONObject jsonReceive) {
	//처음 접속하면 사용자 정보 저장
		JSONObject job;
		try {
			String guestId = jsonReceive.getString("guestId");
			
			GuestInfo guestInfo=new GuestInfo();
			guestInfo.setSession(session);
			
			guestMap.put(guestId, guestInfo);
			
			//채팅방 목록 전송
			Iterator<String> it=roomMap.keySet().iterator();
			while(it.hasNext()) {
				String key=it.next();
				RoomInfo roomInfo = roomMap.get(key);
				
				job=new JSONObject();
				job.put("type", "room");
				job.put("cmd", "room-list");
				job.put("roomId", key);
				job.put("subject", roomInfo.getSubject());
				
				sendOneMessage(job.toString(), session);
			}
		} catch (Exception e) {
			this.logger.info(e.toString());
		}
	}
	
	protected void receiveRoom(WebSocketSession session, JSONObject jsonReceive) {
		String cmd=jsonReceive.getString("cmd");
		if(cmd==null) {
			return;
		}
		JSONObject job;
		try {
			if(cmd.equals("add")) {
			//채팅방 개설
				String roomId=jsonReceive.getString("roomId");
				String subject=jsonReceive.getString("subject");
				int maxNumber=Integer.parseInt(jsonReceive.getString("maxNumber"));
				String userName=jsonReceive.getString("userName");
				
				GuestInfo guestInfo=guestMap.get(roomId);
				if(guestInfo==null) {
					return;
				}
				//개설자가 입력한 채팅방의 정보
				RoomInfo roomInfo=new RoomInfo();
				roomInfo.setSubject(subject);
				roomInfo.setMaxNumber(maxNumber);
				roomInfo.setUserName(userName);
				roomInfo.getGuestSet().add(roomId);
				roomMap.put(roomId, roomInfo);
				
				//참여자 목록에 개설자 추가
				guestInfo.setUserName(userName);
				guestInfo.setRoom(roomInfo);
				
				//개설자에게 개설 성공여부 전송
				job=new JSONObject();
				job.put("type", "room");
				job.put("cmd", "add-ok");
				job.put("roomId", roomId);
				job.put("subject", subject);
				job.put("maxNumber", maxNumber);
				sendOneMessage(job.toString(), session);
				
				//개설된 채팅방의 정보를 전체 사용자에게 전송
				job=new JSONObject();
				job.put("type", "room");
				job.put("cmd", "room-list");
				job.put("roomId", roomId);	//개설자의 아이디
				job.put("subject", roomInfo.getSubject());
				
				//sendAll...
			} else if(cmd.equals("closed")){
			//채팅방 삭제(개설자가 채팅방에서 나가면..)
				String roomId="";//getGuestId(...
				RoomInfo roomInfo=roomMap.get(roomId);
				if(roomInfo==null) {
					return;
				}
				String subject=roomInfo.getSubject();
				
				//접속자에게 채팅방 삭제 알림.
				job=new JSONObject();
				job.put("type", "talk");          // 상태:대화중
				job.put("cmd", "closed");      // 채팅방 종료
				job.put("roomId", roomId);  // 채팅방 개설자 아이디
				job.put("subject", subject);   // 채팅방 제목
				sendRoomMessage(job.toString(),  roomInfo.getGuestSet(), roomId);
				
				//접속자들에게 채팅방 정보 지우기
				for(String guest:roomInfo.getGuestSet()) {
					GuestInfo gi=guestMap.get(guest);
					if(gi!=null) {
						gi.setRoom(null);
					}
				}
				// 채팅방 삭제
				roomMap.remove(roomId);
				
				// 게스트 정보에서 채팅방 정보 삭제
				guestMap.get(roomId).setRoom(null);
				
				// 모든 사용자에게 채팅방 삭제정보 전송하기
				job=new JSONObject();
				job.put("type", "room");
				job.put("cmd", "closed");    // 채팅방 종료
				job.put("roomId", roomId);
				job.put("subject", subject);
				sendAllMessage(job.toString(), null);		
				
			} else if(cmd.equals("join")) {
			// 채팅방 입장
				
				String roomId = jsonReceive.getString("roomId");
				RoomInfo roomInfo=roomMap.get(roomId);
			
				String guestId = getGuestId(session);
				String userName = jsonReceive.getString("userName");
				if(guestId==null) {
					return;
				}
				
				if(roomInfo==null || roomInfo.getMaxNumber()<=roomInfo.getGuestSet().size()) {
				// 채팅방에 접속 할 수 없는 경우
					job=new JSONObject();
					job.put("type", "room");
					job.put("cmd", "join-fail");
					job.put("roomId", roomId);
					job.put("subject", roomInfo.getSubject());
					sendOneMessage(job.toString(), session);
					return;
				}
				// 채팅방에 새로운 게스트 저장하기
				roomInfo.getGuestSet().add(guestId);
				
				GuestInfo guestInfo=guestMap.get(guestId);
				guestInfo.setUserName(userName);
				guestInfo.setRoom(roomInfo);
				
				// 접속 성공 알림
				job=new JSONObject();
				job.put("type", "room");
				job.put("cmd", "join-ok");
				job.put("roomId", roomId);
				job.put("subject", roomInfo.getSubject());
				sendOneMessage(job.toString(), session);
				
				// 채팅방 참여자 리스트 전송하기
				List<String> list=new ArrayList<>();
				for(String u:roomInfo.getGuestSet()) {
					if(guestMap.get(u)==null) continue;
					
					if(u.equals(guestId)) continue;
					
					String name=guestMap.get(u).getUserName();
					list.add(u+":"+name);
				}
				job=new JSONObject();
				job.put("type", "talk");
				job.put("cmd", "join-list");
				JSONArray jarr=new JSONArray();
				jarr.addAll(list);
				job.put("guestList", jarr);
				sendOneMessage(job.toString(), session);
				
				// 채팅방 채팅에 접속사실 띄우기
				job=new JSONObject();
				job.put("type", "talk");
				job.put("cmd", "join-add");
				job.put("guestId", guestId);
				job.put("nickName", guestInfo.getUserName());
				sendRoomMessage(job.toString(), roomInfo.getGuestSet(), guestId);
				
			} else if(cmd.equals("info")) {
			// 채팅방 정보 전송하기(채팅방 제목을 클릭한 경우)        *****수정
				
				String roomId = jsonReceive.getString("roomId");
				RoomInfo roomInfo=roomMap.get(roomId);
				if(roomInfo==null) return;
				
				List<String> list=new ArrayList<>();
				for(String u:roomInfo.getGuestSet()) {
					if(guestMap.get(u)==null) continue;
					
					String name=guestMap.get(u).getUserName();
					list.add(u+":"+name);
				}
				job=new JSONObject();
				job.put("type", "room");
				job.put("cmd", "info");
				job.put("roomId", roomId);
				job.put("nickName", roomInfo.getUserName());
				job.put("number", roomInfo.getGuestSet().size());
				job.put("maximum", roomInfo.getUserName());
				JSONArray jarr=new JSONArray();
				jarr.addAll(list);
				job.put("guestList", jarr);

				sendOneMessage(job.toString(), session);
			}
			
		} catch (Exception e) {
			this.logger.info(e.toString());
		}
	}
	
	// type:talk
	protected void receiveTalk(WebSocketSession session, JSONObject jsonReceive) {
		String cmd=jsonReceive.getString("cmd");
		String senderId=getGuestId(session);
		String senderName=guestMap.get(senderId).getUserName();
		if(cmd==null||senderId==null) return;
		
		GuestInfo guestInfo=guestMap.get(senderId);
		if(guestInfo==null) return;
		
		RoomInfo roomInfo=guestMap.get(senderId).getRoom();
		if(roomInfo==null) return;

		JSONObject job;
		try {
			if(cmd.equals("chatMsg")) {
				String to=jsonReceive.getString("to");
				String msg=jsonReceive.getString("message");

				if(to==null || msg==null) return;
				
				if(to.equals("all")) {
					// 다른 채팅방 게스트에게 메시지 전송
					job=new JSONObject();
					job.put("type", "talk");
					job.put("cmd", "chatMsg");
					job.put("to", "all");
					job.put("senderId", senderId);
					job.put("senderName", senderName);
					job.put("message", msg);
					
					sendRoomMessage(job.toString(), roomInfo.getGuestSet(), senderId);
					
				} else if(to.equals("one")) {
					// 귓속말
					
					// 받을사람 아이디
					String receiveId = jsonReceive.getString("receiveId");
					if(guestMap.get(receiveId).getRoom()==null) return;
					
					job=new JSONObject();
					job.put("type", "talk");
					job.put("cmd", "chatMsg");
					job.put("to", "one");
					job.put("senderId", senderId);
					job.put("senderName", senderName);
					job.put("message", msg);
					
					sendOneMessage(job.toString(), guestMap.get(receiveId).getSession());
				}
				
			} else if(cmd.equals("leave")) {
				// 채팅방에서 나간 경우(채팅방을 개설하지 않은 게스트)
				
				// 채팅방에서 나간 사실을 다른 사용자에게 전송
				job=new JSONObject();
				job.put("type", "talk");
				job.put("cmd", "leave");
				job.put("guestId", senderId);
				job.put("nickName", senderName);
				
				sendRoomMessage(job.toString(), roomInfo.getGuestSet(), senderId);
				
				guestInfo.setRoom(null);
				guestInfo.setUserName(null);
				
				// 채팅방에서 삭제
				roomInfo.getGuestSet().remove(senderId);
			}
			
		} catch (Exception e) {
			this.logger.info(e.toString());
		}
		
	}

	// 모든 사용자에게 전송
	/**
	 * @param message 전송할 메시지
	 * @param out         제외할 게스트(null 인경우 전체)
	 */
	protected void sendAllMessage(String message, String out) {
		Iterator<String> it = guestMap.keySet().iterator();
		
		while (it.hasNext()) {
			String key=it.next();
			if(out!=null && out.equals(key))  // 자기 자신
				continue;
			
			GuestInfo guestInfo=guestMap.get(key);
			WebSocketSession session=guestInfo.getSession();
			
			try {
				if (session.isOpen()) {
					session.sendMessage(new TextMessage(message));
				}
			} catch (IOException e) {
				removeGuest(session);
			}			
		}
	}
	
	// 채팅방 사용자에게 전송
	/**
	 * @param message 전송할 메시지
	 * @param roomSet 메시지를 전송할 게스트들
	 * @param out        제외할 게스트(null 인경우 전체)
	 */
	protected void sendRoomMessage(String message, Set<String> roomSet, String out) {
		Iterator<String> it = roomSet.iterator();
		while (it.hasNext()) {
			String key=it.next();
			if(out!=null && out.equals(key))  // 자기 자신
				continue;
			
			GuestInfo guestInfo=guestMap.get(key);
			WebSocketSession session=guestInfo.getSession();

			try {
				if (session.isOpen()) {
					session.sendMessage(new TextMessage(message));
				}
			} catch (IOException e) {
				this.logger.error("fail to send message - room : ", e);
				removeGuest(session);
			}			
		}
	}
	
	// 특정 사용자에게 메시지 전송
	/**
	 * @param message  전송할 메시지
	 * @param session    전송할 게스트의 WebSocketSession 객체
	 */
	protected void sendOneMessage(String message, WebSocketSession session) {
		if (session.isOpen()) {
			try {
				session.sendMessage(new TextMessage(message));
			} catch (Exception e) {
				this.logger.error("fail to send message - one : ", e);
			}
		}
	}

	// session을 이용하여 사용자 아이디 알아내기
	protected String getGuestId(WebSocketSession session) {
		String guestId=null;
		Iterator<String> it = guestMap.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			
			GuestInfo info=guestMap.get(key);
			if(info.getSession()==session) {
				guestId=key;
				break;
			}
		}
		
		return guestId;
	}
	
	// 연결이 종료 된경우 해당 사용자 정보 지우기
	protected void removeGuest(WebSocketSession session) {
		JSONObject job;
		
		String guestId=getGuestId(session);
		if(guestId==null) return;
		
		GuestInfo guetInfo=guestMap.get(guestId);
		if(guetInfo==null) return;
		RoomInfo roomInfo=guetInfo.getRoom();
		
		try {
			if(roomMap.containsKey(guestId)) {
				// 채팅룸 개설자의 연결이 종료 된 경우
				if(roomInfo!=null) {
					// 채팅방에 참여중인 사용자에게 채팅방 closed 사실을 알림
					job=new JSONObject();
					job.put("type", "talk");          // 상태:대화중
					job.put("cmd", "closed");      // 채팅방 종료
					job.put("roomId", guestId);  // 채팅방 개설 아이디
					job.put("subject", roomInfo.getSubject());  // 채팅방 제목
					sendRoomMessage(job.toString(),  roomInfo.getGuestSet(), guestId);
					
					for(String guest:roomInfo.getGuestSet()) {
						GuestInfo gi=guestMap.get(guest);
						if(gi!=null) {
							gi.setRoom(null);
						}
					}
					
					// 모든 사용자에게 채팅방 closed 사실을 알림
					job=new JSONObject();
					job.put("type", "room");
					job.put("cmd", "closed");    // 채팅방 종료
					job.put("roomId", guestId);
					job.put("subject", roomInfo.getSubject());
					sendAllMessage(job.toString(), guestId);
				}
				
				// 채팅방 정보 삭제
				roomMap.remove(guestId);
				
			} else {
				// 채팅방 개설자가 아닌 게스트의 연결이 종료 된 경우
				
				// 채팅방에 참여중인 경우
				if(roomInfo!=null) {
					// 채팅방의 다른 게스트에게 채팅방을 나간 사실을 알려줌
					job=new JSONObject();
					job.put("type", "talk");      // 상태:대화중
					job.put("cmd", "leave");    // 룸나감
					job.put("guestId", guestId);
					job.put("nickName", guetInfo.getUserName());
					sendRoomMessage(job.toString(),  roomInfo.getGuestSet(), guestId);
					
					// 채팅방에서 삭제
					roomInfo.getGuestSet().remove(guestId);
				}
			}
			
			try {
				guetInfo.getSession().close();
			} catch (Exception e) {
			}
			
			// 게스트 정보 제거
			guestMap.remove(guestId);
			
		} catch (Exception e) {
			logger.info("removeGuest => " + e.toString());
		}

	}
	
}
