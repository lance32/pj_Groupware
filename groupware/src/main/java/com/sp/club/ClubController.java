package com.sp.club;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
			return "error/error";
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
				return "error/error";
			}
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/clubList/clubList";
	}
	
	@RequestMapping(value="/club/main")
	public String clubMain(
			@RequestParam int clubNum
			,Model model) {
		Club dto=null;
		try {
			dto=service.readClubInfo(clubNum);
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("clubInfo", dto);
		return ".club.main";
	}
	
	
	
}

