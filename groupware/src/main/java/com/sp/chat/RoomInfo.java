package com.sp.chat;

import java.util.HashSet;
import java.util.Set;

public class RoomInfo {
	private String subject;          	// 방제목
	private String userName;	// 개설자 이름  userName으로 바꾸기(개설자따로 안만듬.)
	private int maxNumber;       	// 최대 인원수
	private Set<String> guestSet=new HashSet<>();	//채팅방 참여자
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getMaxNumber() {
		return maxNumber;
	}
	public void setMaxNumber(int maxNumber) {
		this.maxNumber = maxNumber;
	}
	public Set<String> getGuestSet() {
		return guestSet;
	}
	public void setGuestSet(Set<String> guestSet) {
		this.guestSet = guestSet;
	}
}
