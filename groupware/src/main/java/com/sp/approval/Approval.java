package com.sp.approval;

public class Approval {
	/*결재 문서*/
	private int docuNum;
	private int docuTypeNum;
	private String subject;
	private String content;
	private int retentionPeriod;
	private int documentState;
	private String created;
	private String modified;
	private String memberNum;
	
	/*문서분류*/
	private String docuName;
	private String docuForm;
	
	/*결재*/
	private int approvalNum;
	private int approvalSeq;
	private int result;
	
	/*결재 단계*/
	private String approvalDate;
	private String comments;
	private int approvalState;
	
	/*결재라인*/
	private int templateNum;
	private String templateName;
	private String approver;
	public int getDocuNum() {
		return docuNum;
	}
	public void setDocuNum(int docuNum) {
		this.docuNum = docuNum;
	}
	public int getDocuTypeNum() {
		return docuTypeNum;
	}
	public void setDocuTypeNum(int docuTypeNum) {
		this.docuTypeNum = docuTypeNum;
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
	public int getRetentionPeriod() {
		return retentionPeriod;
	}
	public void setRetentionPeriod(int retentionPeriod) {
		this.retentionPeriod = retentionPeriod;
	}
	public int getDocumentState() {
		return documentState;
	}
	public void setDocumentState(int documentState) {
		this.documentState = documentState;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getModified() {
		return modified;
	}
	public void setModified(String modified) {
		this.modified = modified;
	}
	public String getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(String memberNum) {
		this.memberNum = memberNum;
	}
	public String getDocuName() {
		return docuName;
	}
	public void setDocuName(String docuName) {
		this.docuName = docuName;
	}
	public String getDocuForm() {
		return docuForm;
	}
	public void setDocuForm(String docuForm) {
		this.docuForm = docuForm;
	}
	public int getApprovalNum() {
		return approvalNum;
	}
	public void setApprovalNum(int approvalNum) {
		this.approvalNum = approvalNum;
	}
	public int getApprovalSeq() {
		return approvalSeq;
	}
	public void setApprovalSeq(int approvalSeq) {
		this.approvalSeq = approvalSeq;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public String getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public int getApprovalState() {
		return approvalState;
	}
	public void setApprovalState(int approvalState) {
		this.approvalState = approvalState;
	}
	public int getTemplateNum() {
		return templateNum;
	}
	public void setTemplateNum(int templateNum) {
		this.templateNum = templateNum;
	}
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	
	

}
