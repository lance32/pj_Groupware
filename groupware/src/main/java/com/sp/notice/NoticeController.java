package com.sp.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;

@Controller("notice.NoticeController")
public class NoticeController {

	@Autowired
	private NoticeService service;
	
	@Autowired
	private MyUtil util;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/notice/list")
	public String list() {
		return ".notice.list";
	}
	
	@RequestMapping(value="/notice/created", method=RequestMethod.GET)
	public String createForm() {
		return ".notice.created";
	}
	
	@RequestMapping(value="/notice/created", method=RequestMethod.POST)
	public String createSubmit() {
		return "redircet:/notice/list";
	}
	
}
