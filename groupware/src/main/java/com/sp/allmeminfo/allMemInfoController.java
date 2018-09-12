package com.sp.allmeminfo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("allMemInfoController")
public class allMemInfoController {

	@RequestMapping(value="/allmem/main")
	public String memberList() {
		
		return ".allmem.main";
	} 
	
	@RequestMapping(value="allmem/created")
	public String insertmember(Model model) {
		
		model.addAttribute("mode","crated");
		
		return ".allmem.created";
	}
}
