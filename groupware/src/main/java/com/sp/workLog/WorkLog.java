package com.sp.workLog;

public class WorkLog {
	private int workLogNum;
	private int listNum;
	private String name;
	private String departmentName;
	private String memberNum;
	private String makeDate;
	private String subject;
	private String todayWork;
	private String nextdayWork;
	private String memo;
	
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public int getWorkLogNum() {
		return workLogNum;
	}
	public void setWorkLogNum(int workLogNum) {
		this.workLogNum = workLogNum;
	}
	public String getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(String memberNum) {
		this.memberNum = memberNum;
	}
	public String getMakeDate() {
		return makeDate;
	}
	public void setMakeDate(String makeDate) {
		this.makeDate = makeDate;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getTodayWork() {
		return todayWork;
	}
	public void setTodayWork(String todayWork) {
		this.todayWork = todayWork;
	}
	public String getNextdayWork() {
		return nextdayWork;
	}
	public void setNextdayWork(String nextdayWork) {
		this.nextdayWork = nextdayWork;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}
