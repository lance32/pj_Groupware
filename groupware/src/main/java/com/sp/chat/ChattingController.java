package com.sp.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("chat.chattingController")
public class ChattingController {

	@RequestMapping(value="/chat/chatList")
	public String chatList(){
		return ".chat.chatList";
	}
}
