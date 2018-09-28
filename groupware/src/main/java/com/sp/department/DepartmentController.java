package com.sp.department;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("department.Controller")
public class DepartmentController {

	@RequestMapping(value="/department/main")
	public String departmentMain() throws Exception{
		
		
		return ".department.main";
		
		
		
	}
}
