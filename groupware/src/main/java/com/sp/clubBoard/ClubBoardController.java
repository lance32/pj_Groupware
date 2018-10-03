package com.sp.clubBoard;

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
		
		List<Board> boardList=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=clubService.readClubInfo(clubNum);
			clubCategory=clubService.listClubCategory(clubNum);
			clubCategoryItem=clubService.listClubCategoryItems(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=clubService.isClubMember(map);
			
			map.put("categoryNum", categoryNum);
			boardList=service.listClubBoard(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", clubInfo);
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("boardList", boardList);
		return ".club.clubBoard.list";
	}
	
	@RequestMapping(value="/clubBoard/createBoard", method=RequestMethod.GET)
	public String createBoardForm(
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
			if(isMember==null) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", clubInfo);
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("mode", "create");
		return ".club.clubBoard.create";
	}
	
	@RequestMapping(value="/clubBoard/createBoard", method=RequestMethod.POST)
	public String createBoardSubmit(
			Board dto
			,HttpSession session
			,Model model
			,RedirectAttributes redirectAttributes) {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", dto.getClubNum());
			map.put("memberNum", info.getUserId());
			String isMember=clubService.isClubMember(map);
			if(isMember==null) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"clubBoard";
			
			int result=service.insertClubBoard(dto, pathname);
			if(result==0) {
				model.addAttribute("message", "게시글 등록에 실패했습니다.");
				return "error/error";
			}
			
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("categoryNum", dto.getCategoryNum());
		redirectAttributes.addAttribute("clubNum", dto.getClubNum());
		return "redirect:/clubBoard/list";
	}
	
	@RequestMapping(value="/clubBoard/deleteBoard")
	public String deleteBoard(
			@RequestParam int boardNum
			,@RequestParam int clubNum
			,HttpSession session
			,Model model
			,RedirectAttributes redirectAttributes) {
		
		Board dto=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto=service.readClubBoard(boardNum);
			
			if(! dto.getMemberNum().equals(info.getUserId())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			
			String saveFilename=dto.getSaveFileName();
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"clubBoard";
			
			
			int result=service.deleteClubBoard(boardNum, saveFilename, pathname);
			if(result==0) {
				model.addAttribute("message", "게시글 삭제에 실패했습니다.");
				return "error/error";
			}
			
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("categoryNum", dto.getCategoryNum());
		redirectAttributes.addAttribute("clubNum", clubNum);
		return "redirect:/clubBoard/list";
	}
	
	@RequestMapping(value="/clubBoard/updateBoard", method=RequestMethod.GET)
	public String updateBoardForm(
			@RequestParam int clubNum
			,@RequestParam int categoryNum
			,@RequestParam int boardNum
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		String isMember=null;
		List<com.sp.club.Category> clubCategory=null;
		List<com.sp.club.Category> clubCategoryItem=null;
		
		Board dto=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto=service.readClubBoard(boardNum);
			
			if(! dto.getMemberNum().equals(info.getUserId())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			
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
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("BoardInfo", dto);
		model.addAttribute("mode", "update");
		return ".club.clubBoard.create";
	}
	
	@RequestMapping(value="/clubBoard/updateBoard", method=RequestMethod.POST)
	public String updateBoardSubmit(
			Board dto
			,HttpSession session
			,Model model
			,RedirectAttributes redirectAttributes) {
		
		Board BoardInfo=null;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			BoardInfo=service.readClubBoard(dto.getBoardNum());
			
			if(! BoardInfo.getMemberNum().equals(info.getUserId())) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return "error/error";
			}
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"clubBoard";
			
			int result=service.updateClubBoard(dto, pathname);
			if(result==0) {
				model.addAttribute("message", "게시글 수정에 실패했습니다.");
				return "error/error";
			}
			
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("categoryNum", BoardInfo.getCategoryNum());
		redirectAttributes.addAttribute("clubNum", dto.getClubNum());
		return "redirect:/clubBoard/list";
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
