package com.sp.resource;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;
import com.sp.message.Message;
import com.sp.message.MessageService;

@Controller("resource.resourceController")
public class ResourceController {

	@Autowired
	private ResourceService service;
	
	@Autowired
	private MessageService msgService;
	
	@Autowired
	private MyUtil util;
	
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
	
	@RequestMapping(value="/scheduler/inputForm")
	public String inputForm(Model model) throws Exception {
		List<Resource> groupList = service.listResourceGroup();
		
		model.addAttribute("groupList", groupList);
		return "schResource/inputForm";
	}
	
	@RequestMapping(value="/scheduler/readResourceList")
	@ResponseBody
	public Map<String, Object> readResourceList(int resourceNum) throws Exception {
		Resource dto = service.readResourceList(resourceNum);
		
		Map<String, Object> model = new HashMap<>();
		String state = "true";
		if(dto == null) {
			state = "false";
		} else {
			model.put("dto", dto);
		}
		
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/scheduler/listResourceList")
	@ResponseBody
	public Map<String, Object> listResourceList(int groupNum) {
		List<Resource> list = service.listResourceList(groupNum);
		Map<String, Object> model = new HashMap<>();
		model.put("list", list);
		return model;
	}
	
	@RequestMapping(value="/scheduler/reservationInsert")
	@ResponseBody
	public Map<String, Object> schedulerInsert(Resource dto,
			Message mdto,
			@RequestParam(value="resourceName") String resourceName,
			HttpSession session
			) throws Exception {
		String state="true";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		dto.setMemberNum(info.getUserId());
		dto.setResourceName(resourceName);
		
		// 알림 보내는 경우
		if(dto.getAlarm() == 1) {
			// 보내는 사람
			mdto.setSendMember(info.getUserId());
			// 제목
			dto.setAlarmTitle(dto.getStartDay()+" 예약 알림 메시지 입니다.");
			mdto.setSubject(dto.getAlarmTitle());
			//내용
			dto.setAlarmContent(dto.getName()+"님이 예약하신 " + dto.getStartDay()+" "+ dto.getStartTime()+" 에 시작되는 "
					+ dto.getResourceName() +" 사용 예약 입니다.");
			mdto.setContent(dto.getAlarmContent());
			// 받을 사람
			mdto.setToMember(dto.getToMember());
			
			// 시간 처리 중
//			String created = dto.getStartDay();
//			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
//			Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(created);
//			Calendar cal = Calendar.getInstance();
//			cal.setTime(date);
//			cal.add(Calendar.DAY_OF_MONTH, -3);
//			String resultDay = sdformat.format(cal.getTime());
//			System.out.println("결과 : "+resultDay);
			
			String members[] = mdto.getToMember().split(";");
			for(int i=0; i < members.length; i++) {
				mdto.setToMember(members[i]);
				msgService.insertMessage(mdto);
			}
			

		}
		dto.setContent(util.htmlSymbols(dto.getContent()));
		
		service.insertReserve(dto);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
}
