package com.sp.pay;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("pay.payController")
public class PayController {

	@RequestMapping(value="/pay/main")
	public String paylist() {
		
		return ".pay.main";
	}
	
	public String insertPay() {
		return null;
	}
	
	public String updatePay() {
		return null;
	}
	
	
}
