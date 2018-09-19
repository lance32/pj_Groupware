package com.sp.addressBook;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("addressBook.addressBookService")
public class AddressBookServiceImpl implements AddressBookService{
	@Autowired
	private CommonDAO  dao;
	
	@Override
	public void insertAdress(AddressBook dto) {
		try {
			dao.insertData("adress.insertAdress",dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public void insertGroup(Map<String, Object> map) {
		try {
			dao.insertData("adress.insertGroup",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	
}
