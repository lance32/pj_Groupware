package com.sp.mail;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("mail.controller")
public class MailController {
	@Autowired
	private MailSender mailSender;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private MyUtil myUtil;
	
	// 보낸 편지함
	@RequestMapping(value="/mail/mailSend", method=RequestMethod.GET)
	public String mailForm(
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		int rows = 10;
		int totalPage = 0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("memberNum", info.getUserId());
		
		int dataCount = (int)mailService.dataCount(map);
		if (dataCount != 0) 
			totalPage = myUtil.pageCount(rows, dataCount);
		
		if (totalPage < currentPage) 
			currentPage = totalPage;
		
		int start = (currentPage - 1) * rows + 1;
		int end = currentPage * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Mail>list = mailService.list(map);
		
		String query = "";
		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		String cp = req.getContextPath();
		String listUrl = cp + "/mail/mailSend";
		String mailUrl = cp + "/mail/mailForm?page=" + currentPage;
		if (query.length() != 0) {
			listUrl = listUrl + "?" + query;
			mailUrl += "&" + query;
		}
		
		String paging = myUtil.paging(currentPage,  totalPage, listUrl);
		
		model.addAttribute("mailType", "send");
		model.addAttribute("list", list);
		model.addAttribute("mailUrl", mailUrl);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", currentPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("paging", paging);
		
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
			boolean send = true;// mailSender.mailSend(mail);
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
	public String readMail(
			@RequestParam(value="index") long index,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@RequestParam(value="mailType", defaultValue="send") String mailType,
			HttpServletRequest req,
			Model model) throws Exception {
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		String query = "page=" + page;
		if (searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		Mail mail = mailService.readMail(index);
		if (mail == null)
			return "redirect:/mail/mailSend?" + query;
		
		mail.setContent(myUtil.htmlSymbols(mail.getContent()));
		
		model.addAttribute("mail", mail);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("mailType", mailType);
		
		return ".mail.mailForm";
	}
}
