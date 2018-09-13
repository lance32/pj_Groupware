package com.sp.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO dao;
	
	
	@Override
	public Member readMember(String memberNum) {
		Member dto=null;
		try {
			dto=dao.selectOne("member.readMember", memberNum);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			if(dto.getEmail1() != null && dto.getEmail1().length()!=0 &&
					dto.getEmail2() != null && dto.getEmail2().length()!=0)
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			
			if(dto.getTel1() != null && dto.getTel1().length() !=0
					&& dto.getTel2() != null && dto.getTel2().length() !=0
					&& dto.getTel3() != null && dto.getTel3().length() !=0) {
				
				dto.setTel(dto.getTel1()+"-"+dto.getTel2()+"-"+dto.getTel3());
			}
			
			if(dto.getPhone1() != null && dto.getPhone1().length() !=0
					&& dto.getPhone2() != null && dto.getPhone2().length() !=0
					&& dto.getPhone3() != null && dto.getPhone3().length() !=0) {
				
				dto.setPhone(dto.getPhone1()+"-"+dto.getPhone2()+"-"+dto.getPhone3());
			}
			
			dao.updateData("member.insertMember",dto);
			
		} catch (Exception e) {
			throw e;
		}
		
	}


}
