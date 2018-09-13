package com.sp.notice;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.member.SessionInfo;

@Controller("notice.NoticeController")
public class NoticeController {

	@Autowired
	private NoticeService service;
	
//	@Autowired
//	private MyUtil util;
	
//	@Autowired
//	private FileManager fileManager;
	
	@RequestMapping(value="/notice/list")
	public String list() {
		return ".notice.list";
	}
	
	@RequestMapping(value="/notice/created", method=RequestMethod.GET)
	public String createForm(
			Model model,
			HttpSession session
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(! info.getUserId().equals("admin")) {
			return "redirect:/notice/list";
		}
		model.addAttribute("mode", "created");
		return ".notice.created";
	}
	
	@RequestMapping(value="/notice/created", method=RequestMethod.POST)
	public String createSubmit(
			Notice dto,
			HttpSession session) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info.getUserId().equals("admin")) {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"notice";
			dto.setMemberNum(info.getUserId());
			service.insertNotice(dto, pathname);
		}
		return "redirect:/notice/list";
	}
	
}
