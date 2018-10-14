package com.sp.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member readMember(String memberNum);
	public Member readDetailinfo(String memberNum);
	public int readBasicpay(String memberNum)throws Exception;
	public int insertMember(Member dto,String pathname) throws Exception ;

	public int firstLoginMember(Member dto) throws Exception;
	
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Member> ListMember(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> qualifyList(String memberNum) throws Exception;
	public List<Map<String, Object>> departmentList() throws Exception;
	public List<Map<String, Object>> positionList() throws Exception;
	
	public int updateMember(Member dto,String pathname) throws Exception;
	public int updateAdmin(Member dto) throws Exception;
	
	public int DeleteQualify(String serialNum) throws Exception;
//	public int updateLastLogin(String userId);
	
//	public int insertAuthority(Member dto);
//	public int updateAuthority(Member dto);
//	public List<Member> listAuthority(String userId);
	
	public List<OrganizationChart> organizationChart() throws Exception;
}
