package com.sp.addressBook;

import java.util.List;
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
			dao.insertData("address.insertAdress",dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public void insertGroup(Map<String, Object> map) {
		try {
			dao.insertData("address.insertGroup",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public void deleteGroup(int groupNum) {
		try {
			dao.deleteData("address.deleteGroup", groupNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public void updateGroup(Map<String, Object> map) {
		try {
			dao.updateData("address.updateGroup", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public List<AddressBook> groupList(String memberNum) {
		List<AddressBook> list=null;
		try {
			list=dao.selectList("address.groupList", memberNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<AddressBook> addressList(Map<String, Object> map) {
		List<AddressBook> list=null;
		try {
			list=dao.selectList("address.addressList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public AddressBook readAddressInfo(int addressBookNum) {
		AddressBook dto=null;
		try {
			dto=dao.selectOne("address.readAddressInfo", addressBookNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public void deleteAddress(int addressBookNum) {
		try {
			dao.deleteData("address.deleteAddress", addressBookNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public void updateAddress(AddressBook dto) {
		try {
			dao.updateData("address.updateAddress", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public AddressBook readAddressForUpdate(int addressBookNum) {
		AddressBook dto=null;
		try {
			dto=dao.selectOne("address.readAddressForUpdate", addressBookNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}


}
