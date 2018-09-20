package com.sp.member;

public class OrganizationChart {
	int departmentNum;
	int parentDepartment;
	String parentDeptName;
	String departmentName;
	int deptGroup;
	int deptOrder;
	String memberNum;
	String name;
	String positionName;
	int positionStep;
	
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
