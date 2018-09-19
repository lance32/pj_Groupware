package com.sp.mail;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("mail.controller")
public class MailController {
	@RequestMapping(value="/mail/mailSend", method=RequestMethod.GET)
	public String mailForm() throws Exception {
		return ".mail.mailForm";
	}
	
	@RequestMapping(value="/mail/mailSend", method=RequestMethod.POST)
	public String sendMail() throws Exception {
		return ".mail.mailList";
	}
	
	@RequestMapping(value="/mail/mailReceive", method=RequestMethod.GET)
	public String receiveMail() throws Exception {
		return ".mail.mailBox";
	}
}
