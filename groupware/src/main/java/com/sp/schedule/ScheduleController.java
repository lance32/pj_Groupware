package com.sp.schedule;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("schedule.scheduleController")
public class ScheduleController {

	@RequestMapping(value="/schedule/main")
	public String month() {
		return ".schedule.schedule";
	}
	
	@RequestMapping(value="/schedule/inputForm")
	public String inputForm() {
		return "schedule/inputForm";
	}
}
