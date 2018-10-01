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
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

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
		List<Category> clubCategory=null;
		List<Category> clubCategoryItem=null;
		Club dto=null;
		String isMember=null;
		try {
			clubCategory=service.listClubCategory(clubNum);
			clubCategoryItem=service.listClubCategoryItems(clubNum);
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
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		return ".club.main";
	}
	
	@RequestMapping(value="/club/alterClubInfo")
	public String alterClubInfo(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		List<Category> clubCategory=null;
		List<Category> clubCategoryItem=null;
		Club dto=null;
		String isMember=null;
		List<Club> list=null;
		try {
			clubCategory=service.listClubCategory(clubNum);
			clubCategoryItem=service.listClubCategoryItems(clubNum);
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
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		return ".club.clubManage.alterClubInfo";
	}
	
	@RequestMapping(value="/clubManage/updateClubInfo", method=RequestMethod.GET)
	public String updateClubInfoForm(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		List<Category> clubCategory=null;
		List<Category> clubCategoryItem=null;
		Club dto=null;
		String isMember=null;
		try {
			clubCategory=service.listClubCategory(clubNum);
			clubCategoryItem=service.listClubCategoryItems(clubNum);
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
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		return ".club.clubManage.updateClubInfo";
	}
	
	@RequestMapping(value="/clubManage/updateClubInfo", method=RequestMethod.POST)
	public String updateClubInfoSubmit(
			Club dto
			,RedirectAttributes redirectAttributes
			,HttpSession session
			,Model model) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Club clubInfo=null;
		int result=0;
		
		try {
			clubInfo=service.readClubInfo(dto.getClubNum()); 
			
			if(! info.getUserId().equals(clubInfo.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"club"+
					File.separator+info.getUserId();
			result=service.updateClubInfo(dto, pathname);
			if(result==0) {
				model.addAttribute("message", "수정에 실패했습니다.");
				return "error/error";
			}
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("clubNum", dto.getClubNum());
		return "redirect:/club/alterClubInfo";
	}
	
	@RequestMapping(value="/club/deleteClub")
	public String deleteClub(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=service.readClubInfo(clubNum); 
			if(! info.getUserId().equals(clubInfo.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"club"+
					File.separator+info.getUserId();
			int result=service.deleteClub(clubNum, pathname);
			if(result==0) {
				model.addAttribute("message", "삭제에 실패했습니다.");
				return ".error.error";
			}
		} catch (Exception e) {
			return ".error.error";
		}
		return "redirect:/clubList/clubList";
	}
	
	@RequestMapping(value="/club/alterCategory")
	public String alterCategory(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		String isMember=null;
		List<Category> clubCategory=null;
		List<Category> clubCategoryItem=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=service.readClubInfo(clubNum);
			if(! info.getUserId().equals(clubInfo.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			clubCategory=service.listClubCategory(clubNum);
			clubCategoryItem=service.listClubCategoryItems(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", clubInfo);
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		return ".club.clubManage.alterCategory";
	}
	
	@RequestMapping(value="/clubManage/createCategory")
	public String createCategory(
			Category dto
			,RedirectAttributes redirectAttributes
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=service.readClubInfo(dto.getClubNum());
			if(! info.getUserId().equals(clubInfo.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			if(dto.getSeparate()==1) {
				service.insertCategoryPhase1(dto);
			}else if(dto.getSeparate()==2) {
				service.insertCategoryPhase2(dto);
			}
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("clubNum", dto.getClubNum());
		return "redirect:/club/alterCategory";
	}
	
	@RequestMapping(value="/clubManage/deleteCategory")
	public String deleteCategory(
			@RequestParam int categoryNum
			,@RequestParam int clubNum
			,RedirectAttributes redirectAttributes
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=service.readClubInfo(clubNum);
			if(! info.getUserId().equals(clubInfo.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			service.deleteClubCategory(categoryNum);
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("clubNum", clubNum);
		return "redirect:/club/alterCategory";
	}
	
	@RequestMapping(value="/clubManage/updateCategory")
	public String updateCategory(
			Category dto
			,RedirectAttributes redirectAttributes
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=service.readClubInfo(dto.getClubNum());
			if(! info.getUserId().equals(clubInfo.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			service.updateClubCategory(dto);
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("clubNum", dto.getClubNum());
		return "redirect:/club/alterCategory";
	}

	
/*	
	@RequestMapping(value="/club/alterCategory")
	public String alterCategory(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
			
		Club clubInfo=null;
		String isMember=null;
		List<Club> clubCategory=null;
		List<Category> clubCategoryItem=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=service.readClubInfo(clubNum);
			if(! info.getUserId().equals(clubInfo.getMemberNum())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			clubCategory=service.listClubCategory(clubNum);
			clubCategoryItem=service.listClubCategoryItems(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", clubInfo);
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		return ".club.clubManage.alterCategory";
	}
	*/

	
	
}

