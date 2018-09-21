package com.sp.addressBook;

import java.util.List;

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
	
	
	@RequestMapping(value="/addressBook/delete")
	public String deleteAddress(@RequestParam int addressBookNum) {
		try {
			service.deleteAddress(addressBookNum);
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/addressBook/addressBook";
	}
	
	
}
