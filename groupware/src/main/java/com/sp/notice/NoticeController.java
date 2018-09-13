package com.sp.notice;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
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

import com.sp.common.FileManager;
import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("notice.NoticeController")
public class NoticeController {

	@Autowired
	private NoticeService service;
	
	@Autowired
	private MyUtil util;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/notice/list")
	public String list(
			Map<String, Object> paramMap,
			HttpServletRequest req,
			Model model,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue) throws Exception {
		
		int rows = 5;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		paramMap.put("searchKey", searchKey);
		paramMap.put("searchValue", searchValue);
		
		dataCount = service.dataCount(paramMap);
		total_page = util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			total_page = current_page;
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<Notice> list = service.listNotice(paramMap);
		
		String cp = req.getContextPath();
		String listUrl = cp+"/notice/list";
		String articleUrl = cp+"/notice/article?page="+current_page;
		
		if(searchValue.length() != 0) {
			listUrl += "?searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
			articleUrl = "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String paging = util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
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
	
	@RequestMapping(value="/notice/article")
	public String article() {
		return ".notice.article";
	}
	
}
