package com.sp.chat;

import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

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
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	//WebSocket 의 연결이 닫혔을때
		super.afterConnectionClosed(session, status);
	}
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
	//클라이언트로부터 메시지가 도착했을때
		super.handleMessage(session, message);
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
				
				//sendOneMess.....
			}
		} catch (Exception e) {
			this.logger.info(e.toString());
		}
	}
/*	
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
				String founderName=jsonReceive.getString("founderName");
				
				GuestInfo guestInfo=guestMap.get(roomId);
				if(guestInfo==null) {
					return;
				}
				//개설자가 입력한 채팅방의 정보
				RoomInfo roomInfo=new RoomInfo();
				roomInfo.setSubject(subject);
				roomInfo.setMaxNumber(maxNumber);
				roomInfo.setFounderName(founderName);
				roomInfo.getGuestSet().add(roomId);
				roomMap.put(roomId, roomInfo);
				
				//참여자 목록에 개설자 추가
				guestInfo.setUserName(founderName);
				guestInfo.setRoom(roomInfo);
				
				//개설자에게 개설 성공여부 전송
				job=new JSONObject();
				job.put("type", "room");
				job.put("cmd", "add-ok");
				job.put("roomId", roomId);
				job.put("subject", subject);
				job.put("maxNumber", maxNumber);
				//sendOneMess.....
				
				
			}
			
			
		} catch (Exception e) {

		}
		
	}
	*/
	
}
