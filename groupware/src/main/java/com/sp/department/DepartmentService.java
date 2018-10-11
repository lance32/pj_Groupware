package com.sp.department;

import java.util.List;
import java.util.Map;

import com.sp.member.OrganizationChart;

public interface DepartmentService {
	public List<Department> list() throws Exception;
	public void insert(Department dept) throws Exception;
	public void update(Department dept) throws Exception;
	public void delete(int deptNum) throws Exception;
	public List<OrganizationChart> deptInfoById(int deptNum) throws Exception;
	public void update(Map<String, Object> map) throws Exception;
}
