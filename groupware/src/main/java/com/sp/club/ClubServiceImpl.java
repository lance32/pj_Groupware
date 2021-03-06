package com.sp.club;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.clubBoard.Board;
import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("club.clubService")
public class ClubServiceImpl implements ClubService{
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager filemanager;
	
	@Override
	public int createClub(Club dto, String pathname) {
		int result=0;
		try {
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
				String filename=filemanager.doFileUpload(
						dto.getUpload(), pathname);
				dto.setClubImg(filename);
			}
			dao.insertData("club.createClub", dto);
			dao.insertData("club.insertFounder", dto.getMemberNum());
			dao.insertData("club.insertBasicCategory");
			dao.insertData("club.insertBasicCategory_notice");
			dao.insertData("club.insertBasicCategory2");
			dao.insertData("club.insertBasicCategory2_photo");
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Club> clubList(Map<String, Object> map) {
		List<Club> list=null;
		try {
			list=dao.selectList("club.clubList",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Club readClubInfo(int clubNum) {
		Club dto=null;
		try {
			dto=dao.selectOne("club.readClubInfo", clubNum);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	@Override
	public List<Category> listClubCategory(int clubNum) {
		List<Category> list =null;
		try {
			list=dao.selectList("club.listClubCategory",clubNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	@Override
	public List<Category> listClubCategoryItems(int clubNum) {
		List<Category> list =null;
		try {
			list=dao.selectList("club.listClubCategoryItems",clubNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}


	
	
	
	@Override
	public String isClubMember(Map<String, Object> map) {
		String result=null;
		try {
			result=dao.selectOne("club.isClubMember", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Club> listClubMember(int clubNum) {
		List<Club> list=null;
		try {
			list=dao.selectList("club.listClubMember",clubNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int updateClubInfo(Club dto, String pathname) {
		int result=0;
		try {
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
				if(dto.getClubImg().length()!=0) {
					filemanager.doFileDelete(dto.getClubImg(), pathname);
				}
				String filename=filemanager.doFileUpload(dto.getUpload(), pathname);
				dto.setClubImg(filename);
			}
			if(dto.getUpload2()!=null && !dto.getUpload2().isEmpty()) {
				if(dto.getClubMainImg()!=null && dto.getClubMainImg().length()!=0) {
					filemanager.doFileDelete(dto.getClubMainImg(), pathname);
				}
				String filename=filemanager.doFileUpload(dto.getUpload2(), pathname);
				dto.setClubMainImg(filename);
			}
			System.out.println(dto.getClubMainImg());
			
			dao.updateData("club.updateClubInfo", dto);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteClub(int clubNum, String pathname) {
		int result=0;
		try {
			filemanager.removePathname(pathname);
			dao.deleteData("club.deleteClub", clubNum);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public void insertCategoryPhase1(Category dto) {
		try {
			dao.insertData("club.insertClubCategoryPhase1", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public void insertCategoryPhase2(Category dto) {
		try {
			dao.insertData("club.insertClubCategoryPhase2", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public void deleteClubCategory(int categoryNum) {
		try {
			dao.deleteData("club.deleteClubCategory", categoryNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public void updateClubCategory(Category dto) {
		try {
			dao.updateData("club.updateClubCategory", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public int insertClubMember(Map<String, Object> map) {
		int result=0;
		try {
			dao.insertData("club.insertClubMember", map);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteClubMember(Map<String, Object> map) {
		int result=0;
		try {
			dao.insertData("club.deleteClubMember", map);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int clubMemberCount(int clubNum) {
		int result=0;
		try {
			result=dao.selectOne("club.clubMemberCount", clubNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int readClubCategory(int categoryNum) {
		int result=0;
		try {
			result=dao.selectOne("club.readClubCategory", categoryNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<com.sp.clubBoard.Board> listClubNotice_main(int clubNum) {
		List<com.sp.clubBoard.Board> list=null;
		try {
			list=dao.selectList("club.listClubNotice_main", clubNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Board> listClubPhoto_main(int clubNum) {
		List<com.sp.clubBoard.Board> list=null;
		try {
			list=dao.selectList("club.listClubPhoto_main", clubNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
