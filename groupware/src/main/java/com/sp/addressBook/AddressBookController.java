package com.sp.addressBook;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("addressBook.addressBookController")
public class AddressBookController {
	@Autowired
	private AddressBookService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/addressBook/addressBook")
	public String addressBookList() {
		
		return "addressBook/addressBook";
	}
	
	@RequestMapping(value="/addressBook/created", method=RequestMethod.GET)
	public String createdAddressForm(HttpSession session, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String memberNum=info.getUserId();
		
		List<AddressBook> list =null;
		try {			
			list = service.groupList(memberNum);
			
		} catch (Exception e) {
			return "error.error";
		}
		model.addAttribute("groupList", list);
		return "addressBook/addAddress";
	}
	
	@RequestMapping(value="/addressBook/created", method=RequestMethod.POST)
	public String createdAddressSubmit(AddressBook dto) {
		
		service.insertAdress(dto);
		
		return "redirect:/addressBook/addressBook";
	}
	
}
