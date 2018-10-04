package com.sp.clubBoard;

public class Category {
	private int clubNum;
	private int categoryNum;
	private String categoryName;
	private Integer categoryParent;
	
	public int getClubNum() {
		return clubNum;
	}
	public void setClubNum(int clubNum) {
		this.clubNum = clubNum;
	}
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
	public Integer getCategoryParent() {
		return categoryParent;
	}
	public void setCategoryParent(Integer categoryParent) {
		this.categoryParent = categoryParent;
	}
}
