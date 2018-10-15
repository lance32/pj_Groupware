package com.sp.member;

public class OrganizationChart {
	private int departmentNum;
	private int parentDepartment;
	private String parentDeptName;
	private String departmentName;
	private int deptGroup;
	private int deptOrder;
	private String memberNum;
	private String name;
	private String positionName;
	private int positionStep;
	private int idx;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getDepartmentNum() {
		return departmentNum;
	}
	public void setDepartmentNum(int departmentNum) {
		this.departmentNum = departmentNum;
	}
	public int getParentDepartment() {
		return parentDepartment;
	}
	public void setParentDepartment(int parentDepartment) {
		this.parentDepartment = parentDepartment;
	}
	public String getParentDeptName() {
		return parentDeptName;
	}
	public void setParentDeptName(String parentDeptName) {
		this.parentDeptName = parentDeptName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public int getDeptGroup() {
		return deptGroup;
	}
	public void setDeptGroup(int deptGroup) {
		this.deptGroup = deptGroup;
	}
	public int getDeptOrder() {
		return deptOrder;
	}
	public void setDeptOrder(int deptOrder) {
		this.deptOrder = deptOrder;
	}
	public String getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(String memberNum) {
		this.memberNum = memberNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public int getPositionStep() {
		return positionStep;
	}
	public void setPositionStep(int positionStep) {
		this.positionStep = positionStep;
	}
	@Override
	public String toString() {
		return "OrganizationChart [departmentNum=" + departmentNum + ", parentDepartment=" + parentDepartment
				+ ", parentDeptName=" + parentDeptName + ", departmentName=" + departmentName + ", deptGroup="
				+ deptGroup + ", deptOrder=" + deptOrder + ", memberNum=" + memberNum + ", name=" + name
				+ ", positionName=" + positionName + ", positionStep=" + positionStep + "]";
	}
}
