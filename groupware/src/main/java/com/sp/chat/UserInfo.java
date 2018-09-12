package com.sp.chat;

import org.springframework.web.socket.WebSocketSession;

public class UserInfo {
	private String userId;
	private String userName;
	private WebSocketSession session;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
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
}
