package com.sp.schedule;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.member.SessionInfo;

@Controller("schedule.scheduleController")
public class ScheduleController {
	
	@Autowired
	private ScheduleService service;

	@RequestMapping(value="/schedule/main")
	public String main() {
		return ".schedule.schedule";
	}
	
	@RequestMapping(value="/schedule/inputForm")
	public String inputForm() {
		return "schedule/inputForm";
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
		
		List<Schedule> list=service.listMonthSchedule(map);
		
	 	List<ScheduleJSON> listJSON=new ArrayList<>();
	    Iterator<Schedule> it=list.iterator();
		while(it.hasNext()) {
			Schedule sch=it.next();
			// if(sch.getContent()!=null)
			//   sch.setContent(sch.getContent().replaceAll("\n", "<br>"));
			
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
	    	dto.setContent(sch.getContent());
	    	dto.setCreated(sch.getCreated());
	    	
	    	listJSON.add(dto);
		}
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("list", listJSON);
		return model;
	}
}
