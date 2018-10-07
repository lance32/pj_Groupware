package com.sp.addressBook;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.member.SessionInfo;

@Controller("addressBook.addressBookController")
public class AddressBookController {
	@Autowired
	private AddressBookService service;

	@RequestMapping(value="/addressBook/addressBook")
	public String addressBookList(
			@RequestParam(defaultValue="") String searchValue
			,@RequestParam(required=false) String state
			,HttpServletRequest req
			,HttpSession session
			, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String memberNum=info.getUserId();
		
		List<AddressBook> list = null;
		List<AddressBook> groupList =null;
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("memberNum", memberNum);
			
			if(req.getMethod().equalsIgnoreCase("GET")) {
				searchValue = URLDecoder.decode(searchValue, "utf-8");
			}
			map.put("searchValue", searchValue);
			
			list = service.addressList(map);
			groupList = service.groupList(memberNum);
		} catch (Exception e) {
			return "error/error";		
		}
		model.addAttribute("list", list);
		model.addAttribute("groupList", groupList);
		model.addAttribute("state", state);
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
		model.addAttribute("mode", "created");
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

	@RequestMapping(value="/addressBook/update", method=RequestMethod.GET)
	public String updateAddressForm(
			@RequestParam int addressBookNum
			,HttpSession session
			,Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String memberNum=info.getUserId();
		
		List<AddressBook> groupList =null;
		AddressBook dto=null;
		try {			
			groupList = service.groupList(memberNum);
			dto=service.readAddressInfo(addressBookNum);
			
		} catch (Exception e) {
			return "error/error";
		}
		model.addAttribute("groupList", groupList);
		model.addAttribute("addressInfo", dto);
		model.addAttribute("mode", "update");
		return "addressBook/addAddress";
	}
	
	@RequestMapping(value="/addressBook/update", method=RequestMethod.POST)
	public String updateAddressSubmit(AddressBook dto) {
		try {
			service.updateAddress(dto);
			
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/addressBook/addressBook";
	}
	
	@RequestMapping(value="/addressBook/createGroup", method=RequestMethod.POST)
	public String createGroup(
			@RequestParam String groupName
			,HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String memberNum=info.getUserId();
		
		try {			
			Map<String, Object> map=new HashMap<>();
			map.put("memberNum", memberNum);
			map.put("groupName", groupName);
			service.insertGroup(map);
			
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/addressBook/addressBook?state=dialogOpen";
	}
	
	@RequestMapping(value="/addressBook/deleteGroup")
	public String deleteGroup(
			@RequestParam int groupNum) {
		try {			
			service.deleteGroup(groupNum);
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/addressBook/addressBook?state=dialogOpen";
	}
	
	@RequestMapping(value="/addressBook/updateGroup")
	public String deleteGroup(
			@RequestParam String groupName
			,@RequestParam int groupNum) {
		try {			
			Map<String, Object> map=new HashMap<>();
			map.put("groupName", groupName);
			map.put("groupNum", groupNum);
			service.updateGroup(map);
		} catch (Exception e) {
			return "error/error";
		}
		return "redirect:/addressBook/addressBook?state=dialogOpen";
	}
	
}

