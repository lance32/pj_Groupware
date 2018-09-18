package com.sp.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member readMember(String memberNum);
	
	public void insertMember(Member dto) throws Exception ;
	public void firstLoginMember(Member dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Member> ListMember(Map<String, Object> map);
	
	public List<Map<String, Object>> departmentList();
	public List<Map<String, Object>> positionList();
//	public void updateMember(Member dto) throws Exception;
//	public int updateLastLogin(String userId);
//	
//	public int deleteMember(String userId);
	
//	public int insertAuthority(Member dto);
//	public int updateAuthority(Member dto);
//	public List<Member> listAuthority(String userId);
}
