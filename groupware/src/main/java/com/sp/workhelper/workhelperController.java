package com.sp.workhelper;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("workhelper.workhelperController")
public class workhelperController {
	
	@RequestMapping(value="/workhelper/main")
	public String main(HttpSession session) {
		
		return ".workhelper.main";
	}

}
