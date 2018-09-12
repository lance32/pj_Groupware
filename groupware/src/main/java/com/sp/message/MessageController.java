package com.sp.message;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("message.controller")
public class MessageController {
	@RequestMapping(value="/message/msgWrite", method=RequestMethod.GET)
	public String write() throws Exception {
		return ".message.msgWrite";
	}
	
	@RequestMapping(value="/message/msgReceive", method=RequestMethod.GET)
	public String receiveList() throws Exception {
		return ".message.msgBox";
	}
	
	@RequestMapping(value="/message/msgSend", method=RequestMethod.GET)
	public String sendList() throws Exception {
		return ".message.msgBox";
	}
	
	@RequestMapping(value="/message/msg", method=RequestMethod.GET)
	public String list() throws Exception {
		return ".message.msgBox";
	}	
}
