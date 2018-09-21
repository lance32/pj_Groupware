package com.sp.approval;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.common.MyUtil;

@Controller("approval.approvalController")
public class ApprovalController {
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/approval/approval")
	public String ApprovalMain() {
		return ".approval.approval";
		
	}
	@RequestMapping(value="/approval/approval_list")
	public String ApprovalList() {
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
