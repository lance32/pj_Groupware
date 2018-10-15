package com.sp.pay;

import java.util.List;
import java.util.Map;

public interface PayService {
	public Pay readMember(Map<String, Object> map);
	public Pay readSalary(Map<String, Object> map);
	
	public List<Tax> taxList();
//	public Member readDetailinfo(String memberNum);
	public int insertPay(Pay dto) throws Exception ;
//	public void firstLoginMember(Member dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public int memberdataCount(Map<String, Object> map);
	
	public List<Pay> ListPayMember(Map<String, Object> map);
	public List<Pay> ListPayMemberAdmin(Map<String, Object> map);
	
	public List<Map<String, Object>> payYearList(String memberNum);
	
	public int updateMember(Pay dto) throws Exception;

}
