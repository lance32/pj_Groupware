package com.sp.message;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<Message> listMessage(Map<String, Object>map) throws Exception {
		List<Message> list = dao.selectList("message.msgList", map);
		return list;
	}

	@Override
	public Message readMessage(int msgNum) throws Exception {
		return dao.selectOne("message.msgRead", msgNum);
	}

	@Override
	public void updateReadTime(int msgNum) throws Exception {
		dao.updateData("message.msgUpdateReadTime", msgNum);
	}

	@Override
	public void deleteMessage(int msgNum) throws Exception {
		dao.deleteData("message.msgDelete", msgNum);
	}

	@Override
	public void setMsgKeep(int msgNum, int msgKeep) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgNum", msgNum);
		map.put("msgKeep", msgKeep);
		
		dao.updateData("message.msgSetMsgKeep", map);
	}

	@Override
	public int getDataCount(Map<String, Object> map) throws Exception {
		return dao.selectOne("message.msgCount", map);
	}
}
