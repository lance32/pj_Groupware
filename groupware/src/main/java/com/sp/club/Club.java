package com.sp.club;

import org.springframework.web.multipart.MultipartFile;

public class Club {
	private int clubNum;
	private String clubName;		//이름
	private String clubSubject;	//주제
	private String clubIntro;		//소개글
	private String openDate;		//생성일
	private int maxPeople;
	private String memberNum;	//개설자 id
	private String memberName;	//개설자 이름
	private String clubImg;			//대표이미지
	private MultipartFile upload;
	private String joinMemberNum;	
	private String joinMemberName;	
	
	public int getClubNum() {
		return clubNum;
	}
	public void setClubNum(int clubNum) {
		this.clubNum = clubNum;
	}
	public String getClubName() {
		return clubName;
	}
	public void setClubName(String clubName) {
		this.clubName = clubName;
	}
	public String getClubSubject() {
		return clubSubject;
	}
	public void setClubSubject(String clubSubject) {
		this.clubSubject = clubSubject;
	}
	public String getClubIntro() {
		return clubIntro;
	}
	public void setClubIntro(String clubIntro) {
		this.clubIntro = clubIntro;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public int getMaxPeople() {
		return maxPeople;
	}
	public void setMaxPeople(int maxPeople) {
		this.maxPeople = maxPeople;
	}
	public String getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(String memberNum) {
		this.memberNum = memberNum;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getClubImg() {
		return clubImg;
	}
	public void setClubImg(String clubImg) {
		this.clubImg = clubImg;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public String getJoinMemberNum() {
		return joinMemberNum;
	}
	public void setJoinMemberNum(String joinMemberNum) {
		this.joinMemberNum = joinMemberNum;
	}
	public String getJoinMemberName() {
		return joinMemberName;
	}
	public void setJoinMemberName(String joinMemberName) {
		this.joinMemberName = joinMemberName;
	}
	
}

