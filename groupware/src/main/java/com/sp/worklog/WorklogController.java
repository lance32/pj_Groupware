package com.sp.worklog;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller("worklog.worklogController")
public class WorklogController {
	
	@RequestMapping(value="/worklog/list")
	public String list() throws Exception{
			
		return ".worklog.list";
	}
}
