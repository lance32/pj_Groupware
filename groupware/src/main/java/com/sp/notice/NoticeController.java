package com.sp.notice;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		System.out.println("아티클 : " + articleUrl);
		if(searchValue.length() != 0) {
			listUrl += "?searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
			articleUrl += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
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
	public String article(
			Map<String, Object> paramMap,
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model
			) throws Exception {
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		String query="page="+page;
		if(searchValue.length()!=0) {
			query+="&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		
		service.updateHitCount(num);
		Notice dto = service.readNotice(num);
		if(dto == null)
			return "redirect:/notice/list?"+query;
		
		dto.setContent(util.htmlSymbols(dto.getContent()));
		
		paramMap.put("searchKey", searchKey);
		paramMap.put("searchValue", searchValue);
		paramMap.put("num", num);
		
		Notice preReadDto = service.preReadNotice(paramMap);
		Notice nextReadDto = service.nextReadNotice(paramMap);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".notice.article";
	}
	
	@RequestMapping(value="/notice/delete")
	public String delete(
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page,
			HttpSession session
			) {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"notice";
		
		Notice dto = service.readNotice(num);
		if(dto == null)
			return "redirect:/notice/list?page="+page;
		
		if(dto.getSaveFilename() != null) {
			pathname = File.separator+dto.getSaveFilename();
		} else {
			pathname = null;
		}
		service.deleteNotice(num, pathname);
		
		return "redirect:/notice/list?page="+page;
	}
	@RequestMapping(value="/notice/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model
			) {
		Notice dto = service.readNotice(num);
		if(dto == null)
			return "redirect:/notice/list?page="+page;
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		
		return ".notice.created";
	}
	
	@RequestMapping(value="/notice/update", method=RequestMethod.POST)
	public String updateSubmit(
			Notice dto, 
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"notice";		
		
		System.out.println("dto.num =" + dto.getNum());
		System.out.println("dto.name =" + dto.getName());
		System.out.println("dto.subject =" + dto.getSubject());
		System.out.println("dto.content =" + dto.getContent());
		System.out.println("dto.saveFile =" + dto.getSaveFilename());
		System.out.println("dto.originalFile =" + dto.getOriginalFilename());
		
		service.updateNotice(dto, pathname);		
		
		return "redirect:/notice/list?page="+page;
	}
	
	// 첨부 된 파일 다운로드
	@RequestMapping(value="/notice/download")
	public void download(
			@RequestParam int num,
			HttpServletRequest req,
			HttpServletResponse resp,
			HttpSession session
			) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"notice";
		
		Notice dto=service.readNotice(num);
		
		if(dto!=null) {
			boolean b=fileManager.doFileDownload(dto.getSaveFilename(),
					                   dto.getOriginalFilename(), pathname, resp);
			if(b)
				return;
		}
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print("<script>alert('파일 다운로드가 실패 했습니다.');history.back();</script>");
	}
	
	// 첨부 파일 삭제
	@RequestMapping(value="/notice/deleteFile")
	public String deleteFile(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"notice";
		
		Notice dto=service.readNotice(num);
		if(dto==null) {
			return "redirect:/notice/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getMemberNum())) {
			return "redirect:/notice/list?page="+page;
		}
		
		if(dto.getSaveFilename()!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname); 
			dto.setSaveFilename("");
			dto.setOriginalFilename("");
			service.updateNotice(dto, pathname);
		}
		
		return "redirect:/notice/update?num="+num+"&page="+page;
	}
	
	// 댓글, 답글 추가
	@RequestMapping(value="/notice/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
			HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		dto.setMemberNum(info.getUserId());
		dto.setName(info.getUserName());
		
		int result=service.insertReply(dto);
		if(result==0)
			state="false";
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("state", state);
		
		return resultMap;
	}
	
	// 댓글 리스트
	@RequestMapping(value="/notice/listReply")
	public String listReply(
			@RequestParam int num,
			Map<String,Object> paramMap,
			@RequestParam(value="pageNo", defaultValue="1") int current_page
			,Model model
			) {
		
		paramMap.put("num", num);
		
		int rows = 3;
		int dataCount = service.replyCount(paramMap);
		int total_page = util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page = total_page;
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<Reply> listReply = service.listReply(paramMap);
		for(Reply dto : listReply) {
			dto.setContent(util.htmlSymbols(dto.getContent()));
		}
		
		String paging=util.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("list", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "notice/listReply";
	}
	
	// 댓글, 댓답글 삭제
	@RequestMapping(value="/notice/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam Map<String, Object> paramMap
			) {
		String state="true";
		service.deleteReply(paramMap);
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	 // 댓답글 리스트
	@RequestMapping(value="/notice/listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam(value="answer") int answer
			,Model model
			) throws Exception {
		
		List<Reply> list=service.listReplyAnswer(answer);
		for(Reply dto : list) {
			dto.setContent(util.htmlSymbols(dto.getContent()));
		}
		
		model.addAttribute("list", list);
		return "notice/listReplyAnswer";
	}
	
	// 댓답글 개수 : AJAX-JSON
	@RequestMapping(value="/notice/countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
			@RequestParam(value="answer") int answer
			) {
		
		int count=service.replyAnswerCount(answer);
		
		Map<String, Object> model=new HashMap<>();
		model.put("count", count);
		return model;
	}
}
