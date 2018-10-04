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
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	private Map<String, Object> mailList(int currentPage, String searchKey, String searchValue, HttpServletRequest req, String type) throws Exception {
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
		if (type.equals("send")) {
			map.put("state", 0);
		} else if (type.equals("tempBox")) {
			map.put("state", 2);
		} else {
			map.put("state", 1);
		}
		
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
		String listUrl = cp + "/mail/";
		if (type.equals("send")) {
			listUrl += "mailSend";
		} else if (type.equals("tempBox")) {
			listUrl += "mailTrashbox";
		} else {
			listUrl += "mailTempBox";
		}
		
		String mailUrl = cp + "/mail/mailForm?page=" + currentPage;
		if (type.equals("tempBox"))
			mailUrl = cp + "/mail/mailWrite?page=" + currentPage;
		
		if (query.length() != 0) {
			listUrl = listUrl + "?" + query;
			mailUrl += "&" + query;
		}
		
		String paging = myUtil.paging(currentPage,  totalPage, listUrl);
		
		Map<String, Object>model = new HashMap<String, Object>();
		model.put("mailType", type);
		model.put("list", list);
		model.put("mailUrl", mailUrl);
		model.put("dataCount", dataCount);
		model.put("page", currentPage);
		model.put("totalPage", totalPage);
		model.put("paging", paging);
		
		return model;
	}
	
	// 보낸 편지함
	@RequestMapping(value="/mail/mailSend")
	public String mailForm(
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {

		Map<String, Object> list = mailList(currentPage, searchKey, searchValue, req, "send");
		for (String key : list.keySet()) {
			model.addAttribute(key, list.get(key));
		}
		return ".mail.mailBox";
	}
	
	// 받은 편지함
	@RequestMapping(value="/mail/mailReceive")
	public String receiveMail(Model model) throws Exception {
		model.addAttribute("mailType", "receive");
		return ".mail.mailBox";
	}
	
	// 임시보관함
	@RequestMapping(value="/mail/mailTempBox")
	public String tempMail(			
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		Map<String, Object> list = mailList(currentPage, searchKey, searchValue, req, "tempBox");
		for (String key : list.keySet()) {
			model.addAttribute(key, list.get(key));
		}
		
		return ".mail.mailBox";
	}
	
	// 휴지통
	@RequestMapping(value="/mail/mailTrashbox")
	public String trashMail(			
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		Map<String, Object> list = mailList(currentPage, searchKey, searchValue, req, "trashbox");
		for (String key : list.keySet()) {
			model.addAttribute(key, list.get(key));
		}
		return ".mail.mailBox";
	}
	
	// 메일  쓰기
	@RequestMapping(value="/mail/mailWrite", method=RequestMethod.GET)
	public String writeMail(
			@RequestParam(value="index", defaultValue="-1") long index,
			@RequestParam(value="mailType", defaultValue="") String mailType,
			Model model) throws Exception {
		
		if (index != -1) {
			Mail mail = mailService.readMail(index);
			if (mail == null)
				return "redirect:/mail/sendMail";
			
			model.addAttribute("mail", mail);
			model.addAttribute("mailType", mailType);
		}
		
		return ".mail.mailWrite";
	}
	
	// 메일 보내기
	@RequestMapping(value="/mail/send", method=RequestMethod.POST)
	public String writeMailSubmit(Mail mail,
			HttpSession session, 
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		mail.setSendName(info.getUserName());
		
		String msg = "";
		String title = "";
		if (mail.getState() == 0) {				// 상태(0:정상, 1:휴지통, 2:임시보관)
			title = "메일 발송";
			msg = "<span style='color:gray;'>" + mail.getReceiveMail() + "</span> 님에게<br>";
			try {
				boolean send = true; //mailSender.mailSend(mail);
				if (send) {
					msg += "메일을 성공적으로 전송 했습니다.";
				} else {
					msg += "메일을 전송하는데 실패하였습니다.";
				}
			} catch (Exception e) {
				msg = "오류가 발생했습니다. 관리자에게 문의해 주세요.(" + e.getMessage() + ")";
			}
		} else { // if (mail.getState() == 2) {
			title = "임시 보관";
			msg = "<span style='color:gray;'>메일을 임시보관함으로 이동하였습니다.</span>";
		}
		
		try {
			if (mail.getIndex() != -1) {
				// 임시 저장에서 메일 보내기를 한 경우, 임시 저장 메일은 삭제 처리
				mailService.deleteMail(mail.getIndex());
			}
			
			mailService.insertMail(mail);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("title", title);
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
		
		//mail.setContent(myUtil.htmlSymbols(mail.getContent()));
		
		model.addAttribute("mail", mail);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("mailType", mailType);
		
		return ".mail.mailForm";
	}
	
	// 메일 삭제
	@RequestMapping(value="/mail/mailDelete", method=RequestMethod.GET)
	public String deleteMail(
			@RequestParam(value="mailIndex") Long[] index, 
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@RequestParam(value="mailType", defaultValue="send") String mailType
			) throws Exception {
		for (int i = 0; i < index.length; i++) {
			mailService.deleteMail(index[i]);
		}
		
		String redirect = "redirect:/mail/mailSend";
		if (mailType.equals("tempBox")) {
			redirect = "redirect:/mail/mailTempBox";
		} else if (mailType.equals("trashbox")) {
			redirect = "redirect:/mail/mailTrashbox";
		}
		redirect += "?page=" + page;
		if (!searchValue.isEmpty())
			redirect += "&searchKey=" + searchKey + "&searchValue=" + searchValue;
		
		return redirect;
	}
	
	// 메일 휴지통으로
	@RequestMapping(value="/mail/toMailTrashbox", method=RequestMethod.GET)
	public String toTrashbox(@RequestParam(value="mailIndex") Long[] index,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			) throws Exception {
		for (int i = 0; i < index.length; i++) {
			mailService.updateMail(index[i], 1);		// 상태(0:정상, 1:휴지통, 2:임시보관)
		}
		
		return "redirect:/mail/mailSend?page=" + page + "&searckKey=" + searchKey + "&searchValue=" + searchValue;
	}
	
	// 메일 복원
	@RequestMapping(value="/mail/toMailSend", method=RequestMethod.GET)
	public String toMailSend(@RequestParam(value="mailIndex") Long[] index,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			) throws Exception {
		for (int i = 0; i < index.length; i++) {
			mailService.updateMail(index[i], 0);		// 상태(0:정상, 1:휴지통, 2:임시보관)
		}
		
		return "redirect:/mail/mailTrashbox?page=" + page + "&searckKey=" + searchKey + "&searchValue=" + searchValue;
	}
	
	// 메일 카운트
	@RequestMapping(value="/mail/mailCount", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getMailCount(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> model = new HashMap<String, Object>();
		if (info != null) {
			String memberNum = info.getUserId();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberNum", memberNum);
			map.put("state", 0);				// 보낸 메일 개수
			int send = (int)mailService.dataCount(map);
			
			map.put("state", 1);				// 휴지통 메일 개수
			int trashbox = (int)mailService.dataCount(map);
			
			map.put("state", 2);				// 임시보관 메일 개수
			int tempBox = (int)mailService.dataCount(map);
			
			model.put("send", send);
			model.put("trashbox", trashbox);
			model.put("tempBox", tempBox);
		}
		
		return model;
	}
}
