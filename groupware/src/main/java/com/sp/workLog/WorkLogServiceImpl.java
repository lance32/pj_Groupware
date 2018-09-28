package com.sp.workLog;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("workLog.workLogService")
public class WorkLogServiceImpl implements WorkLogService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertWorkLog(WorkLog dto){
		int result = 0;
		try {
			result = dao.insertData("workLog.insertWorkLog",dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<WorkLog> listWorkLog(Map<String, Object> map){
		List<WorkLog> list=null;
		
		try {
			list=dao.selectList("workLog.listWorkLog", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
			
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map){
		
		int result=0;
	
		try {
			result=dao.selectOne("workLog.dataCount",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	@Override
	public WorkLog readWorkLog(int workLogNum){
		WorkLog dto=null;
		
		try{
			dto=dao.selectOne("workLog.readWorkLog", workLogNum);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int updateWorkLog(WorkLog dto, String pathname){
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteWorkLog(int num, String pathname, String memberNum) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public WorkLog readWorkForm(int num){
		
		WorkLog dto=null;
		
		try{
			dto=dao.selectOne("workLog.readWorkForm", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;

	}



}
