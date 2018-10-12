package com.sp.club;

import java.util.List;
import java.util.Map;

public interface ClubService {
	public int createClub(Club dto, String pathname);
	public List<Club> clubList(Map<String, Object> map);
	public Club readClubInfo(int clubNum);
	public List<Category> listClubCategory(int clubNum);
	public List<Category> listClubCategoryItems(int clubNum);
	public int readClubCategory(int categoryNum);
	public String isClubMember(Map<String, Object> map);
	public List<Club> listClubMember(int clubNum);
	public int updateClubInfo(Club dto, String pathname);
	public int deleteClub(int clubNum, String pathname);
	public void insertCategoryPhase1(Category dto);
	public void insertCategoryPhase2(Category dto);
	public void deleteClubCategory(int categoryNum);
	public void updateClubCategory(Category dto);
	
	public int insertClubMember(Map<String, Object> map);
	public int deleteClubMember(Map<String, Object> map);
	public int clubMemberCount(int clubNum);
	
	public List<com.sp.clubBoard.Board> listClubNotice_main(int clubNum);
	public List<com.sp.clubBoard.Board> listClubPhoto_main(int clubNum);
}
