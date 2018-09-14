package com.sp.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("chat.chattingController")
public class ChattingController {

	@RequestMapping(value="/chat/chatList")
	public String chatList(){
		return ".chat.chatList";
	}
	@RequestMapping(value="/chat/chatList2")
	public String chatList2(){
		return ".chat.chatList_2";
	}
}
