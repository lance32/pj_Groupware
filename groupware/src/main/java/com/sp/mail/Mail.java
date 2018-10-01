package com.sp.mail;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

@Document(collection = "mail")
public class Mail {
	@Id
	private long index;					// 키
	private String memberNum;			// 보낸 사람 사번
	private String receiveMail;			// 받는 사람 이메일
	private String sendMail;			// 보낸 사람 이메일
	private String sendName;			// 보낸 사람 이름
	private String subject;				// 제목
	private String content;				// 내용
	private String cc;					// 참조
	private String bcc;					// 숨은 참조
//	private List<MultipartFile> upload;
//	private List<String> savePathname = new ArrayList<String>();
	private MultipartFile upload;
	private String savePathname;
	@DateTimeFormat(iso=ISO.DATE_TIME)
	private Date sendTime;				// 보낸 날짜
	private int state;					// 상태(0:정상, 1:휴지통, 2:임시보관)
	
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	public String getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(String memberNum) {
		this.memberNum = memberNum;
	}
	public long getIndex() {
		return index;
	}
	public void setIndex(long index) {
		this.index = index;
	}
	public String getCc() {
		return cc;
	}
	public void setCc(String cc) {
		this.cc = cc;
	}
	public String getBcc() {
		return bcc;
	}
	public void setBcc(String bcc) {
		this.bcc = bcc;
	}
	public String getReceiveMail() {
		return receiveMail;
	}
	public void setReceiveMail(String receiveMail) {
		this.receiveMail = receiveMail;
	}
	public String getSendMail() {
		return sendMail;
	}
	public void setSendMail(String sendMail) {
		this.sendMail = sendMail;
	}
	public String getSendName() {
		return sendName;
	}
	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
//	public List<MultipartFile> getUpload() {
//		return upload;
//	}
//	public void setUpload(List<MultipartFile> upload) {
//		this.upload = upload;
//	}
//	public List<String> getSavePathname() {
//		return savePathname;
//	}
//	public void setSavePathname(List<String> savePathname) {
//		this.savePathname = savePathname;
//	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public String getSavePathname() {
		return savePathname;
	}
	public void setSavePathname(String savePathname) {
		this.savePathname = savePathname;
	}
	public String getFormatSendTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return sdf.format(sendTime);
	}
}
