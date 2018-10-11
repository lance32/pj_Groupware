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

import com.sp.member.SessionInfo;

@Controller("club.clubController")
public class ClubController {
	@Autowired
	private ClubService service;

	
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
		List<com.sp.clubBoard.Board> noticeList=null;
		try {
			clubCategory=service.listClubCategory(clubNum);
			clubCategoryItem=service.listClubCategoryItems(clubNum);
			dto=service.readClubInfo(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=service.isClubMember(map);
			
			noticeList=service.listClubNotice_main(clubNum);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", dto);
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		model.addAttribute("noticeList", noticeList);
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
	
	@RequestMapping(value="/club/joinClub")
	public String joinClub(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		try {
			Club clubInfo=service.readClubInfo(clubNum);
			int memberCount=service.clubMemberCount(clubNum);
			if(clubInfo.getMaxPeople()<=memberCount) {
				model.addAttribute("message", "최대 가입인원수 제한입니다.");
				return "error/error";
			}
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			Map<String, Object> map = new HashMap<>();
			
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			
			int result=service.insertClubMember(map);
			if(result==0) {
				model.addAttribute("message", "가입도중 오류가 발생하였습니다.");
				return "error/error";
			}
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/club/main?clubNum="+clubNum;
	}
	
	@RequestMapping(value="/club/leaveClub")
	public String leaveClub(
			@RequestParam int clubNum
			,HttpSession session
			,Model model) {
		try {
			//동호회 개설자는 탈퇴할수 없음.
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			Club clubInfo=service.readClubInfo(clubNum);
			if(clubInfo.getMemberNum().equals(info.getUserId())) {
				model.addAttribute("message", "개설자는 동호회를 탈퇴할 수 없습니다.");
				return "error/error";
			}
			Map<String, Object> map = new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			
			int result=service.deleteClubMember(map);
			if(result==0) {
				model.addAttribute("message", "탈퇴도중 오류가 발생하였습니다.");
				return "error/error";
			}
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/club/main?clubNum="+clubNum;
	}

	
/*	
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
	*/

	
	
}

