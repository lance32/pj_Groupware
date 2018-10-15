package com.sp.department;

public class Department {
	private int departmentNum;
	private int parentDepartment;
	private String departmentName;
	private int departmentType;
	private int deptOrder;
	private int deptGroup;
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
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public int getDepartmentType() {
		return departmentType;
	}
	public void setDepartmentType(int departmentType) {
		this.departmentType = departmentType;
	}
	public int getDeptOrder() {
		return deptOrder;
	}
	public void setDeptOrder(int deptOrder) {
		this.deptOrder = deptOrder;
	}
	public int getDeptGroup() {
		return deptGroup;
	}
	public void setDeptGroup(int deptGroup) {
		this.deptGroup = deptGroup;
	}
	@Override
	public String toString() {
		return "Department [departmentNum=" + departmentNum + ", parentDepartment=" + parentDepartment
				+ ", departmentName=" + departmentName + ", departmentType=" + departmentType + ", deptOrder="
				+ deptOrder + ", deptGroup=" + deptGroup + "]";
	}
}
