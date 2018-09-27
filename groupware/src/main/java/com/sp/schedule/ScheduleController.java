package com.sp.schedule;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("schedule.scheduleController")
public class ScheduleController {
	
	@Autowired
	private ScheduleService service;
	@Autowired
	private MyUtil util;

	@RequestMapping(value="/schedule/main")
	public String main() {
		return ".schedule.schedule";
	}
	
	@RequestMapping(value="/schedule/inputForm")
	public String inputForm() {
		return "schedule/inputForm";
	}
	
	@RequestMapping(value="/schedule/articleForm")
	public String articleForm() {
		return "schedule/articleForm";
	}
	
	@RequestMapping(value="/schedule/created")
	@ResponseBody
	public Map<String, Object> created(
			Schedule dto,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		dto.setMemberNum(info.getUserId());
		service.insertSchedule(dto);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");
		
		return model;		
	}
	
	@RequestMapping(value="/schedule/month")
	@ResponseBody
	public Map<String, Object> month(
			@RequestParam(value="start") String start,
			@RequestParam(value="end") String end,
			@RequestParam(value="group", defaultValue="all") String group,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("group", group);
		map.put("start", start);
		map.put("end", end);
		map.put("memberNum", info.getUserId());
		map.put("departmentNum", info.getDepartmentNum());
		System.out.println("디파트먼트넘 : "+info.getDepartmentNum());
		
		List<Schedule> list=service.listMonthSchedule(map);
		
	 	List<ScheduleJSON> listJSON=new ArrayList<>();
	    Iterator<Schedule> it=list.iterator();
		while(it.hasNext()) {
			Schedule sch=it.next();
			
			ScheduleJSON dto=new ScheduleJSON();
	    	dto.setId(sch.getScheduleNum());
	    	dto.setTitle(sch.getTitle());
	    	dto.setName(sch.getName());
	    	dto.setColor(sch.getColor());
	    	if(sch.getAllDay().equals("1"))
	    	    dto.setAllDay(true);
	    	else
	    		dto.setAllDay(false);
	    	
	    	if(sch.getStartTime()!=null && sch.getStartTime().length()!=0)
		    	dto.setStart(sch.getStartDay()+" " + sch.getStartTime());
	    	else
	    		dto.setStart(sch.getStartDay());
	    	
	    	if(sch.getEndTime()!=null && sch.getEndTime().length()!=0)
	    		dto.setEnd(sch.getEndDay()+" " + sch.getEndTime());
	    	else
	    		dto.setEnd(sch.getEndDay());
	    	sch.setContent(util.htmlSymbols(sch.getContent()));
	    	dto.setContent(sch.getContent());
	    	dto.setPlace(sch.getPlace());
	    	dto.setCreated(sch.getCreated());
	    	
	    	listJSON.add(dto);
		}
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("list", listJSON);
		return model;
	}
	
	@RequestMapping(value="/schedule/delete")
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam(value="scheduleNum") int scheduleNum
			) throws Exception {
		String state = "false";
		int result = service.deleteSchedule(scheduleNum);
		if(result == 1)
			state = "true";
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/schedule/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(
			Schedule dto,
			HttpSession session
			) throws Exception {
		String state = "false";
		int result = service.updateSchedule(dto);
		if(result == 1) {
			state = "true";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/schedule/list")
	public String list(
			Map<String, Object> paramMap,
			HttpServletRequest req,
			Model model,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@RequestParam(value="sDay", defaultValue="") String sDay,
			@RequestParam(value="eDay", defaultValue="") String eDay
			) throws Exception {
		int rows = 5;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		System.out.println("sDay : "+ sDay);
		System.out.println("eDay : "+ eDay);
		
		paramMap.put("searchKey", searchKey);
		paramMap.put("searchValue", searchValue);
		paramMap.put("sDay", sDay);
		paramMap.put("eDay", eDay);
		
		dataCount = service.dataCount(paramMap);
		total_page = util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page = total_page;
		
		int start = (current_page-1) * rows + 1;
		int end = current_page *rows;
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<Schedule> list = service.listSchedule(paramMap);
		
		String cp = req.getContextPath();
		String listUrl = cp+"/schedule/list";
		
		if(searchValue.length() != 0) {
			listUrl += "?searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String paging = util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		
		return ".schedule.searchForm";
	}
	
}
