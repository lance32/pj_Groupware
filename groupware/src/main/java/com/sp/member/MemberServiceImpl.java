package com.sp.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager filemanager;

	@Override
	public Member readMember(String memberNum) {
		Member dto = null;
		try {
			dto = dao.selectOne("member.readMember", memberNum);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
				
				if(dto.getPhone()!=null) {
					String [] s=dto.getPhone().split("-");
					dto.setPhone1(s[0]);
					dto.setPhone2(s[1]);
					dto.setPhone3(s[2]);
				}
			}
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}

	@Override
	public int insertMember(Member dto, String pathname) throws Exception {
		int result = 0;

		try {
			if (dto.getEmail1() != null && dto.getEmail1().length() != 0 && dto.getEmail2() != null
					&& dto.getEmail2().length() != 0)
				dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());

			if (dto.getTel1() != null && dto.getTel1().length() != 0 && dto.getTel2() != null
					&& dto.getTel2().length() != 0 && dto.getTel3() != null && dto.getTel3().length() != 0) {

				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}

			if (dto.getPhone1() != null && dto.getPhone1().length() != 0 && dto.getPhone2() != null
					&& dto.getPhone2().length() != 0 && dto.getPhone3() != null && dto.getPhone3().length() != 0) {

				dto.setPhone(dto.getPhone1() + "-" + dto.getPhone2() + "-" + dto.getPhone3());
			}

			String saveFilename = filemanager.doFileUpload(dto.getUpload(), pathname);
			if (saveFilename != null) {
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}

			dao.insertData("member.insertMember", dto);
			dao.insertData("member.insertMemberDetailinfo",dto);
			dao.insertData("member.insertMemberAuthority",dto);
			dao.insertData("member.insertBasicpay",dto);
			dao.insertData("address.insertGeneralGroup", dto.getMemberNum());
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public void firstLoginMember(Member dto) throws Exception {

	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("member.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	// 사원 리스트
	@Override
	public List<Member> ListMember(Map<String, Object> map) {
		List<Member> listmember = null;

		try {
			listmember = dao.selectList("member.listMember", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return listmember;
	}
	
	//자격정보 가져오기
	@Override
	public List<Map<String, Object>> qualifyList(String memberNum) {
		List<Map<String, Object>> listqualify = null;

		try {
			listqualify = dao.selectList("member.qualifyList",memberNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return listqualify;
	}

	// 부서 DB 데이터 가져오기
	@Override
	public List<Map<String, Object>> departmentList() {
		List<Map<String, Object>> departmentList = null;
		try {
			departmentList = dao.selectList("member.departmentList");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return departmentList;
	}

	// 직급 DB 데이터 가져오기
	@Override
	public List<Map<String, Object>> positionList() {
		List<Map<String, Object>> positionList=null;
			try {
				positionList=dao.selectList("member.positionList");
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			
		return positionList;
	}

	@Override
	public int updateMember(Member dto,String pathname) throws Exception {
		try {

			if (dto.getEmail1() != null && dto.getEmail1().length() != 0 && dto.getEmail2() != null
					&& dto.getEmail2().length() != 0)
				dto.setEmail(dto.getEmail1()+"@"+ dto.getEmail2());

			if (dto.getTel1() != null && dto.getTel1().length() != 0 && dto.getTel2() != null
					&& dto.getTel2().length() != 0 && dto.getTel3() != null && dto.getTel3().length() != 0) {

				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}

			if (dto.getPhone1() != null && dto.getPhone1().length() != 0 && dto.getPhone2() != null
					&& dto.getPhone2().length() != 0 && dto.getPhone3() != null && dto.getPhone3().length() != 0) {

				dto.setPhone(dto.getPhone1() + "-" + dto.getPhone2() + "-" + dto.getPhone3());
			}

			String saveFilename = filemanager.doFileUpload(dto.getUpload(), pathname);

			if(saveFilename != null) {
				if(dto.getSaveFilename()!=null && dto.getSaveFilename().length()!=0)
					filemanager.doFileDelete(dto.getSaveFilename(), pathname);
				
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			dao.updateData("member.updateMember1", dto);
			
			Member dto2=dao.selectOne("member.readDetailinfo",dto.getMemberNum());
			if(dto2==null) {
				dao.insertData("member.insertMemberDetailinfo",dto);
			}else {
				dao.updateData("member.updateMember2", dto);				
			}

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return 1;
	}
	
	@Override
	public List<OrganizationChart> organizationChart() throws Exception {
		List<OrganizationChart> list = null;
		try {
			list = dao.selectList("member.organizationChart");
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} 
		return list;
	}

	@Override
	public int updateAdmin(Member dto) throws Exception {
		
		try {
			
			dao.updateData("member.updateAdmin",dto);
			dao.updateData("member.updateBasicpay",dto);
			if(dto.getQualifyName()!=null) {
				dao.updateData("member.insertQualify",dto);
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return 1;
	}

	@Override
	public Member readDetailinfo(String memberNum) {
		Member dto=null;
		try {
			dao.selectOne("member.readDetailinfo",memberNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int DeleteQualify(String serialNum) throws Exception {
		try {
			dao.deleteData("member.deleteQualify",serialNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return 1;
	}

}
