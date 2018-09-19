package com.sp.cboard;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.boardManage.BoardManage;
import com.sp.boardManage.BoardManageService;
import com.sp.common.FileManager;
import com.sp.common.MyUtil;

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
			Model model
			) {
		List<BoardManage> boardList = mservice.listBoardManage();
		model.addAttribute("boardList", boardList);
		
		return ".cboard.list";
	}

	@RequestMapping(value="/cb_{board}/created", method=RequestMethod.GET)
	public String createdForm(
			@PathVariable String board,
	          HttpSession session,
	          Model model
			) {
		// 글쓰기 권한 처리 필요
		
		model.addAttribute("mode", "created");
		return ".cboard.created";
	}
}
