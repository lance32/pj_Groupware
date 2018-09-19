package com.sp.cboard;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.boardManage.BoardManage;
import com.sp.boardManage.BoardManageService;
import com.sp.common.FileManager;
import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("cboard.boardController")
public class BoardController {
	
	@Autowired
	private BoardService service;
	@Autowired
	private BoardManageService mservice;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/cb_{board}/list")
	public String list(
			@PathVariable String board,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model,
			Map<String, Object> paramMap
			) throws Exception {
		String cp = req.getContextPath();
		
		BoardManage cb = mservice.readBoardManage("cb_"+board);
		if(cb == null)
			// 수정 필요
			return "redirect:/";
		
		paramMap.put("tableName", cb.getTableName());
		paramMap.put("searchKey", searchKey);
		paramMap.put("searchValue", searchValue);
		paramMap.put("canAnswer", cb.getCanAnswer());
		
		int rows = 10;
		int dataCount = service.dataCount(paramMap);
		int total_page = util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page = total_page;
		
		int start = (current_page-1) * rows + 1;
		int end = (current_page) * rows;
		
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		// 게시판 목록(사이드 메뉴 출력용)
		List<BoardManage> boardList = mservice.listBoardManage();
		List<Board> list = service.listBoard(paramMap);
		
        String query = "";
        String listUrl = ""; 
        String articleUrl = "";
        if(searchValue.length()!=0) {
        	query = "searchKey=" +searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(query.equals("")) {
        	listUrl = cp+"/cb_"+board+"/list";
        	articleUrl = cp+"/cb_"+board+"/article?page=" + current_page;
        } else {
        	listUrl = cp+"/cb_"+board+"/list?" + query;
        	articleUrl = cp+"/cb_"+board+"/article?page=" + current_page + "&"+ query;
        }
		String paging = util.paging(current_page, total_page, listUrl);
        
		model.addAttribute("cb", cb);
		model.addAttribute("boardList", boardList);
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("boardList", boardList);
		model.addAttribute("paging", paging);		
		
		return ".cboard.list";
	}

	@RequestMapping(value="/cb_{board}/created", method=RequestMethod.GET)
	public String createdForm(
			@PathVariable String board,
	          HttpSession session,
	          Model model
			) {
		BoardManage cb = mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	return "redirect:/";
   	    }
   	    
   	    // 글쓰기 권한 처리 필요(session 활용)
   	    /*
		 SessionInfo info=(SessionInfo)session.getAttribute("member");
			if(cb.getMemberLevel()>info.getMemberLevel()) {
			return ".member.noAuthorized";
			}
			형태로 구현
   	     * */
   	    
		// 게시판 목록(사이드 메뉴 출력용)
		List<BoardManage> boardList = mservice.listBoardManage();
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("mode", "created");
		model.addAttribute("cb", cb);
		
		return ".cboard.created";
	}
	
	@RequestMapping(value="/cb_{board}/created", method=RequestMethod.POST)
	public String createdSubmit(
			@PathVariable String board,
			Board dto,
			HttpSession session,
			Model model
			) {
		// 글쓰기 권한 처리 필요
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		BoardManage cb=mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	return "redirect:/";
   	    }
   	    
   	    String root = session.getServletContext().getRealPath("/");
   	    String pathname = root + "uploads" + File.separator + "cboard";
   	    
   	    dto.setTableName(cb.getTableName());
   	    dto.setMemberNum(info.getUserId());
   	    
   	    service.insertBoard(dto, "created", pathname);
   	    
   	    return "redirect:/cb_"+board+"/list";
	}
	
	@RequestMapping(value="/cb_{board}/article", method=RequestMethod.GET)
	public String article(
			@PathVariable String board,
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Map<String, Object> paramMap,
			HttpSession session,
			Model model
			) throws Exception {
		
		BoardManage cb=mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	return "redirect:/";
   	    }
   	    searchValue = URLDecoder.decode(searchValue, "UTF-8");
		String query = "page="+page;
		if(searchValue.length() != 0) {
			query += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		
		paramMap.put("tableName", cb.getTableName());
		paramMap.put("canAnswer", cb.getCanAnswer());
		paramMap.put("num", num);
		
		service.updateHitCount(paramMap);
		
		Board dto = service.readBoard(paramMap);
		if(dto == null)
			return "redirect:/cb_"+board+"/list?"+query;
		dto.setContent(util.htmlSymbols(dto.getContent()));
		
		paramMap.put("searchKey", searchKey);
		paramMap.put("searchValue", searchValue);
		if(cb.getCanAnswer()==1) {
			paramMap.put("groupNum", dto.getGroupNum());
			paramMap.put("orderNo", dto.getOrderNo());
		}
		
		Board preReadDto = service.preReadBoard(paramMap);
		Board nextReadDto = service.nextReadBoard(paramMap);
		
		int boardLikeCount = 0;
		if(cb.getCanLike() == 1) {
			boardLikeCount = service.boardLikeCount(paramMap);
		}
		List<Board> listFile = service.listFile(paramMap);
		
		// 게시판 목록(사이드 메뉴 출력용)
		List<BoardManage> boardList = mservice.listBoardManage();
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("boardLikeCount", boardLikeCount);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("boardList", boardList);
		model.addAttribute("cb", cb);
		
		return ".cboard.article";
	}
}
