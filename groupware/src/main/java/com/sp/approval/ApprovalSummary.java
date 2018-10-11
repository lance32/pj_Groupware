package com.sp.approval;

public class ApprovalSummary {
	
	private int docuNum; //순서
	private String subject; // 제목
	private String documentState; // 문서상태
	private String created; //날짜
	public int getDocuNum() {
		return docuNum;
	}
	public void setDocuNum(int docuNum) {
		this.docuNum = docuNum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getDocumentState() {
		return documentState;
	}
	public void setDocumentState(String documentState) {
		this.documentState = documentState;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	
	
}
