package com.sp.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.member.SessionInfo;
import com.sp.message.Message;
import com.sp.message.MessageService;
import com.sp.notice.Notice;
import com.sp.notice.NoticeService;
import com.sp.schedule.Schedule;
import com.sp.schedule.ScheduleService;

@Controller("mainController")
public class MainController {
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private MessageService messageService;
	@Autowired
	private ScheduleService scheduleService;
	
	@RequestMapping(value="/main")
	public String method(
			HttpServletRequest req
			,HttpSession session
			,Model model) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();
		String memberNum=info.getUserId();
		
		int start = 1;
		int end = 5;
		map.put("start", start);
		map.put("end", end);
		map.put("memberNum", memberNum);
		
		//공지사항 리스트
		List<Notice> noticeList = noticeService.listNotice(map);
		for(Notice dto: noticeList) {
			dto.setCreated(dto.getCreated().substring(0, 10));
		}
		
		//미확인 결재 문서함
		
		//받은 쪽지
		List<Message> messageList=null;
		try {
			map.put("type", "receive");
			messageList= messageService.listMessage(map);
			for(Message dto: messageList) {
				dto.setSendTime(dto.getSendTime().substring(0, 10));
			}
		} catch (Exception e) {
		}
		
		//내일정
		List<Schedule> scheduleList=null;
		try {
			scheduleList=scheduleService.listSchedule_main(map);
			for(Schedule dto: scheduleList) {
				dto.setCreated(dto.getCreated().substring(0, 10));
			}
		} catch (Exception e) {
		}
		
		model.addAttribute("noticeList_main", noticeList);
		model.addAttribute("messageList_main", messageList);
		model.addAttribute("scheduleList_main", scheduleList);
		return ".mainLayout";
	}
	
	
	@RequestMapping(value="/calendar")
	public String calendar() {
		return "main/calendar";
	}
}
