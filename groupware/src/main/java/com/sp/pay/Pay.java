package com.sp.pay;

public class Pay {
	private int listNum;
	
	private String memberNum;
	private String name;
	
	//지급 연월일
	private int year;
	private int month;
	private int day;
	
	//기본급 , 수당
	private int basicpay;
	private int extrapay;
	
	//세금 
	private int healthTax; //건강
	private int employTax; //고용
	private int accidentTax; //산재
	private int pensionTax; //국민
	private int incomeTax; //소득
	private int realPay; //실수령액
	//부서 직급 정보
	private String departmentName;
	private String positionName;
	
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
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public int getRealPay() {
		return realPay;
	}
	public void setRealPay(int realPay) {
		this.realPay = realPay;
	}
	public String getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(String memberNum) {
		this.memberNum = memberNum;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getBasicpay() {
		return basicpay;
	}
	public void setBasicpay(int basicpay) {
		this.basicpay = basicpay;
	}
	public int getExtrapay() {
		return extrapay;
	}
	public void setExtrapay(int extrapay) {
		this.extrapay = extrapay;
	}
	public int getHealthTax() {
		return healthTax;
	}
	public void setHealthTax(int healthTax) {
		this.healthTax = healthTax;
	}
	public int getEmployTax() {
		return employTax;
	}
	public void setEmployTax(int employTax) {
		this.employTax = employTax;
	}
	public int getAccidentTax() {
		return accidentTax;
	}
	public void setAccidentTax(int accidentTax) {
		this.accidentTax = accidentTax;
	}
	public int getPensionTax() {
		return pensionTax;
	}
	public void setPensionTax(int pensionTax) {
		this.pensionTax = pensionTax;
	}
	public int getIncomeTax() {
		return incomeTax;
	}
	public void setIncomeTax(int incomeTax) {
		this.incomeTax = incomeTax;
	}
	
}
