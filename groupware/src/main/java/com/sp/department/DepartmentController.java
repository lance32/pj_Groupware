package com.sp.department;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.member.MemberService;
import com.sp.member.OrganizationChart;

@Controller("department.Controller")
public class DepartmentController {
	@Autowired
	private DepartmentService service;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/department/main")
	public String departmentMain(Model model) throws Exception{
		List<Department> deptList = null;
		List<OrganizationChart> deptMemberList = null;
		try {
			deptList = service.list();
			deptMemberList = memberService.organizationChart();
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptMemberList", deptMemberList);
		
		return ".department.main";
	}
	
	@RequestMapping(value="/department/deptInfo", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> deptInfo(@RequestParam(value="id", defaultValue="0")int id) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		List<OrganizationChart> deptInfo = service.deptInfoById(id);
		model.put("deptInfo", deptInfo);
		
		return model;
	}
	
	@RequestMapping(value="/department/updateDeptInfo", method=RequestMethod.GET)
	@ResponseBody
	public void updateDeptInfo(
			@RequestParam(value="type") String type,
			@RequestParam(value="key") String key,
			@RequestParam(value="data") String data,
			HttpServletRequest req
			) throws Exception {
		
		if (type.equals("move")) {
			key = URLDecoder.decode(key, "utf-8");
			String[] memNums = data.split(",");
			for (String memNum : memNums) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("deptNum", key);
				map.put("memNum", memNum);
				
				service.update(map);
			}
		} else if (type.equals("add")) {
			key = URLDecoder.decode(key, "utf-8");
			Map<String, Object> map = new HashMap<String, Object>();
			String[] value = data.split(":");	// 0:부모, 1:deptOrder, 2:deptGroup, 3:idx, 4:departmentNum
			// 새 idx 이후 idx++
			map.put("parentDepartment", value[0]);
			map.put("deptOrder", value[1]);
			map.put("deptGroup", value[2]);
			map.put("idx", value[3]);
			map.put("departmentNum", value[4]);
			map.put("departmentName", key);
			service.updateIdx(map);
			
			// 정보 insert
			service.insert(map);
		} else if (type.equals("rename")) {
			// url:"<%=cp%>/department/updateDeptInfo?type=rename&key=" + deptNum + "&data=" + data,
			data = URLDecoder.decode(data, "utf-8");
			Department dept = new Department();
			dept.setDepartmentName(data);
			dept.setDepartmentNum(Integer.parseInt(key));
			service.updateRename(dept);
		} else if (type.equals("remove")) {
			service.delete(Integer.parseInt(key));
		}
	}
	
}
