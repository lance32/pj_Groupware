package com.sp.addressBook;

import java.util.List;
import java.util.Map;

public interface AddressBookService {
	public void insertAdress(AddressBook dto);
	public void insertGroup(Map<String, Object> map);
	public void deleteGroup(int groupNum);
	public void updateGroup(Map<String, Object> map);
	public List<AddressBook> groupList(String memberNum);
	public List<AddressBook> addressList(Map<String, Object> map);
	public AddressBook readAddressInfo(int addressBookNum);
	public AddressBook readAddressForUpdate(int addressBookNum);
	public void deleteAddress(int addressBookNum);
	public void updateAddress(AddressBook dto);
	
}
