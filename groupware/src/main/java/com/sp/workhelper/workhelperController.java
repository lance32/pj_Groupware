package com.sp.workhelper;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller(".workhelper.workhelperController")
public class workhelperController {

	@RequestMapping(value="/workhelper/main")
	public String main() {
		return ".workhelper.main";
	}
	
	@RequestMapping(value="/pay/main")
	public String payMain() {
		return ".workhelper.paymain";
	}
	
	@RequestMapping(value="/certificate/main")
	public String certificateMain() {
		return ".workhelper.certificatemain";
	}
	
	
}
