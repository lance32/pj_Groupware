package com.sp.clubBoard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.club.Club;
import com.sp.club.ClubService;
import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("clubBoard.clubBoardController")
public class ClubBoardController {
	@Autowired
	private ClubService clubService;
	@Autowired
	private ClubBoardService service;
	@Autowired
	private MyUtil util;

	@RequestMapping(value="/clubBoard/list")
	public String clubBoardList(
			@RequestParam int clubNum
			,@RequestParam int categoryNum
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		String isMember=null;
		List<com.sp.club.Category> clubCategory=null;
		List<com.sp.club.Category> clubCategoryItem=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=clubService.readClubInfo(clubNum);
			clubCategory=clubService.listClubCategory(clubNum);
			clubCategoryItem=clubService.listClubCategoryItems(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=clubService.isClubMember(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", clubInfo);
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		return ".club.clubBoard.list";
	}
	
	
	
	
	
	
/*
	@RequestMapping(value="/clubBoard/list")
	public String clubBoardList(
			@RequestParam int clubNum
			,@RequestParam int categoryNum
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		String isMember=null;
		List<com.sp.club.Category> clubCategory=null;
		List<com.sp.club.Category> clubCategoryItem=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=clubService.readClubInfo(clubNum);

			clubCategory=clubService.listClubCategory(clubNum);
			clubCategoryItem=clubService.listClubCategoryItems(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=clubService.isClubMember(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", clubInfo);
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		return ".club.clubBoard.list";
	}
 */
/*
	if(! info.getUserId().equals(clubInfo.getMemberNum())) {
		model.addAttribute("message", "잘못된 접근입니다.");
		return "error/error";
	}
*/
	
}
