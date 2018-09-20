package com.sp.addressBook;

import java.util.Map;

public interface AddressBookService {
	public void insertAdress(AddressBook dto);
	public void insertGroup(Map<String, Object> map);
	
}
