package com.sp.message;

import java.util.List;

public interface MessageService {
	public void insertMessage(Message msg) throws Exception;
	public List<Message> listMessage() throws Exception;
}
