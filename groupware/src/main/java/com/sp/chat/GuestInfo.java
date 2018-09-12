package com.sp.chat;

import org.springframework.web.socket.WebSocketSession;

public class GuestInfo {
	private String userName;
	private WebSocketSession session;
	private RoomInfo room;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public WebSocketSession getSession() {
		return session;
	}
	public void setSession(WebSocketSession session) {
		this.session = session;
	}
	public RoomInfo getRoom() {
		return room;
	}
	public void setRoom(RoomInfo room) {
		this.room = room;
	}
}
