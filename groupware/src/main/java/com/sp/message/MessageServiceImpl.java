package com.sp.message;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("message.msgService")
public class MessageServiceImpl implements MessageService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertMessage(Message msg) throws Exception {
		dao.insertData("message.msgInsert", msg);
	}

	@Override
	public List<Message> listMessage() throws Exception {
		List<Message> list = dao.selectList("message.msgList");
		return list;
	}

}
