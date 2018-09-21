package com.sp.mail;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("mail.controller")
public class MailController {
	// 보낸 편지함
	@RequestMapping(value="/mail/mailSend", method=RequestMethod.GET)
	public String mailForm(Model model) throws Exception {
		model.addAttribute("mailType", "send");
		return ".mail.mailBox";
	}
	
	// 받은 편지함
	@RequestMapping(value="/mail/mailReceive", method=RequestMethod.GET)
	public String receiveMail(Model model) throws Exception {
		model.addAttribute("mailType", "receive");
		return ".mail.mailBox";
	}
	
	// 임시보관함
	@RequestMapping(value="/mail/mailTemp", method=RequestMethod.GET)
	public String tempMail(Model model) throws Exception {
		model.addAttribute("mailType", "temp");
		return ".mail.mailBox";
	}
	
	// 휴지통
	@RequestMapping(value="/mail/mailTrashbox", method=RequestMethod.GET)
	public String trashMail(Model model) throws Exception {
		model.addAttribute("mailType", "trash");
		return ".mail.mailBox";
	}
	
	// 메일  쓰기
	@RequestMapping(value="/mail/mailWrite", method=RequestMethod.GET)
	public String writeMail(Model model) throws Exception {
		return ".mail.mailWrite";
	}
	
	// 메일 읽기
	@RequestMapping(value="/mail/mailForm", method=RequestMethod.GET)
	public String readMail(Model model) throws Exception {
		return ".mail.mailForm";
	}
}
