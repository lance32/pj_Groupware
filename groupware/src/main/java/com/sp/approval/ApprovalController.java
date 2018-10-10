package com.sp.approval;

import java.net.URLDecoder;

import java.util.HashMap;
import java.util.Iterator;
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
	
	@RequestMapping(value="/approval/getSummaryList")
	@ResponseBody
	public List<ApprovalSummary> getApprovalList(HttpSession session ,String type ) {
		List<ApprovalSummary> dto = null;
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			dto=service.readApprovalSummary(type, info.getUserId());

		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		}
		return dto;
	}
	
	@RequestMapping(value="/approval/getList")
	@ResponseBody
	public List<ApprovalSummary> getApprovalDatailList(HttpSession session ,String type ) {
		List<ApprovalSummary> dto = null;
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			dto=service.readApproval(type, info.getUserId());

		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		}
		return dto;
	}
	
	@RequestMapping(value="/approval/getApprovalProcess")
	@ResponseBody
	public List<ApprovalProcess> getApprovalProcess(int docuNum ) {
		List<ApprovalProcess> dto = null;
		try {
			dto=service.getApprovalProcess(docuNum);

		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		}
		return dto;
	}
	
	@RequestMapping(value="/approval/getApproval")
	@ResponseBody
	public Approval getApproval(int docuNum ) {
		Approval dto = null;
		try {
			dto=service.readApproval(docuNum);

		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		}
		return dto;
	}
	
	@RequestMapping(value="/approval/approval_create")
	public String ApprovalCreate() {
		return ".approval.approval_create";
		
	}
	
	@RequestMapping(value="/approval/approval_detail_list")
	public String ApprovalDetailList() {
		return ".approval.approval_detail_list";
		
	}
	
	@RequestMapping(value="/approval/approval_viewer")
	public String ApprovalViewer() {
		return ".approval.approval_viewer";
		
	}
	
	@RequestMapping(value="/approval/approval_createform")
	public String approvalForm() {
		return ".approval.approval_createForm";
		
	}
	
	@RequestMapping(value="/approval/approval_createform2")
	public String approvalForm1() {
		return ".approval.approval_createForm1";
		
	}
	
	@RequestMapping(value="/approval/submit")
	@ResponseBody
	public int SetApproval(String title, String contents, String comments, String author, String appLine) {
		int retVal = -1;
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("title", title);
			map.put("contents", contents);
			map.put("comments", comments);
			map.put("author", author);
			map.put("appLine", appLine.substring(0, appLine.length()-1));
			
			retVal = service.approvalSend(map);
		}catch(Exception ex) {
			
		}finally {
			
		}

		return retVal;
	}
	
	@RequestMapping(value="/approval/approvalSign")
	@ResponseBody
	public int SetApprovalSign(String docuNum, String comments, String memberNum, String state) {
		int retVal = -1;
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("docuNum", docuNum);
			map.put("comments", comments);
			map.put("memberNum", memberNum);
			map.put("state", state);
			
			retVal = service.approvalSign(map);
		}catch(Exception ex) {
			
		}finally {
			
		}

		return retVal;
	}
	
	@RequestMapping(value="approval/getApprovalCount", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> approvalCount(HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("memberNum", info.getUserId());
		map.put("type", "progress1");
		int progress1=service.approvalCount(map);
		
		map.put("type", "complete1");
		int complete1=service.approvalCount(map);
		
		map.put("type", "reject1");
		int reject1=service.approvalCount(map);
		
		Map<String, Object>model= new HashMap<String, Object>();
		model.put("progress1", progress1);
		model.put("complete1", complete1);
		model.put("reject1", reject1);
		
		return model;
		
	}

}
