package com.sp.resource;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("resource.resourceController")
public class ResourceController {

	@Autowired
	private ResourceService service;
	
	@RequestMapping(value="/scheduler/main")
	public String main() {
		return ".schResource.main";
	}
	
	@RequestMapping(value="/scheduler/reserveList")
	public String reservelist() {
		return ".schResource.reserveList";
	}
	
	@RequestMapping(value="/scheduler/resList")
	public String resourceList() {
		return ".schResource.resList";
	}
	
	@RequestMapping(value="/scheduler/resources")
	@ResponseBody
	public List<ResourceJSON> resources(HttpServletResponse resp) throws Exception {
		List<ResourceJSON> list=service.listResourceList();
		return list;
	}
	
	@RequestMapping(value="/scheduler/events")
	@ResponseBody
	public List<ResourceJSON> events(
			@RequestParam String start,
			@RequestParam String end
			) throws Exception {
		Map<String, Object> map=new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		List<ResourceJSON> list=service.listReserve(map);
		return list;
	}
}
