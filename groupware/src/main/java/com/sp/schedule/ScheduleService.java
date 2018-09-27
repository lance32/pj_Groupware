package com.sp.schedule;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
	public int insertSchedule(Schedule dto) throws Exception;
	public int updateSchedule(Schedule dto) throws Exception;
	public int deleteSchedule(int scheduleNum) throws Exception;
	public Schedule readSchedule(int scheduleNum);
	public List<Schedule> listMonthSchedule(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Schedule> listSchedule(Map<String, Object> map) throws Exception;
}
