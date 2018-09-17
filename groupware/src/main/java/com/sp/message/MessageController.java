package com.sp.message;

import java.net.URLDecoder;
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
		//logger.debug(">> " + info.getUserId());
		service.insertMessage(msg);
		
//		model.addAttribute("msgType", "send");
		return "redirect:/message/msgSend";
	}
	
	// 받은 쪽지
	@RequestMapping(value="/message/msgReceive", method=RequestMethod.GET)
	public String receiveList(
			@RequestParam(value="page", defaultValue="1") String currentPage,
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
		
		logger.info(">>>>>>>>>>> datacount : " + dataCount);
		
		List<Message>list = service.listMessage(map);
		
		model.addAttribute("msgType", "receive");
		model.addAttribute("list", list);
		
		return ".message.msgBox";
	}
	
	// 보낸 쪽지
	@RequestMapping(value="/message/msgSend", method=RequestMethod.GET)
	public String sendList(HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("type", "send");
		map.put("memberNum", info.getUserId());
		
		List<Message>list = service.listMessage(map);
		model.addAttribute("msgType", "send");
		model.addAttribute("list", list);
		
		return ".message.msgBox";
	}
	
	// 보관 쪽지
	@RequestMapping(value="/message/msgKeep", method=RequestMethod.GET)
	public String list(HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNum", info.getUserId());
		map.put("keep", 1);
		
		List<Message>list = service.listMessage(map);
		model.addAttribute("list", list);
		model.addAttribute("msgType", "keep");
		
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
		msg.setContent(myUtil.htmlSymbols(msg.getContent()));
		
		model.addAttribute("msgType", msgType);
		model.addAttribute("msg", msg);
		
		return ".message.msgForm";
	}
	
	// 쪽지 삭제
	@RequestMapping(value="/message/msgDelete", method=RequestMethod.GET)
	public String delete(@RequestParam(value="msgNum") int msgNum, @RequestParam(value="msgType") String msgType) throws Exception {
		service.deleteMessage(msgNum);
		
		if (msgType.equalsIgnoreCase("send"))
			return "redirect:/message/msgSend";
		
		return "redirect:/message/msgReceive";
	}
	
	// 쪽지 보관
	@RequestMapping(value="/message/setMsgKeep", method=RequestMethod.GET)
	public String keep(@RequestParam(value="msgNum") int msgNum, @RequestParam(value="msgKeep") int msgKeep) throws Exception {
		service.setMsgKeep(msgNum, msgKeep);
		return "redirect:/message/msgKeep";
	}
}
