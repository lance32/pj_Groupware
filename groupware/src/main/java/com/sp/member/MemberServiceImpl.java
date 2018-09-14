package com.sp.member;

import java.util.List;
import java.util.Map;

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

	@Override
	public void firstLoginMember(Member dto) throws Exception {
		
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result =0;
		
		try {
			result=dao.selectOne("member.dataCount", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public List<Member> ListMember(Map<String, Object> map) {
		List<Member> listmember=null;
		
		try {
			listmember=dao.selectList("member.listMember", map);
		} catch (Exception e) {
		}
		return listmember;
	}
	//부서 DB 데이터 가져오기
	@Override
	public List<Map<String, Object>> departmentList() {
		List<Map<String, Object>> departmentList=null;
		try {
			departmentList=dao.selectList("member.departmentList");
			} catch (Exception e) {
				
			}
		return departmentList;
	}
	//직급 DB 데이터 가져오기
	@Override
	public List<Map<String, Object>> positionList() {
		List<Map<String, Object>> positionList=null;
			try {
				positionList=dao.selectList("member.positionList");
			} catch (Exception e) {
				
			}
			
		return positionList;
	}



}
