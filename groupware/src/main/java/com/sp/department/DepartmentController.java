package com.sp.department;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("department.Controller")
public class DepartmentController {
	@Autowired
	private DepartmentService service;
	
	@RequestMapping(value="/department/main")
	public String departmentMain(Model model) throws Exception{
		List<Department> list = null;
		
		try {
			list = service.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("list", list);
		
		return ".department.main";
	}
}
