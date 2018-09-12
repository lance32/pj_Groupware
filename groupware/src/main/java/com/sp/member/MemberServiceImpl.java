package com.sp.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO dao;

	@Override
	public Member readMember(String userId) {
		Member dto=null;
		try {
			dto=dao.selectOne("member.readMember", userId);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

}
