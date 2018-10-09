package com.sp.pay;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("pay.payService")
public class PayServiceImpl implements PayService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
			int result=0;
		try {
			result=dao.selectOne("pay.dataCount",map);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int memberdataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("pay.memberdataCount",map);
		} catch (Exception e) {

		}
		
		return result;
	}
	
	@Override
	public List<Pay> ListPayMember(Map<String, Object> map) {
		List<Pay> payList=null;
			System.out.println(map);
			try {
				payList=dao.selectList("pay.listPayMember",map);
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			
		return payList;
	}

	@Override
	public List<Pay> ListPayMemberAdmin(Map<String, Object> map) {
		List<Pay> adminpayList=null;
		
		try {
			adminpayList=dao.selectList("pay.listPayMemberAdmin", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
	return adminpayList;
	}

	@Override
	public List<Map<String, Object>> payYearList(String memberNum) {
		List<Map<String, Object>> payYearList=null;
		try {
			payYearList=dao.selectList("pay.payYearList",memberNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return payYearList;
	}


}
