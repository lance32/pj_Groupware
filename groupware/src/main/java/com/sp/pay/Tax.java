package com.sp.pay;

public class Tax {
	private int deductNum; //번호
	private String deductName; //고용
	private float rate; //산재
	
	public int getDeductNum() {
		return deductNum;
	}
	public void setDeductNum(int deductNum) {
		this.deductNum = deductNum;
	}
	public String getDeductName() {
		return deductName;
	}
	public void setDeductName(String deductName) {
		this.deductName = deductName;
	}
	public float getRate() {
		return rate;
	}
	public void setRate(float rate) {
		this.rate = rate;
	}
	
}
