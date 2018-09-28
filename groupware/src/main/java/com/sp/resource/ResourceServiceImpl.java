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
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateResourceGroup(Resource dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteResourceGroup(int groupNum) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Resource readResourceGroup(int groupNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Resource> listResourceGroup() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertResourceList(Resource dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateResourceList(Resource dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteResourceList(int resourceNum) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Resource readResourceList(int resourceNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Resource> listResourceList(int groupNum) {
		// TODO Auto-generated method stub
		return null;
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
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateReserve(Resource dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteReserve(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Resource readReserve(int reserveNum) {
		// TODO Auto-generated method stub
		return null;
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
	public int insertAlarm(Resource dto) {
		// TODO Auto-generated method stub
		return 0;
	}

}
