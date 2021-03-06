package com.sp.clubBoard;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.club.Club;
import com.sp.club.ClubService;
import com.sp.common.FileManager;
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
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/clubBoard/list")
	public String clubBoardMain(
			@RequestParam int clubNum
			,@RequestParam int categoryNum
			,@RequestParam(required=false) String modeScroll
			,@RequestParam(defaultValue="0") int updateBoardNum
			,@RequestParam(defaultValue="1") int pageNo
			,HttpSession session
			,Model model) {
		
		Club clubInfo=null;
		String isMember=null;
		List<com.sp.club.Category> clubCategory=null;
		List<com.sp.club.Category> clubCategoryItem=null;
		int authority=0;
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			clubInfo=clubService.readClubInfo(clubNum);
			clubCategory=clubService.listClubCategory(clubNum);
			clubCategoryItem=clubService.listClubCategoryItems(clubNum);
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			isMember=clubService.isClubMember(map);
			
			authority=clubService.readClubCategory(categoryNum);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("isMember", isMember);
		model.addAttribute("clubInfo", clubInfo);
		model.addAttribute("clubCategory", clubCategory);
		model.addAttribute("clubCategoryItem", clubCategoryItem);
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("modeScroll", modeScroll);
		model.addAttribute("updateBoardNum", updateBoardNum);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("categoryAuthority", authority);
		return ".club.clubBoard.list";
	}

	@RequestMapping(value="/clubBoard/listBoard")
	public String clubBoardList(
			@RequestParam int clubNum
			,@RequestParam int categoryNum
			,@RequestParam(required=false) String state
			,@RequestParam(value="pageNo", defaultValue="1") int current_page
			,@RequestParam(defaultValue="subject") String searchKey
			,@RequestParam(defaultValue="") String searchValue
			,HttpServletRequest req
			,HttpSession session
			,Model model) {
		
		List<Board> boardList=null;
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("categoryNum", categoryNum);
			
			if(req.getMethod().equalsIgnoreCase("GET")) {
				searchValue = URLDecoder.decode(searchValue, "utf-8");
			}
			map.put("searchKey", searchKey);
			map.put("searchValue", searchValue);
			
			dataCount = service.clubBoardCount(map);
			if(dataCount != 0) {
				total_page = util.pageCount(rows, dataCount) ;
			}
			if(total_page < current_page) {
				current_page = total_page;
			}
			int start = (current_page - 1) * rows + 1;
			if(current_page!=1) {
				start=start-1;
			}
			int end = current_page * rows;
			if(state.equals("pre")) {
				end=end+0;
			}
			map.put("start", start);
			map.put("end", end);
			
			boardList=service.listClubBoard(map);
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			String result=null;
			for(Board dto: boardList) {
				map.put("memberNum", info.getUserId());
				map.put("boardNum", dto.getBoardNum());
				result=service.isBoardLike(map);
				if(result!=null) {
					dto.setIsBoardLike(1);
				}
			}
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("boardList", boardList);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("total_page", total_page);
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("pageNo", current_page);
		return "club/clubBoard/listBoard";
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
			,@RequestParam int pageNo
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
		model.addAttribute("pageNo", pageNo);
		return ".club.clubBoard.create";
	}
	
	@RequestMapping(value="/clubBoard/updateBoard", method=RequestMethod.POST)
	public String updateBoardSubmit(
			@RequestParam(defaultValue="false") String isDeleteFile
			,@RequestParam int pageNo
			,Board dto
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
			int result=0;
			if(isDeleteFile.equals("true")) {
				dto.setSaveFileName(BoardInfo.getSaveFileName());
			}
			result=service.updateClubBoard(dto, pathname, isDeleteFile);
			
			if(result==0) {
				model.addAttribute("message", "게시글 수정에 실패했습니다.");
				return "error/error";
			}
			
		} catch (Exception e) {
			return "error/error";
		}
		redirectAttributes.addAttribute("categoryNum", BoardInfo.getCategoryNum());
		redirectAttributes.addAttribute("clubNum", dto.getClubNum());
		redirectAttributes.addAttribute("modeScroll", "update");
		redirectAttributes.addAttribute("updateBoardNum", dto.getBoardNum());
		redirectAttributes.addAttribute("pageNo", pageNo);
		return "redirect:/clubBoard/list";
	}
	
	@RequestMapping(value="/clubBoard/download")
	public void fileDownload(
			@RequestParam int boardNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception{
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"clubBoard";
		Board dto=service.readClubBoard(boardNum);
		boolean flag=false;
		
		if(dto!=null) {
			flag=fileManager.doFileDownload(
					     dto.getSaveFileName(), 
					     dto.getOriginalFileName(), pathname, resp);
		}
		if(! flag) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out=resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");
		}
	}
	
	
	@RequestMapping(value="/clubBoard/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createReply(
			@RequestParam int clubNum
			,Reply dto
			,HttpSession session) {
		
		String state="false";
		Map<String, Object> model = new HashMap<>(); 
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			String isMember=clubService.isClubMember(map);
			if(isMember==null) {
				model.put("state", state);
				return model;
			}
			dto.setMemberNum(info.getUserId());
			dto.setReplyContent(util.htmlSymbols(dto.getReplyContent()));
			
			int result=service.insertReply(dto);
			if(result==0) {
				model.put("state", state);
				return model;
			}
			state="true";
			model.put("state", state);
			
		} catch (Exception e) {
			model.put("state", state);
			return model;
		}
		return model;
	}
	
	@RequestMapping(value="/clubBoard/listReply")
	public String listReply(
			@RequestParam int boardNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		int rows=5;
		int total_page=0;
		int dataCount=0;
		List<Reply> listReply=null;
		String paging=null;
		try {
			
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("boardNum", boardNum);
			
			dataCount=service.replyCount(map);
			total_page=util.pageCount(rows, dataCount);
			if(current_page>total_page) {
				current_page=total_page;
			}
			
			int start=(current_page-1)*rows+1;
			int end=current_page*rows;
			map.put("start", start);
			map.put("end", end);
			listReply=service.listReply(map);
			
			paging=util.paging(current_page, total_page);
		} catch (Exception e) {
			return "error/error";
		}
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("paging", paging);
		return "club/clubBoard/listReply";
	}
	
	@RequestMapping(value="/clubBoard/deleteReply")
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam int replyNum
			,@RequestParam String memberNum
			,HttpSession session){
		
		String state="false";
		Map<String, Object> model = new HashMap<>(); 
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if(! memberNum.equals(info.getUserId())) {
				model.put("state", state);
				return model;
			}
			
			int result=service.deleteReply(replyNum);
			if(result==0) {
				model.put("state", state);
				return model;
			}
			state="true";
			model.put("state", state);
			
		} catch (Exception e) {
			model.put("state", state);
			return model;
		}
		return model;
	}
	
	@RequestMapping(value="/clubBoard/insertReplyAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createReplyAnswer(
			@RequestParam int clubNum
			,Reply dto
			,HttpSession session){
		String state="false";
		Map<String, Object> model = new HashMap<>(); 
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			String isMember=clubService.isClubMember(map);
			if(isMember==null) {
				model.put("state", state);
				return model;
			}
			dto.setMemberNum(info.getUserId());
			dto.setReplyContent(util.htmlSymbols(dto.getReplyContent()));
			
			int result=service.insertReplyAnswer(dto);
			
			if(result==0) {
				model.put("state", state);
				return model;
			}
			state="true";
			model.put("state", state);
			
		} catch (Exception e) {
			model.put("state", state);
			return model;
		}
		return model;
	}
	
	@RequestMapping(value="/clubBoard/listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int answer,
			Model model) throws Exception {
		List<Reply> listReplyAnswer=null;
		try {
			listReplyAnswer=service.listReplyAnswer(answer);
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "club/clubBoard/listReplyAnswer";
	}
	
	@RequestMapping(value="/clubBoard/insertBoardLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(
			@RequestParam int clubNum
			,@RequestParam int boardNum
			,HttpSession session){
		String state="false";
		Map<String, Object> model = new HashMap<>(); 
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			String isMember=clubService.isClubMember(map);
			if(isMember==null) {
				model.put("state", state);
				return model;
			}
			map.put("boardNum", boardNum);
			
			int result=service.insertBoardLike(map);
			if(result==0) {
				model.put("state", "moreLike");
				return model;
			}
			
			int boardLikeCount=service.boardLikeCount(boardNum);
			model.put("likeCount", boardLikeCount);
			
			state="true";
			model.put("state", state);
			
		} catch (Exception e) {
			model.put("state", state);
			return model;
		}
		return model;
	}
	
	@RequestMapping(value="/clubBoard/cancleBoardLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cancleBoardLike(
			@RequestParam int clubNum
			,@RequestParam int boardNum
			,HttpSession session){
		String state="false";
		Map<String, Object> model = new HashMap<>(); 
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Map<String, Object> map=new HashMap<>();
			map.put("clubNum", clubNum);
			map.put("memberNum", info.getUserId());
			String isMember=clubService.isClubMember(map);
			if(isMember==null) {
				model.put("state", state);
				return model;
			}
			map.put("boardNum", boardNum);
			
			int result=service.deleteBoardLike(map);
			if(result==0) {
				model.put("state", state);
				return model;
			}
			
			int boardLikeCount=service.boardLikeCount(boardNum);
			model.put("likeCount", boardLikeCount);
			
			state="true";
			model.put("state", state);
			
		} catch (Exception e) {
			model.put("state", state);
			return model;
		}
		return model;
	}
	
}
