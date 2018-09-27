package com.sp.member;

// 세션에 저장할 정보를 가진 클래스
public class SessionInfo {
	private String userId;
	private String userName;
	private int memberLevel;
	
	private int departmentNum;
	private String departmentName;
	private String positionName;
	
	private String saveFilename;
	private String originalFilename;
	
	public int getDepartmentNum() {
		return departmentNum;
	}
	public void setDepartmentNum(int departmentNum) {
		this.departmentNum = departmentNum;
	}
	
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
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
	public int getMemberLevel() {
		return memberLevel;
	}
	public void setMemberLevel(int memberLevel) {
		this.memberLevel = memberLevel;
	}
}
