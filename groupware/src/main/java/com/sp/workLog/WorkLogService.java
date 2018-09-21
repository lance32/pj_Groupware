package com.sp.workLog;

import java.util.List;
import java.util.Map;

public interface WorkLogService {
	
	public int insertWorkLog(WorkLog dto); 
	
	public List<WorkLog> listWorkLog(Map<String, Object> map); 
	
	public int dataCount(Map<String, Object> map); 
	
	public WorkLog readWorkLog(int workLogNum); 
	
	public int updateWorkLog(WorkLog dto, String pathname); 
	
	public int deleteWorkLog(int num, String pathname, String memberNum);
	
	public WorkLog readWorkForm(int num);

}
