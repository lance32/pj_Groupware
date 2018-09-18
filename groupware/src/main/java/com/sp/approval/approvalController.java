package com.sp.approval;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("approval.approvalController")
public class approvalController {
	@RequestMapping(value="/approval/approval")
	public String approvalMain() {
		return ".approval.approval";
		
	}
	@RequestMapping(value="/approval/approval_list")
	public String approvalList() {
		return ".approval.approval_list";
		
	}
	
	@RequestMapping(value="/approval/approval_create")
	public String approvalCreate() {
		return ".approval.approval_create";
		
	}

}
