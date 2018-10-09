package com.sp.pay;

import java.util.List;
import java.util.Map;

public interface PayService {
//	public Member readMember(String memberNum);
//	public Member readDetailinfo(String memberNum);
//	public int insertMember(Member dto,String pathname) throws Exception ;

//	public void firstLoginMember(Member dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public int memberdataCount(Map<String, Object> map);
	
	public List<Pay> ListPayMember(Map<String, Object> map);
	public List<Pay> ListPayMemberAdmin(Map<String, Object> map);
	
	public List<Map<String, Object>> payYearList(String memberNum);
//	public List<Map<String, Object>> departmentList();
//	public List<Map<String, Object>> positionList();
	
//	public int updateMember(Member dto,String pathname) throws Exception;
//	public int updateAdmin(Member dto) throws Exception;
	
}
