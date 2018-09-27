package com.sp.club;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	

}
