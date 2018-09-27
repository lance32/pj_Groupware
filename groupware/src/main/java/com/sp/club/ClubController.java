package com.sp.club;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("club.clubController")
public class ClubController {
	@Autowired
	private ClubService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/clubList/clubList")
	public String clubList(Model model) {
		List<Club> list=null;
		Map<String, Object> map=null;
		try {
			list=service.clubList(map);
		} catch (Exception e) {
			return ".error.error";
		}
		model.addAttribute("list", list);
		return ".clubList.clubList";
	}
	
	@RequestMapping(value="/clubList/createClub", method=RequestMethod.GET)
	public String createClubForm() {
		return ".clubList.createClub";
	}
	
	@RequestMapping(value="/clubList/createClub", method=RequestMethod.POST)
	public String createClubSubmit(HttpSession session, Club dto) {
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"club"+
					File.separator+info.getUserId();
			int result=service.createClub(dto, pathname);
			if(result==0) {
				return ".error.error";
			}
		} catch (Exception e) {
			return ".error.error";
		}
		return "redirect:/clubList/clubList";
	}
	
	
	
	@RequestMapping(value="/club/main")
	public String clubMain(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Club dto=null;
		String isMember=null;
		try {
			dto=service.readClubInfo(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", dto);
		return ".club.main";
	}
	
	@RequestMapping(value="/club/alterClubInfo")
	public String alterClubInfo(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Club dto=null;
		String isMember=null;
		List<Club> list=null;
		try {
			dto=service.readClubInfo(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
			list=service.listClubMember(clubNum);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", dto);
		model.addAttribute("joinMemberList", list);
		return ".club.clubManage.alterClubInfo";
	}
	
	@RequestMapping(value="/club/alterCategory")
	public String alterCategory(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Club dto=null;
		String isMember=null;
		try {
			dto=service.readClubInfo(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", dto);
		return ".club.clubManage.alterCategory";
	}
	
	@RequestMapping(value="/clubManage/updateClubInfo", method=RequestMethod.GET)
	public String updateClubInfoForm(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Club dto=null;
		String isMember=null;
		try {
			dto=service.readClubInfo(clubNum);
			
			if(! info.getUserId().equals(dto.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", dto);
		return ".club.clubManage.updateClubInfo";
	}
	
	@RequestMapping(value="/clubManage/updateClubInfo", method=RequestMethod.POST)
	public String updateClubInfoSubmit(
			Club dto
			,@RequestParam int clubNum
			,RedirectAttributes redirectAttributes
			,HttpSession session
			,Model model) {
		System.out.println("클럽넘 : "+clubNum);
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Club clubInfo=null;
		String isMember=null;
		int result=0;
		try {
			clubInfo=service.readClubInfo(clubNum);
			
			if(! info.getUserId().equals(clubInfo.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"club"+
					File.separator+info.getUserId();
			result=service.updateClubInfo(dto, pathname);
			if(result==0) {
				return "error/error";
			}
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
			
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("isMember", isMember);
		redirectAttributes.addAttribute("clubInfo", clubInfo);
		return "redirect:/club/clubManage/updateClubInfo";
	}
	
	
	
	
/*
 	@RequestMapping(value="/clubManage/updateClubInfo")
	public String updateClubInfo(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Club dto=null;
		String isMember=null;
		try {
			dto=service.readClubInfo(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", dto);
		return ".club.clubManage.alterCategory";
	}
*/	
}

