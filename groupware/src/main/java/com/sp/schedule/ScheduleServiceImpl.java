package com.sp.schedule;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("schedule.scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	CommonDAO dao;
	
	@Override
	// 일정 추가
	public int insertSchedule(Schedule dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("sch.insertSchedule", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	// 일정 수정
	public int updateSchedule(Schedule dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("sch.updateSchedule", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	// 일정 삭제
	public int deleteSchedule(int scheduleNum) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("sch.deleteSchedule", scheduleNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	// 일정 리스트
	public List<Schedule> listMonthSchedule(Map<String, Object> map) throws Exception {
		List<Schedule> list = null;
		try {
			list = dao.selectList("sch.listMonthSchedule", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	// 정보 조회
	public Schedule readSchedule(int scheduleNum) {
		Schedule dto = null;
		try {
			dto = dao.selectOne("sch.readSchedule", scheduleNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
}
