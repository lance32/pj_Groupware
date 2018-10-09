package com.sp.authority;

import java.util.List;
import java.util.Map;


public interface AuthorityService {
	
	public List<Authority> listAuthority(Map<String, Object> map);
	
	public List<Authority> listTalbe(Map<String, Object> map);
	
	public int dataCount(Map<String, Object> map);
	
	public Authority readAuthority(String memberNum);

	public int updateAuthority(Map<String, Object>map); 

}
