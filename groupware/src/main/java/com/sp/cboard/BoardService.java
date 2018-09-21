package com.sp.cboard;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public int insertBoard(Board dto, String mode, String pathname);
	public int dataCount(Map<String, Object> map);
	public List<Board> listBoard(Map<String, Object> map);
	public int updateHitCount(Map<String, Object> map);
	public Board readBoard(Map<String, Object> map);
	public Board preReadBoard(Map<String, Object> map);
	public Board nextReadBoard(Map<String, Object> map);
	public int updateBoard(Board dto, String pathname);
	public int deleteBoard(Map<String, Object> map);
	public int insertBoardLike(Board dto);
	public int boardLikeCount(Map<String, Object> map);
	
	public int insertFile(Board dto);
	public List<Board> listFile(Map<String, Object> map);
	public Board readFile(Map<String, Object> map);
	public int deleteFile(Map<String, Object> map);
	
	public int insertReply(Reply dto);
	public List<Reply> listReply(Map<String, Object> map);
	public List<Reply> listReplyAnswer(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	public int deleteReply(Map<String, Object> map);

}
