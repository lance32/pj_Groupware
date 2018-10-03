package com.sp.authority;

import java.util.List;
import java.util.Map;



public interface AuthorityService {
	
	public List<Authority> ListAuthority(Map<String, Object> map);

	public int dataCount(Map<String, Object> map);

}
