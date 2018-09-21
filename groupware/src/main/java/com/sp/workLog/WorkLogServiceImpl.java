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
	public int insertWorkLog(WorkLog dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("workLog.insertWorkLog",dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<WorkLog> listWorkLog(Map<String, Object> map) throws Exception {
		List<WorkLog> list=null;
		
		try {
			list=dao.selectList("workLog.listWorkLog", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
			
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		
		int result=0;
	
		try {
			result=dao.selectOne("workLog.dataCount",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	@Override
	public WorkLog readWorkLog(int workLogNum) throws Exception {
		WorkLog dto=null;
		
		try{
			dto=dao.selectOne("workLog.readWorkLog", workLogNum);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int updateBoard(WorkLog dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBoard(int num, String pathname, String memberNum) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public WorkLog readWorkForm(int num) throws Exception {
		
		WorkLog dto=null;
		
		try{
			dto=dao.selectOne("workLog.readWorkForm", num);
			if (dto == null)
				System.out.println("workLog.readWorkForm null");
			else
				System.out.println("workLog.readWorkForm not null");
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;

	}



}
