package com.sp.message;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.member.SessionInfo;

@Controller("message.controller")
public class MessageController {
	private final Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@Autowired
	private MessageService service;
	
	// 쪽지 쓰기
	@RequestMapping(value="/message/msgWrite", method=RequestMethod.GET)
	public String write() throws Exception {
		return ".message.msgWrite";
	}
	
	@RequestMapping(value="/message/msgWrite", method=RequestMethod.POST)
	public String writeSubmit(Message msg, Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		msg.setSendMember(info.getUserId());
		logger.debug(">> " + info.getUserId());
		service.insertMessage(msg);
		
		model.addAttribute("msgType", "send");
		return ".message.msgBox";
	}
	
	// 받은 쪽지
	@RequestMapping(value="/message/msgReceive", method=RequestMethod.GET)
	public String receiveList(Model model) throws Exception {
		List<Message>list = service.listMessage();
		model.addAttribute("msgType", "receive");
		model.addAttribute("list", list);
		
		return ".message.msgBox";
	}
	
	// 보낸 쪽지
	@RequestMapping(value="/message/msgSend", method=RequestMethod.GET)
	public String sendList(Model model) throws Exception {
		model.addAttribute("msgType", "send");
		return ".message.msgBox";
	}
	
	// 보관 쪽지
	@RequestMapping(value="/message/msgKeep", method=RequestMethod.GET)
	public String list(Model model) throws Exception {
		model.addAttribute("msgType", "keep");
		return ".message.msgBox";
	}	
}
