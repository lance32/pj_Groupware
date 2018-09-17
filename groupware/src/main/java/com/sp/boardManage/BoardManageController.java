package com.sp.boardManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("boardManage.boardManageController")
public class BoardManageController {
	
	@Autowired
	BoardManageService service;

	@RequestMapping(value="/boardManage/list")
	public String list(Model model) {
		int dataCount = service.dataCount();
		List<BoardManage> list = service.listBoardManage();
		
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("list", list);
		
		return ".boardManage.list";
	}
	
	@RequestMapping(value="/boardManage/created", method=RequestMethod.GET)
	public String createdForm(Model model) {
		model.addAttribute("mode", "created");
		return ".boardManage.created";
	}
	
	@RequestMapping(value="/boardManage/created", method=RequestMethod.POST)
	public String createdSubmit(
			BoardManage dto,
			Model model) {
		
		dto.setTableName("cb_"+dto.getTableName());
		service.createBoardManage(dto);
		return "redirect:/boardManage/list";
	}
}
