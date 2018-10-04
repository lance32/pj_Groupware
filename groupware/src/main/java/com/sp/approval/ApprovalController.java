package com.sp.approval;

import java.net.URLDecoder;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
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
	
	@RequestMapping(value="/approval/approval_create")
	public String ApprovalCreate() {
		return ".approval.approval_create";
		
	}
	
	@RequestMapping(value="/approval/approval_createform")
	public String approvalForm() {
		return ".approval.approval_createForm";
		
	}
	
	@RequestMapping(value="/approval/submit")
	@ResponseBody
	public int SetApproval(String title, String contents, String comments, String author, String appLine) {
		try {
			String driverName = "net.sf.log4jdbc.DriverSpy";
			String dburl = "jdbc:log4jdbc:oracle:thin:@211.238.142.190:1521:xe";
			
			System.out.println("test");
			
			Class.forName(driverName);
			Connection connection = DriverManager.getConnection(dburl, "groupware", "java$!");
			//Statement stmt = connection.createStatement();
			CallableStatement cs = connection.prepareCall("{CALL SETAPPROVALDATA(approval_seq.nextval, approvalDocument_seq.nextval, approvalTemplate_seq.NEXTVAL, ?, ?, ?, ?, ?)}"); 
		    cs.setString(1, title);
		    cs.setString(2, contents);
		    cs.setString(3, comments);
		    cs.setString(4, author);
		    cs.setString(5, appLine);

		    cs.execute(); 
		    
		    cs.close();
		    connection.close();
		}catch(SQLException ex) {
			ex.printStackTrace();
			System.out.println(ex.getMessage());
		}catch(Exception ex) {
			
		}finally {
			
		}

		return 1;
	}
	@RequestMapping(value="approval/getApprovalCount", method=RequestMethod.GET)
	public Map<String, Object> approvalCount(HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("memberNum", info.getUserId());
		map.put("type", "progress");
		int progress=service.approvalCount(map);
		
		map.put("type", "complete");
		int complete=service.approvalCount(map);
		
		map.put("type", "reject");
		int reject=service.approvalCount(map);
		
		Map<String, Object>model= new HashMap<String, Object>();
		model.put("progress", progress);
		model.put("complete", complete);
		model.put("reject", reject);
		
		return model;
		
	}

}
