package com.sp.boardManage;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.member.SessionInfo;

@Controller("boardManage.boardManageController")
public class BoardManageController {
	
	@Autowired
	BoardManageService service;

	@RequestMapping(value="/boardManage/list")
	public String list(Model model, HttpSession session) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if((info.getGrants() & 768) != 768) {
				String message = "접근 권한 없음";
				model.addAttribute("message", message);
				return ".error.error";
			}
			
			int dataCount = service.dataCount();
			List<BoardManage> list = service.listBoardManage();
			
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("list", list);			
		} catch (Exception e) {
			System.out.println(e.toString());
			return "error.error";
		}
		return ".boardManage.list";
	}
	
	@RequestMapping(value="/boardManage/created", method=RequestMethod.GET)
	public String createdForm(Model model, HttpSession session) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if((info.getGrants() & 768) != 768) {
				String message = "접근 권한 없음";
				model.addAttribute("message", message);
				return ".error.error";
			}
			
			List<BoardManage> list = service.listBoardManage();
			
			model.addAttribute("list", list);
			model.addAttribute("mode", "created");
		} catch (Exception e) {
			System.out.println(e.toString());
			return "error.error";
		}
		return ".boardManage.created";
	}
	
	@RequestMapping(value="/boardManage/created", method=RequestMethod.POST)
	public String createdSubmit(
			BoardManage dto,
			Model model,
			HttpSession session) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if((info.getGrants() & 768) != 768) {
				String message = "접근 권한 없음";
				model.addAttribute("message", message);
				return ".error.error";
			}
			
			dto.setTableName("cb_"+dto.getTableName());
			int result = service.createBoardManage(dto);
			
			if(result == 0) {
				String msg = "테이블 명 중복 등의 문제로 게시판 생성에 실패했습니다. 내용을 다시 입력하세요.";
				model.addAttribute("mode", "created");
				model.addAttribute("msg", msg);
				return ".boardManage.created";
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			return "error.error";
		}
		return "redirect:/boardManage/list";
	}
	
	@RequestMapping(value="/boardManage/update", method=RequestMethod.GET)
	public String updateForm(
			Model model,
			HttpSession session,
			@RequestParam int boardNum) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if((info.getGrants() & 768) != 768) {
				String message = "접근 권한 없음";
				model.addAttribute("message", message);
				return ".error.error";
			}
			
			BoardManage dto=service.readBoardManage(boardNum);
			if(dto==null) {
				return "redirect:/boardManage/list";
			}
			
			String []ss=dto.getTableName().split("_");
			if(ss!=null && ss.length==2) {
				dto.setTableName(ss[1]);
			} else {
				return "redirect:/boardManage/list";
			}
			List<BoardManage> list = service.listBoardManage();
			
			model.addAttribute("list", list);
			model.addAttribute("mode", "update");
			model.addAttribute("dto", dto);
			
		} catch (Exception e) {
			System.out.println(e.toString());
			return "error.error";
		}
		return ".boardManage.created";
	}
	
	@RequestMapping(value="/boardManage/update", method=RequestMethod.POST)
	public String updateSubmit(
			HttpSession session,
			Model model,
			BoardManage dto) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if((info.getGrants() & 768) != 768) {
				String message = "접근 권한 없음";
				model.addAttribute("message", message);
				return ".error.error";
			}
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+File.separator+"uploads"+File.separator+"cboard";
			
			dto.setTableName("cb_"+dto.getTableName());
			service.updateBoardManage(dto, pathname);
		} catch (Exception e) {
			System.out.println(e.toString());
			return "error.error";
		}
		return "redirect:/boardManage/list";
	}
	
	@RequestMapping(value="/boardManage/delete")
	public String delete(
			HttpSession session,
			Model model,
			@RequestParam int boardNum) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if((info.getGrants() & 768) != 768) {
				String message = "접근 권한 없음";
				model.addAttribute("message", message);
				return ".error.error";
			}
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+File.separator+"uploads"+File.separator+"cboard";
			service.deleteBoardManage(boardNum, pathname);
		} catch (Exception e) {
			System.out.println(e.toString());
			return "error.error";
		}
		return "redirect:/boardManage/list";
	}
}
