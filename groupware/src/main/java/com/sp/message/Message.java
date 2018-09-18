package com.sp.message;

public class Message {
	private int msgNum;
	private String subject;
	private String content;
	private String sendTime;
	private String readTime;
	private int msgKeep;
	private String sendMember;
	private String sendMemberName;
	private String toMember;
	private String toMemberName;
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getSendMemberName() {
		return sendMemberName;
	}
	public void setSendMemberName(String sendMemberName) {
		this.sendMemberName = sendMemberName;
	}
	public String getToMemberName() {
		return toMemberName;
	}
	public void setToMemberName(String toMemberName) {
		this.toMemberName = toMemberName;
	}
	public int getMsgNum() {
		return msgNum;
	}
	public void setMsgNum(int msgNum) {
		this.msgNum = msgNum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public String getReadTime() {
		return readTime;
	}
	public void setReadTime(String readTime) {
		this.readTime = readTime;
	}
	public int getMsgKeep() {
		return msgKeep;
	}
	public void setMsgKeep(int msgKeep) {
		this.msgKeep = msgKeep;
	}
	public String getSendMember() {
		return sendMember;
	}
	public void setSendMember(String sendMember) {
		this.sendMember = sendMember;
	}
	public String getToMember() {
		return toMember;
	}
	public void setToMember(String toMember) {
		this.toMember = toMember;
	}
}
