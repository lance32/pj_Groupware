package com.sp.authority;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;


@Service("authority.authorityService")
public class AuthorityServiceImpl implements AuthorityService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Authority> listAuthority(Map<String, Object> map) {
		
		List<Authority> list=null;
		try {
			list=dao.selectList("authority.listAuthority", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
			
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("authority.dataCount",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	@Override
	public Authority readAuthority(String memberNum) {
		Authority dto=null;
		
		try{
			dto=dao.selectOne("authority.readAuthority", memberNum);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public List<Authority> listTalbe(Map<String, Object> map) {
		List<Authority> list=null;
		try {
			list=dao.selectList("authority.listTable", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
			
		return list;
	}

	@Override
	public int updateAuthority(Map<String, Object> map) {
		int result = 0;
		try {
		result = dao.updateData("authority.updateAuthority", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}


}
