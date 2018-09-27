package com.sp.mail;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.member.SessionInfo;

@Controller("mail.controller")
public class MailController {
	@Autowired
	private MailSender mailSender;
	
	@Autowired
	private MailService mailService;
	
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
	
	// 메일 보내기
	@RequestMapping(value="/mail/send", method=RequestMethod.POST)
	public String writeMailSubmit(Mail mail, HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		mail.setSendName(info.getUserName());
		
		String msg = "<span style='color:blue;'>" + mail.getReceiveMail() + "</span> 님에게<br>";
		try {
			boolean send = mailSender.mailSend(mail);
			if (send) {
				msg += "메일을 성공적으로 전송 했습니다.";
			} else {
				msg += "메일을 전송하는데 실패하였습니다.";
			}
			mailService.insertMail(mail);
		} catch (Exception e) {
			msg = "오류가 발생했습니다. 관리자에게 문의해 주세요.(" + e.getMessage() + ")";
		}
		model.addAttribute("message", msg);
		
		return ".mail.complete";
	}
	
	// 메일 읽기
	@RequestMapping(value="/mail/mailForm", method=RequestMethod.GET)
	public String readMail(Model model) throws Exception {
		return ".mail.mailForm";
	}
}
