package com.sp.authority;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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

@Controller("authority.authorityController")
public class AuthorityController {
	
	@Autowired
	private AuthorityService service;
	
	@Autowired
	private MyUtil util;

	@RequestMapping(value="/authority/authoritylist")
	public String list(@RequestParam(value="page",defaultValue="1") int current_page,
			@RequestParam(defaultValue="name") String serchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int rows=10; 
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
		
		List<Authority> list=service.ListAuthority(map);
		
		int listNum, n=0;
		
		Iterator<Authority> it = list.iterator();
		
		while(it.hasNext()) {
			Authority data=it.next();
			listNum=dataCount - (start+n-1);
			data.setListNum(listNum);
			n++;
		}
			
		
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"/authority/authoritylist";
		if(query.length()!=0) {
			listUrl=listUrl+"?"+query;
		}
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("page",current_page);
		model.addAttribute("paging",paging);

		return ".authority.authoritylist";
	}
}
