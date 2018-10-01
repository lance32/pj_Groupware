package com.sp.approval;

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

@Controller("approval.approvalController")
public class ApprovalController {
	
	@Autowired
	private ApprovalService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/approval/approval")
	public String ApprovalMain() {
		return ".approval.approval";
		
	}
	
	@RequestMapping(value="/approval/approval_list")
	public String ApprovalList(@RequestParam(value="page", defaultValue="1") int current_page,
	                                    @RequestParam(defaultValue="subject") String searchKey,
	                                    @RequestParam(defaultValue="") String searchValue,
	                                    HttpServletRequest req,
	                                    Model model) throws Exception{
		
		int rows=2;
		int dataCount=0;
		int total_page=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			try {
				searchValue=URLDecoder.decode(searchValue, "utf-8");
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		
		Map<String, Object> map=new HashMap<>();
		
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		dataCount=service.dataCount(map);
		
		total_page=util.pageCount(rows, dataCount);
		
		if(total_page<current_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Approval>list=service.listApproval(map);
		
		int listNum, n=0;
		
		Iterator<Approval>it=list.iterator();
		
		while(it.hasNext()) {
			Approval data=it.next();
			listNum=dataCount-(start+n-1);
			data.setApprovalNum(listNum);
			n++;
		}
		
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"";
		String articleUrl=cp+""+current_page;
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
		
		return ".approval.approval_list";
		
	}
	
	@RequestMapping(value="/approval/approval_create")
	public String ApprovalCreate() {
		return ".approval.approval_create";
		
	}
	
	@RequestMapping(value="/approval/approval_createform")
	public String approvalForm() {
		return ".approval.approval_createForm";
		
	}
	
	@RequestMapping(value="/approval/approval_createform1")
	public String approvalForm1() {
		return ".approval.approval_createForm1";
		
	}

}
