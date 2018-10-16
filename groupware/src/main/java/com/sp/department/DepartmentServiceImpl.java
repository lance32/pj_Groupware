package com.sp.department;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;
import com.sp.member.OrganizationChart;

@Service("dept.service")
public class DepartmentServiceImpl implements DepartmentService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Department> list() throws Exception {
		List<Department> list = null;
		try {
			list = dao.selectList("department.deptList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insert(Department dept) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Department dept) throws Exception {
		try {
			dao.updateData("department.deptInfo", dept);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void delete(int deptNum) throws Exception {
		try {
			dao.deleteData("department.deptDelete", deptNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrganizationChart> deptInfoById(int deptNum) throws Exception {
		List<OrganizationChart> list = null;
		try {
			list = dao.selectList("department.deptInfoById", deptNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void update(Map<String, Object> map) throws Exception {
		try {
			for (String key : map.keySet()) {
				System.out.println("key=" + key + ", value=" + map.get(key));
			}
			dao.updateData("department.deptInfo", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateIdx(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("department.idxUpdate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insert(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("department.insertData", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateRename(Department dept) throws Exception {
		try {
			dao.updateData("department.deptRename", dept);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
