package com.sp.message;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("message.controller")
public class MessageController {
	// 쪽지 쓰기
	@RequestMapping(value="/message/msgWrite", method=RequestMethod.GET)
	public String write() throws Exception {
		return ".message.msgWrite";
	}
	
	// 받은 쪽지
	@RequestMapping(value="/message/msgReceive", method=RequestMethod.GET)
	public String receiveList(Model model) throws Exception {
		model.addAttribute("msgType", "receive");
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
