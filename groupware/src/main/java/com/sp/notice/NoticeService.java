package com.sp.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	public int insertNotice(Notice dto, String pathname);
	public List<Notice> listNotice(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Notice readNotice(int num);
	public int updateHitCount(int num);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
	public int updateNotice(Notice dto, String pathname);
	public int deleteNotice(int num, String pathname, String memberNum);
	
	public int insertReply(Reply dto);
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public int deleteReply(Map<String, Object> map);
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
}
