package com.sp.boardManage;

import java.util.List;

public interface BoardManageService {
	public int createBoardManage(BoardManage dto);
	public int dataCount();
	public List<BoardManage> listBoardManage();
	public BoardManage readBoardManage(int num);
	public BoardManage readBoardManage(String board);
	public int updateBoardManage(BoardManage dto, String pathname);
	public int deleteBoardManage(int num, String pathname);
}
