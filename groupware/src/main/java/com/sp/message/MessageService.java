package com.sp.message;

import java.util.List;
import java.util.Map;

public interface MessageService {
	public void insertMessage(Message msg) throws Exception;
	public void insertMessage2(Message msg) throws Exception;
	public List<Message> listMessage(Map<String, Object>map) throws Exception;
	public Message readMessage(int msgNum) throws Exception;
	public void updateReadTime(int msgNum) throws Exception;
	public void deleteMessage(int msgNum) throws Exception;
	public void setMsgKeep(int msgNum, int msgKeep) throws Exception;
	public int getDataCount(Map<String, Object> map) throws Exception;
}
