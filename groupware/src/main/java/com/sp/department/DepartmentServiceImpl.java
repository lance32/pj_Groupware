package com.sp.department;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("dept.service")
public class DepartmentServiceImpl implements DepartmentService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Department> list() throws Exception {
		List<Department> list = dao.selectList("department.deptList");
		return list;
	}

	@Override
	public void insert(Department dept) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Department dept) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int deptNum) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
}
