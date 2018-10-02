package com.sp.approval;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("approval.approvalService")
public class ApprovalServiceImpl implements ApprovalService{
	
	@Autowired
	private CommonDAO dao;

	@Override
	public int insertApproval(Approval dto) {
		int result=0;
		try {
			result=dao.insertData("approval.insertApproval", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Approval> listApproval(Map<String, Object> map) {
		List<Approval> list=null;
		
		try {
			list=dao.selectList("approval.approval_list", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}
