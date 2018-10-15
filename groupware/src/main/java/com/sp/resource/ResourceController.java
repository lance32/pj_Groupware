package com.sp.resource;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
	
	@RequestMapping(value="/scheduler/articleForm")
	public String articleForm(Model model) throws Exception {
		return "schResource/articleForm";
	}
	
	@RequestMapping(value="/scheduler/inputResourceForm")
	public String inputResourceForm(Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if((info.getGrants() & 3) != 3) {
			String message = "접근 권한 없음";
			model.addAttribute("message", message);
			return ".error.error";
		}
		
		List<Resource> groupList = service.listResourceGroup();
		
		model.addAttribute("groupList", groupList);
		return "schResource/inputResForm";
	}
	
	@RequestMapping(value="/scheduler/resourceInsert")
	@ResponseBody
	public Map<String, Object> insertResource(
			Resource dto
			) {
		String state = "true";
		int result = service.insertResourceList(dto);
		if(result == 0) {
			state = "false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/scheduler/resourceDelete")
	@ResponseBody
	public Map<String, Object> deleteResource(
			@RequestParam(value="chkNum") String chkNum 
			) {
		String state = "true";
		int result = 0;
		
		String numbers[] = chkNum.split(";");
		for(int i=0; i < numbers.length; i++) {
			result = service.deleteResourceList(Integer.parseInt(numbers[i]));
		}
		if(result == 0) {
			state = "false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/scheduler/inputGroupForm")
	public String inputGroupForm(Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if((info.getGrants() & 3) != 3) {
			String message = "접근 권한 없음";
			model.addAttribute("message", message);
			return ".error.error";
		}
		return "schResource/inputGroupForm";
	}
	
	@RequestMapping(value="/scheduler/groupInsert")
	@ResponseBody
	public Map<String, Object> insertGroup(
			Resource dto
			) {
		String state = "true";
		int result = service.insertResourceGroup(dto);
		if(result == 0) {
			state = "false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
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
	
	@RequestMapping(value="/scheduler/resList")
	public String listResourceList2(
			Map<String, Object> paramMap,
			HttpServletRequest req,
			HttpSession session,
			Model model,
			@RequestParam(value="page", defaultValue="1") int current_page
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if((info.getGrants() & 3) != 3) {
			String message = "접근 권한 없음";
			model.addAttribute("message", message);
			return ".error.error";
		}
		
		int rows = 10;
		
		int dataCount;
		int total_page;
		
		dataCount = service.resCount();
		total_page = util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page = total_page;
		
		int start = (current_page-1) * rows + 1;
		int end = current_page *rows;
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<Resource> list = service.listResourceList3(paramMap);
		
		String cp = req.getContextPath();
		String listUrl = cp+"/scheduler/resList";
		
		String paging = util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		
		return ".schResource.resList";
	}
	
	@RequestMapping(value="/scheduler/list")
	public String listReservation(
			Map<String, Object> paramMap,
			@RequestParam(value="searchKey", defaultValue="title") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model,
			@RequestParam(value="page", defaultValue="1") int current_page
			) throws Exception {
		int rows = 10;
		int dataCount;
		int total_page;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		paramMap.put("searchKey", searchKey);
		paramMap.put("searchValue", searchValue);
		
		dataCount = service.dataCount(paramMap);
		total_page = util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page = total_page;
		
		int start = (current_page-1) * rows + 1;
		int end = current_page *rows;
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<Resource> list = service.listReserve2(paramMap);
		
		String cp = req.getContextPath();
		String listUrl = cp+"/scheduler/list";
		
		if(searchValue.length() != 0) {
			listUrl += "?searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String paging = util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		
		return ".schResource.reserveList";
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
			
			// 하루종일 일정일때 시간 처리
			if(dto.getAllDay().equals("1")) {
				dto.setStartTime("00:00");
			}
			
			// 알림 메시지 보낼 시간 계산
			String created = dto.getStartDay()+" "+dto.getStartTime();
			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
			Date date = sdformat.parse(created);
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			System.out.println("알림시간:"+dto.getAlarmTime());
			if(dto.getAlarmTime() == 0) {
				cal.add(Calendar.DAY_OF_MONTH, -1);
			} else if(dto.getAlarmTime() == 1) {
				cal.add(Calendar.DAY_OF_MONTH, -2);
			} else if(dto.getAlarmTime() == 2) {
				cal.add(Calendar.DAY_OF_MONTH, -3);
			}
			
			String resultDay = sdformat.format(cal.getTime());
			mdto.setSendTime(resultDay);
			
			String members[] = mdto.getToMember().split(";");
			for(int i=0; i < members.length; i++) {
				mdto.setToMember(members[i]);
				msgService.insertMessage2(mdto);
			}
		}
		dto.setContent(util.htmlSymbols(dto.getContent()));
		
		service.insertReserve(dto);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	@RequestMapping(value="/scheduler/updateReservation")
	@ResponseBody
	public Map<String, Object> schedulerUpdate(Resource dto,
			@RequestParam(value="resourceName") String resourceName,
			HttpSession session
			) throws Exception {
		String state="true";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		dto.setMemberNum(info.getUserId());
		dto.setResourceName(resourceName);
		
		int result=service.updateReserve(dto);
		if(result==0)
			state="false";
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	@RequestMapping(value="/scheduler/deleteReservation")
	@ResponseBody
	public Map<String, Object> schedulerDelete(int num,
			HttpSession session
			) throws Exception {
		String state="true";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Map<String, Object> map=new HashMap<>();
		map.put("memberNum", info.getUserId());
		map.put("reserveNum", num);
		
		int result=service.deleteReserve(map);
		if(result==0)
			state="false";
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
}
