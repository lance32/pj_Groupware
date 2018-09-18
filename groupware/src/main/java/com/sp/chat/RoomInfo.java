package com.sp.chat;

import java.util.HashSet;
import java.util.Set;

public class RoomInfo {
	private String subject;          // 방제목
	private String founderName;		// 개설자 이름
	private int maxNumber;       	// 최대 인원수
	private Set<String> guestSet=new HashSet<>();	//채팅방 참여자
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getFounderName() {
		return founderName;
	}
	public void setFounderName(String founderName) {
		this.founderName = founderName;
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
