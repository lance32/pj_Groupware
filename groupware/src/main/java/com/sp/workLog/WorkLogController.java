package com.sp.workLog;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

@Controller("workLog.workLogController")
public class WorkLogController {
	
	@Autowired
	private WorkLogService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/workLog/list")
	public String list(@RequestParam(value="page",defaultValue="1") int current_page,
			@RequestParam(defaultValue="subject") String serchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int rows=2; 
		int dataCount=0; 
		int total_page=0; 
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			try {
				searchValue=URLDecoder.decode(searchValue, "utf-8");
			} catch (UnsupportedEncodingException e) {
			}
		}
		
		Map<String, Object> map=new HashMap<>(); 
		
		map.put("searchKey", serchKey);
		map.put("searchValue", searchValue);
				
		dataCount=service.dataCount(map);
	
		total_page=util.pageCount(rows, dataCount);
		
		if(total_page<current_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		
		List<WorkLog> list=service.listWorkLog(map);
		
		int listNum, n=0;
		
		Iterator<WorkLog> it = list.iterator();
		
		while(it.hasNext()) {
			WorkLog data=it.next();
			listNum=dataCount - (start+n-1);
			data.setListNum(listNum);
			n++;
		}
			
		
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"/workLog/list";
		String articleUrl=cp+"/workLog/article?page="+current_page;
		if(query.length()!=0) {
			listUrl=listUrl+"?"+query;
			articleUrl=articleUrl+"&"+query;
		}
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("page",current_page);
		model.addAttribute("paging",paging);

		return ".workLog.list";
	}
	
	@RequestMapping(value="/workLog/article")
	public String readWorkLog(@RequestParam(value="workLogNum") int workLogNum,
			@RequestParam(defaultValue="subject")String searchKey,
			@RequestParam(defaultValue="")String searchValue,
			@RequestParam(value="page")String page,
			Model model) throws Exception {
	
		
		String query="page"+page;
		searchValue=URLDecoder.decode(searchValue, "utf-8");
		if(searchValue.length()!=0) {
			query="&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
		}
		

		
		WorkLog dto=service.readWorkLog(workLogNum);
		if(dto==null) {
			return "redirect:/workLog/list?"+query;
		}
		Map<String, Object> map = new HashMap<>();
		
		map.put("workLogNum", workLogNum);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
	
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		model.addAttribute("page",page);
		
		return ".workLog.article";
	}
}





