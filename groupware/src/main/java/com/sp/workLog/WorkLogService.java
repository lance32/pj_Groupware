package com.sp.workLog;

import java.util.List;
import java.util.Map;

public interface WorkLogService {
	
	public int insertWorkLog(WorkLog dto) throws Exception;
	
	public List<WorkLog> listWorkLog(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map) throws Exception;
	
	public WorkLog readWorkLog(int workLogNum) throws Exception;
	
	public int updateBoard(WorkLog dto, String pathname) throws Exception;
	
	public int deleteBoard(int num, String pathname, String memberNum) throws Exception;

}
