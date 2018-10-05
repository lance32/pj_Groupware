package com.sp.department;

import java.util.List;

public interface DepartmentService {
	public List<Department> list() throws Exception;
	public void insert(Department dept) throws Exception;
	public void update(Department dept) throws Exception;
	public void delete(int deptNum) throws Exception;
}
