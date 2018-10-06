package com.sp.clubBoard;

import java.util.List;
import java.util.Map;

public interface ClubBoardService {
	public int insertClubBoard(Board dto, String pathname);
	public List<Board> listClubBoard(Map<String, Object> map);
	public int clubBoardCount(Map<String, Object> map);
	public int deleteClubBoard(int boardNum, String saveFilename, String pathname);
	public Board readClubBoard(int boardNum);
	public int updateClubBoard(Board dto, String pathname, String isDeleteFile);
	
	public int insertReply(Reply dto);
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public int deleteReply(int replyNum);
	public int insertReplyAnswer(Reply dto);
	public List<Reply> listReplyAnswer(int answer);
	
	public int insertBoardLike(Map<String, Object> map);
	public int boardLikeCount(int boardNum);
	public int deleteBoardLike(Map<String, Object> map);
	public String isBoardLike(Map<String, Object> map);
	
}
