package com.sp.pay;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service(value="pay.payService")
public class PayServiceImpl implements PayService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		
		try {
			dao.selectOne("pay.dataCount",map);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return 1;
	}

	@Override
	public List<Pay> ListPayMember(Map<String, Object> map) {
		List<Pay> payList=null;
		
			try {
				dao.selectList("pay.listPayMember",map);
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			
		return payList;
	}

}
