package com.sp.addressBook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.common.MyUtil;

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
	public String createdAddressForm() {
		
		return "addressBook/addAddress";
	}
	
	@RequestMapping(value="/addressBook/created", method=RequestMethod.POST)
	public String createdAddressSubmit(AddressBook dto) {
		
		service.insertAdress(dto);
		
		return "redirect:/addressBook/addressBook";
	}
	
}
