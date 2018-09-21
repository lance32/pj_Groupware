package com.sp.addressBook;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("addressBook.addressBookController")
public class AddressBookController {
	@Autowired
	private AddressBookService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/addressBook/addressBook")
	public String addressBookList(HttpSession session, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String memberNum=info.getUserId();
		
		List<AddressBook> list = null;
		try {
			list = service.addressList(memberNum);
		} catch (Exception e) {
			return "error/error";		
		}
		model.addAttribute("list", list);
		return "addressBook/addressBook";
	}
	
	@RequestMapping(value="/addressBook/addressInfo", method=RequestMethod.POST)
	@ResponseBody
	public AddressBook readAddressBookInfo(@RequestParam int addressBookNum) {
		AddressBook dto=service.readAddressInfo(addressBookNum);
		return dto;
	}
	
	/*	
	// 댓글 및 댓글의 답글 등록 : AJAX-JSON
	@RequestMapping(value="/bbs/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		dto.setUserId(info.getUserId());
		int result=service.insertReply(dto);
		if(result==0)
			state="false";
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
*/
	@RequestMapping(value="/addressBook/created", method=RequestMethod.GET)
	public String createdAddressForm(HttpSession session, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String memberNum=info.getUserId();
		
		List<AddressBook> list =null;
		try {			
			list = service.groupList(memberNum);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("groupList", list);
		return "addressBook/addAddress";
	}
	
	@RequestMapping(value="/addressBook/created", method=RequestMethod.POST)
	public String createdAddressSubmit(AddressBook dto) {
		try {
			service.insertAdress(dto);
			
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/addressBook/addressBook";
	}
	
}
