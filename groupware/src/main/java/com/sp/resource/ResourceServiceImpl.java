package com.sp.resource;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("resource.resourceService")
public class ResourceServiceImpl implements ResourceService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertResourceGroup(Resource dto) {
		int result = 0;
		try {
			result = dao.insertData("res1.insertResourceGroup", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateResourceGroup(Resource dto) {
		int result = 0;
		try {
			result = dao.updateData("res1.updateResourceGroup", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteResourceGroup(int groupNum) {
		int result = 0;
		try {
			result = dao.deleteData("res1.deleteResourceGroup", groupNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Resource readResourceGroup(int groupNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Resource> listResourceGroup() {
		List<Resource> list = null;
		try {
			list = dao.selectList("res1.listResourceGroup");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int insertResourceList(Resource dto) {
		int result = 0;
		try {
			result = dao.insertData("res1.insertResourceList", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateResourceList(Resource dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteResourceList(int resourceNum) {
		int result = 0;
		try {
			result = dao.deleteData("res1.deleteResourceList", resourceNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Resource readResourceList(int resourceNum) {
		Resource dto = null;
		try {
			dto = dao.selectOne("res1.readResourceList", resourceNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public List<Resource> listResourceList(int groupNum) {
		List<Resource> list = null;
		try {
			list = dao.selectList("res1.listResourceList2", groupNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int resCount() {
		int result = 0;
		try {
			result = dao.selectOne("res1.resCount");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Resource> listResourceList3(Map<String, Object> map) {
		List<Resource> list = null;
		try {
			list = dao.selectList("res1.listResourceList3", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<ResourceJSON> listResourceList() {
		List<ResourceJSON> list=null;
		try {
			list=dao.selectList("res1.listResourceList");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int insertReserve(Resource dto) {
		int result = 0;
		try {
			result = dao.insertData("res1.insertReserve", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateReserve(Resource dto) {
		int result = 0;
		try {
			result = dao.updateData("res1.updateReserve", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteReserve(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.deleteData("res1.deleteReserve", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<ResourceJSON> listReserve(Map<String, Object> map) {
		List<ResourceJSON> list=null;
		try {
			list=dao.selectList("res1.listReserve", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public List<Resource> listReserve2(Map<String, Object> map) {
		List<Resource> list=null;
		try {
			list=dao.selectList("res1.listReserve2", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("res1.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	

}
