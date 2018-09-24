package com.sp.message;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("message.controller")
public class MessageController {
	private final Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@Autowired
	private MessageService service;
	@Autowired
	private MyUtil myUtil;
	
	// 쪽지 쓰기
	@RequestMapping(value="/message/msgWrite", method=RequestMethod.GET)
	public String write() throws Exception {
		return ".message.msgWrite";
	}
	
	@RequestMapping(value="/message/msgWrite", method=RequestMethod.POST)
	public String writeSubmit(Message msg, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		msg.setSendMember(info.getUserId());
		
		String[] members = msg.getToMember().split(";");
		for (int i = 0; i < members.length; i++) {
			msg.setToMember(members[i]);
			service.insertMessage(msg);
		}
		
		return "redirect:/message/msgSend";
	}
	
	// 받은 쪽지
	@RequestMapping(value="/message/msgReceive")
	public String receiveList(
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int rows = 10;
		int totalPage = 0;
		int dataCount = 0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		map.put("memberNum", info.getUserId());
		map.put("type", "receive");

		dataCount = service.getDataCount(map);

		if (dataCount != 0)
			totalPage = myUtil.pageCount(rows, dataCount);
		
		if (totalPage< currentPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * rows + 1;
		int end = currentPage * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Message>list = service.listMessage(map);

		String query = "";
		String cp = req.getContextPath();
		String listUrl = cp + "/message/msgReceive";
		String articleUrl = cp + "/message/msgRead?page=" + currentPage;
		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		if (query.length() != 0) {
			listUrl = cp + "/message/msgRecevice?" + query;
			articleUrl = cp + "/message/msgForm?page=" + currentPage + "&" + query;
		}
		
		String paging = myUtil.paging(currentPage, totalPage, listUrl);
		
		model.addAttribute("msgType", "receive");
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", currentPage);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("paging", paging);
		
		return ".message.msgBox";
	}
	
	// 보낸 쪽지
	@RequestMapping(value="/message/msgSend")
	public String sendList(			
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int rows = 10;
		int totalPage = 0;
		int dataCount = 0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		map.put("memberNum", info.getUserId());
		map.put("type", "send");

		dataCount = service.getDataCount(map);

		if (dataCount != 0)
			totalPage = myUtil.pageCount(rows, dataCount);
		
		if (totalPage< currentPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * rows + 1;
		int end = currentPage * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Message>list = service.listMessage(map);

		String query = "";
		String cp = req.getContextPath();
		String listUrl = cp + "/message/msgSend";
		String articleUrl = cp + "/message/msgRead?page=" + currentPage;
		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		if (query.length() != 0) {
			listUrl = cp + "/message/msgSend?" + query;
			articleUrl = cp + "/message/msgForm?page=" + currentPage + "&" + query;
		}
		
		String paging = myUtil.paging(currentPage, totalPage, listUrl);
		
		model.addAttribute("msgType", "send");
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", currentPage);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("paging", paging);
		
		return ".message.msgBox";
	}
	
	// 보관 쪽지
	@RequestMapping(value="/message/msgKeep")
	public String list(
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int rows = 10;
		int totalPage = 0;
		int dataCount = 0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		map.put("memberNum", info.getUserId());
		map.put("type", "keep");

		dataCount = service.getDataCount(map);

		if (dataCount != 0)
			totalPage = myUtil.pageCount(rows, dataCount);
		
		if (totalPage< currentPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * rows + 1;
		int end = currentPage * rows;
		map.put("start", start);
		map.put("end", end);
		map.put("keep", 1);
		
		List<Message>list = service.listMessage(map);

		String query = "";
		String cp = req.getContextPath();
		String listUrl = cp + "/message/msgKeep";
		String articleUrl = cp + "/message/msgRead?page=" + currentPage;
		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		if (query.length() != 0) {
			listUrl = cp + "/message/msgKeep?" + query;
			articleUrl = cp + "/message/msgForm?page=" + currentPage + "&" + query;
		}
		
		String paging = myUtil.paging(currentPage, totalPage, listUrl);
		
		model.addAttribute("msgType", "keep");
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", currentPage);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("paging", paging);

		return ".message.msgBox";
	}
	
	// 쪽지 읽기
	@RequestMapping(value="/message/msgRead", method=RequestMethod.GET)
	public String read(@RequestParam(value="msgNum") int msgNum,
					   @RequestParam(value="memberNum") String memberNum,
					   @RequestParam(value="msgType", defaultValue="receive") String msgType,
					   HttpSession session,
					   Model model) throws Exception {
		// 읽은 시간 업데이트(받는 사람이)
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if (!info.getUserId().equals(memberNum))
			service.updateReadTime(msgNum);
		
		Message msg = service.readMessage(msgNum);
//		msg.setContent(myUtil.htmlSymbols(msg.getContent()));
		
		model.addAttribute("msgType", msgType);
		model.addAttribute("msgNum", msgNum);
		model.addAttribute("msg", msg);
		
		return ".message.msgForm";
	}
	
	// 쪽지 삭제
	@RequestMapping(value="/message/msgDelete", method=RequestMethod.GET)
	public String delete(
			@RequestParam(value="msgNum") Integer[] msgNum, 
			@RequestParam(value="msgType") String msgType
	) throws Exception {
		for (int i = 0; i < msgNum.length; i++) {
			service.deleteMessage(msgNum[i]);
		}
		
		if (msgType.equalsIgnoreCase("send"))
			return "redirect:/message/msgSend";
		else if (msgType.equalsIgnoreCase("receive"))
			return "redirect:/message/msgReceive";
		else 
			return "redirect:/message/msgKeep";
	}
	
	// 쪽지 보관
	@RequestMapping(value="/message/setMsgKeep", method=RequestMethod.GET)
	public String keep(
			@RequestParam(value="msgNum") Integer[] msgNum, 
			@RequestParam(value="msgKeep", defaultValue="1") int msgKeep
		) throws Exception {
		for (int i = 0; i < msgNum.length; i++) {
			service.setMsgKeep(msgNum[i], msgKeep);
		}
		
		return "redirect:/message/msgKeep";
	}
	
	// 쪽지 카운트
	@RequestMapping(value="/message/getMessageCount", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> countMessage(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNum", info.getUserId());
		map.put("type", "send");
		int send = service.getDataCount(map);
		
		map.put("type", "receive");
		int receive = service.getDataCount(map);
		
		map.put("type", "keep");
		int keep = service.getDataCount(map);
		
		map.put("type", "unread");
		int unread = service.getDataCount(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("send", send);
		model.put("receive", receive);
		model.put("unread", unread);
		model.put("keep", keep);
		
		
		return model;
	}
}
