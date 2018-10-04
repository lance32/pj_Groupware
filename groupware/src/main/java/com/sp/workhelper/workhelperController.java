package com.sp.workhelper;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller(".workhelper.workhelperController")
public class workhelperController {
	
	@RequestMapping(value="/workhelper/main")
	public String main() {
		return ".workhelper.main";
	}

	
//	@RequestMapping(value="/workhelper/memberNumCheck")
//	@ResponseBody
//	public Map<String, Object> memberNumCheck(
//			@RequestParam(value="memberNum") String memberNum
//			) throws Exception {
//		// 아이디 중복 검사
//		
//		Member member = service.readMember(memberNum);
//		
//		String passed = "true";
//		if(member != null)
//			passed = "false";
//		
//		Map<String, Object> map=new HashMap<>();
//		map.put("passed", passed);
//		return map;
//	}
	
	
}
