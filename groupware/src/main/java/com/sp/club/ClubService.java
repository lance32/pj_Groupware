package com.sp.club;

import java.util.List;
import java.util.Map;

public interface ClubService {
	public int createClub(Club dto, String pathname);
	public List<Club> clubList(Map<String, Object> map);
	public Club readClubInfo(int clubNum);
}
