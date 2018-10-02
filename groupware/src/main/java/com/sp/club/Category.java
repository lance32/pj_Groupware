package com.sp.club;

public class Category {
	private int categoryNum;
	private String categoryName;
	private int categoryParent;
	
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getCategoryParent() {
		return categoryParent;
	}
	public void setCategoryParent(int categoryParent) {
		this.categoryParent = categoryParent;
	}
}
