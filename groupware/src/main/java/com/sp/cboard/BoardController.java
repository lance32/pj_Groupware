package com.sp.cboard;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
			HttpSession session,
			Model model,
			Map<String, Object> paramMap
			) throws Exception {
		try {
			String cp = req.getContextPath();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			BoardManage cb = mservice.readBoardManage("cb_"+board);
			if(cb == null)
				// 수정 필요
				return "error.error";
			
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
			
			if((info.getGrants() & 768) == 768) {
				String msg = "admin";
				model.addAttribute("msg", msg);
			} else {
				String msg = "user";
				model.addAttribute("msg", msg);
			}
			
			model.addAttribute("cb", cb);
			model.addAttribute("boardList", boardList);
			model.addAttribute("list", list);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("boardList", boardList);
			model.addAttribute("paging", paging);		
		} catch (Exception e) {
			System.out.println(e.toString());
			return ".error.error";
		}
		return ".cboard.list";
	}

	@RequestMapping(value="/cb_{board}/created", method=RequestMethod.GET)
	public String createdForm(
			@PathVariable String board,
	          HttpSession session,
	          Model model
			) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			BoardManage cb = mservice.readBoardManage("cb_"+board);
			if(cb==null) {
				return "error.error";
			}
			
			if(cb.getWritePermit() == 0) {
				if((info.getGrants() & 768) != 768) {
					String message = "접근 권한 없음";
					model.addAttribute("message", message);
					return ".error.error";
				}
			}
			
			// 게시판 목록(사이드 메뉴 출력용)
			List<BoardManage> boardList = mservice.listBoardManage();
			
			model.addAttribute("boardList", boardList);
			model.addAttribute("mode", "created");
			model.addAttribute("cb", cb);
		} catch (Exception e) {
			System.out.println(e.toString());
			return ".error.error";
		}
		return ".cboard.created";
	}
	
	@RequestMapping(value="/cb_{board}/created", method=RequestMethod.POST)
	public String createdSubmit(
			@PathVariable String board,
			Board dto,
			HttpSession session,
			Model model
			) {
		try {
			// 글쓰기 권한 처리 필요
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			BoardManage cb=mservice.readBoardManage("cb_"+board);
			if(cb==null) {
				return "error.error";
			}
			
			if(cb.getWritePermit() == 0) {
				if((info.getGrants() & 768) != 768) {
					String message = "접근 권한 없음";
					model.addAttribute("message", message);
					return ".error.error";
				}
			}
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "cboard";
			
			dto.setTableName(cb.getTableName());
			dto.setMemberNum(info.getUserId());
			
			service.insertBoard(dto, "created", pathname);
			
		} catch (Exception e) {
			System.out.println(e.toString());
			return ".error.error";
		}
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
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			BoardManage cb=mservice.readBoardManage("cb_"+board);
			if(cb==null) {
				return "error.error";
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
			
			if((info.getGrants() & 768) == 768) {
				String msg = "admin";
				model.addAttribute("msg", msg);
			} else {
				String msg = "user";
				model.addAttribute("msg", msg);
			}
			
			model.addAttribute("dto", dto);
			model.addAttribute("preReadDto", preReadDto);
			model.addAttribute("nextReadDto", nextReadDto);
			model.addAttribute("boardLikeCount", boardLikeCount);
			model.addAttribute("listFile", listFile);
			model.addAttribute("page", page);
			model.addAttribute("query", query);
			model.addAttribute("boardList", boardList);
			model.addAttribute("cb", cb);
			
		} catch (Exception e) {
			System.out.println(e.toString());
			return ".error.error";
		}
		return ".cboard.article";
	}
	
	// 파일 다운로드
	@RequestMapping(value="/cb_{board}/download")
	public void download(
			@PathVariable String board,
			@RequestParam(value="fileNum") int fileNum,
			HttpServletResponse resp,
			HttpSession session,
			Map<String, Object> paramMap
			) throws Exception {
		
		try {
			BoardManage cb=mservice.readBoardManage("cb_"+board);
			if(cb==null)
				return;
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "cboard";
			
			boolean b = false;
			paramMap.put("tableName", cb.getTableName());
			paramMap.put("fileNum", fileNum);
			
			Board dto = service.readFile(paramMap);
			if(dto != null) {
				String saveFilename = dto.getSaveFilename();
				String originalFilename = dto.getOriginalFilename();
				
				b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
			}
			
			if(! b) {
				try {
					resp.setContentType("text/html; charset=utf-8");
					PrintWriter out = resp.getWriter();
					out.println("<script>alert('파일 다운로드에 실패했습니다.');history.back();</script>");
				} catch (Exception e) {
					System.out.println(e.toString());
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	
	// 파일 삭제
	@RequestMapping(value="/cb_{board}/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@PathVariable String board,
			@RequestParam(value="fileNum") int fileNum,
			HttpSession session
			) {
		String state="false";
		BoardManage cb=mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   			Map<String, Object> model = new HashMap<>(); 
   			model.put("state", state);
   			return model;
   	    }
 		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "cboard";
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", cb.getTableName());
		map.put("fileNum", fileNum);
		
		Board dto=service.readFile(map);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		state="true";
		
		map.put("field", "fileNum");
		map.put("num", fileNum);
		service.deleteFile(map);
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/cb_{board}/update", method=RequestMethod.GET)
	public String updateForm(
			@PathVariable String board,
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page,
			HttpSession session,
			Map<String, Object> paramMap,
			Model model
			) {
		try {
			BoardManage cb=mservice.readBoardManage("cb_"+board);
	   	    if(cb==null) {
	   	    	return "error.error";
	   	    }
	   	    SessionInfo info=(SessionInfo)session.getAttribute("member");
	   	    // 권한 처리 필요
			if(cb.getWritePermit() == 0) {
				if((info.getGrants() & 768) != 768) {
					String message = "접근 권한 없음";
					model.addAttribute("message", message);
					return ".error.error";
				}
			}
	   	    
	   	    paramMap.put("tableName", cb.getTableName());
	   	    paramMap.put("num", num);
	   	    
	   	    Board dto = service.readBoard(paramMap);
	   	    if(dto == null) {
	   	    	return "redirect:/cb_"+board+"/list?page="+page;
	   	    }
	   	    
	   	    if(! info.getUserId().equals(dto.getMemberNum())) {
	   	    	return "redirect:/cb_"+board+"/list?page="+page;
	   	    }
	   	    List<Board> listFile = service.listFile(paramMap);
	   	    // 게시판 목록(사이드 메뉴 출력용)
	   	    List<BoardManage> boardList = mservice.listBoardManage();
	   	    
	   	    model.addAttribute("cb", cb);
	   	    model.addAttribute("mode", "update");
	   	    model.addAttribute("page", page);
	   	    model.addAttribute("listFile", listFile);
	   	    model.addAttribute("boardList", boardList);
	   	    model.addAttribute("dto", dto);
	   	    
		} catch (Exception e) {
			System.out.println(e.toString());
			return ".error.error";
		}
		return ".cboard.created";
	}

	@RequestMapping(value="/cb_{board}/update", method=RequestMethod.POST)
	public String updateSubmit(
			@PathVariable String board,
			@RequestParam(value="page") String page,
			Board dto,
			Model model,
			HttpSession session
			) {
		try {
			BoardManage cb=mservice.readBoardManage("cb_"+board);
	   	    if(cb==null) {
	   	    	return "error.error";
	   	    }
	   	    
	   	    SessionInfo info=(SessionInfo)session.getAttribute("member");
	   	    // 권한 처리 필요
			if(cb.getWritePermit() == 0) {
				if((info.getGrants() & 768) != 768) {
					String message = "접근 권한 없음";
					model.addAttribute("message", message);
					return ".error.error";
				}
			}
	   	    
	   	    String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "cboard";
			
			dto.setTableName(cb.getTableName());
			dto.setMemberNum(info.getUserId());
			service.updateBoard(dto, pathname);
			
		} catch (Exception e) {
			System.out.println(e.toString());
			return ".error.error";
		}
		return "redirect:/cb_"+board+"/list?page="+page;
	}
	
	// 게시물 삭제
	@RequestMapping(value="/cb_{board}/delete", method=RequestMethod.GET)
	public String delete(
			@PathVariable String board,
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page,
			HttpSession session,
			Model model) throws Exception {
		try {
			BoardManage cb=mservice.readBoardManage("cb_"+board);
	   	    if(cb==null) {
	   	    	return "error.error";
	   	    }
	 		
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "cboard";		
			
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			// 권한 처리 필요
			if(cb.getWritePermit() == 0) {
				if((info.getGrants() & 768) != 768) {
					String message = "접근 권한 없음";
					model.addAttribute("message", message);
					return ".error.error";
				}
			}
			
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", cb.getTableName());
			map.put("num", num);
			map.put("pathname", pathname);
			
			Board dto = service.readBoard(map);
			if(dto==null) {
				return "redirect:/cb_"+board+"/list?page="+page;
			}
			
			if(! info.getUserId().equals(dto.getMemberNum())) {
				return "redirect:/cb_"+board+"/list?page="+page;
			}
			
			// 내용 지우기
			service.deleteBoard(map);
			
		} catch (Exception e) {
			System.out.println(e.toString());
			return ".error.error";
		}
		
		return "redirect:/cb_"+board+"/list?page="+page;
	}
	
	// 게시물 답변 폼
	@RequestMapping(value = "/cb_{board}/answer", method=RequestMethod.GET)
	public String answerForm(
			@PathVariable String board,
			@RequestParam(value = "num") int num,
			@RequestParam(value = "page") String page,
			HttpSession session,
			Model model) throws Exception {
		
		BoardManage cb = mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	return ".error.error";
   	    }
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		// 권한 처리 필요(페이지 이동)
		if(cb.getWritePermit() == 0) {
			if((info.getGrants() & 768) != 768) {
				String message = "접근 권한 없음";
				model.addAttribute("message", message);
				return ".error.error";
			}
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", cb.getTableName());
		map.put("num", num);
		
		Board dto = service.readBoard(map);
		if (dto == null) {
			return "redirect:/cb_"+board+"/list?page="+page;
		}

		String str ="[ "+dto.getNum()+"번 게시물 ] "+dto.getTitle()+" 에 대한 답변입니다.\n";
		dto.setTitle(str);
        
		model.addAttribute("cb", cb);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "answer");

		return ".cboard.created";
	}
	
	// 답변 완료
	@RequestMapping(value="/cb_{board}/answer", method = RequestMethod.POST)
	public String replySubmit(
			@PathVariable String board,
			Board dto,
			@RequestParam(value="page") String page,
			Model model,
			HttpSession session) throws Exception {
		
		BoardManage cb = mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	return ".error.error";
   	    }
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		// 권한 처리 필요
		if(cb.getWritePermit() == 0) {
			if((info.getGrants() & 768) != 768) {
				String message = "접근 권한 없음";
				model.addAttribute("message", message);
				return ".error.error";
			}
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "cboard";		
		
		dto.setTableName(cb.getTableName());
		dto.setMemberNum(info.getUserId());
		service.insertBoard(dto,"answer", pathname);

		return "redirect:/cb_"+board+"/list?page="+page;
	}

	// 게시물 좋아요
	@RequestMapping(value="/cb_{board}/insertBoardLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(
			@PathVariable String board,
			Board dto,
			HttpSession session
			) {
		Map<String, Object> model = new HashMap<>(); 
		try {
			SessionInfo info=(SessionInfo) session.getAttribute("member");
			String state="true";
			int boardLikeCount=0;
			
			BoardManage cb=mservice.readBoardManage("cb_"+board);
	   	    if(cb==null) {
	   	    	state="noTable";
	   	    } else {
				dto.setTableName(cb.getTableName());
				dto.setMemberNum(info.getUserId());
				int result=service.insertBoardLike(dto);
				
				Map<String, Object> map = new HashMap<>();
				map.put("tableName", cb.getTableName());
				map.put("num", dto.getNum());
				boardLikeCount=service.boardLikeCount(map);
				
				if(result==0) {
					state="false";
					boardLikeCount=service.boardLikeCount(map);
				}
	   	    }
			model.put("state", state);
			model.put("boardLikeCount", boardLikeCount);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return model;
	}
	
	// 댓글 리스트
	@RequestMapping(value="/cb_{board}/listReply")
	public String listReply(
			@PathVariable String board,
			Map<String, Object> paramMap,
			@RequestParam(value="num") int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		BoardManage cb = mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	return "error.error";
   	    }
   	    
   	    paramMap.put("tableName", cb.getTableName());
   	    paramMap.put("num", num);
   	    
   	    int rows = 5;
   	    int dataCount = service.replyCount(paramMap);
   	    int total_page = util.pageCount(rows, dataCount);
   	    
   	    if(current_page > total_page)
   	    	current_page = total_page;
   	    
   	    int start = (current_page-1)*rows+1;
   	    int end = current_page*rows;
   	    
   	    paramMap.put("start", start);
   	    paramMap.put("end", end);
   	    
   	    List<Reply> listReply = service.listReply(paramMap);
   	    for(Reply dto : listReply) {
   	    	dto.setContent(util.htmlSymbols(dto.getContent()));
   	    }
   	    String paging = util.paging(current_page, total_page);
   	    
   	    model.addAttribute("cb", cb);
   	    model.addAttribute("listReply", listReply);
   	    model.addAttribute("pageNo", current_page);
   	    model.addAttribute("replyCount", dataCount);
   	    model.addAttribute("total_page", total_page);
   	    model.addAttribute("paging", paging);
		
		return "cboard/listReply";
	}
	
	// 댓글 and 답글 추가
	@RequestMapping(value="/cb_{board}/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			@PathVariable String board,
			Reply dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		String state="true";
		
		BoardManage cb = mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	state="noTable";
   	    } else {
   	    	dto.setTableName(cb.getTableName());
   	    	dto.setMemberNum(info.getUserId());
   	    	dto.setName(info.getUserName());
   	    	
   	    	int result=service.insertReply(dto);
   	    	if(result==0)
   	    		state="false";
   	    }
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// 댓글 댓답글 삭제
	@RequestMapping(value="/cb_{board}/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@PathVariable String board,
			@RequestParam(value="replyNum") int replyNum,
			@RequestParam(value="mode") String mode,
			HttpSession session) throws Exception {
		
		String state="true";
		BoardManage cb = mservice.readBoardManage("cb_"+board);
   	    if(cb == null) {
   	    	state="noTable";
   	    } else {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", cb.getTableName());
			map.put("mode", mode);
			map.put("replyNum", replyNum);
	
			int result=service.deleteReply(map);
			if(result==0)
				state="false";
   	    }
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// 댓답글 리스트
	@RequestMapping(value="/cb_{board}/listReplyAnswer")
	public String listReplyAnswer(
			@PathVariable String board,
			@RequestParam(value="answer") int answer,
			Model model) throws Exception {

		BoardManage cb = mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	return ".error.error";
   	    }
   	    
   	    Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", cb.getTableName());
		map.put("answer", answer);
		
		List<Reply> listReplyAnswer=service.listReplyAnswer(map);
		
		for(Reply dto : listReplyAnswer) {
   	    	dto.setContent(util.htmlSymbols(dto.getContent()));
   	    }
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		return "cboard/listReplyAnswer";
	}
	// 댓답글 개수
	@RequestMapping(value="/cb_{board}/countReplyAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
			@PathVariable String board,
			@RequestParam(value="answer") int answer) throws Exception {

		String state="true";
		int count=0;
		
		BoardManage cb = mservice.readBoardManage("cb_"+board);
   	    if(cb==null) {
   	    	state="noTable";
   	    } else {
   	   	    Map<String, Object> map=new HashMap<String, Object>();
   			map.put("tableName", cb.getTableName());
   			map.put("answer", answer);
  	    
   	    	count=service.replyAnswerCount(map);
   	    }
   	    
   	    Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("count", count);
		return model;
	}
	
}
