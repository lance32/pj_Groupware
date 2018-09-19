package com.sp.boardManage;

public class BoardManage {
	private int boardNum;
	private String tableName;
	private String boardName;
	private int writePermit;
	private int canAnswer;
	private int canReply;
	private int canFile;
	private int canLike;
	private int subMenu;
	
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public int getWritePermit() {
		return writePermit;
	}
	public void setWritePermit(int writePermit) {
		this.writePermit = writePermit;
	}
	public int getCanAnswer() {
		return canAnswer;
	}
	public void setCanAnswer(int canAnswer) {
		this.canAnswer = canAnswer;
	}
	public int getCanReply() {
		return canReply;
	}
	public void setCanReply(int canReply) {
		this.canReply = canReply;
	}
	public int getCanFile() {
		return canFile;
	}
	public void setCanFile(int canFile) {
		this.canFile = canFile;
	}
	public int getCanLike() {
		return canLike;
	}
	public void setCanLike(int canLike) {
		this.canLike = canLike;
	}
	public int getSubMenu() {
		return subMenu;
	}
	public void setSubMenu(int subMenu) {
		this.subMenu = subMenu;
	}
}
