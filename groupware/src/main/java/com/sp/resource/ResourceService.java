package com.sp.resource;

import java.util.List;
import java.util.Map;

public interface ResourceService {
	public int insertResourceGroup(Resource dto);
	public int updateResourceGroup(Resource dto);
	public int deleteResourceGroup(int groupNum);
	
	public Resource readResourceGroup(int groupNum);
	public List<Resource> listResourceGroup();
	
	public int insertResourceList(Resource dto);
	public int updateResourceList(Resource dto);
	public int deleteResourceList(int resourceNum);
	public Resource readResourceList(int resourceNum);
	public List<Resource> listResourceList(int groupNum);
	public List<ResourceJSON> listResourceList();
	
	public int insertReserve(Resource dto);
	public int updateReserve(Resource dto);
	public int deleteReserve(Map<String, Object> map);
	public Resource readReserve(int reserveNum);
	public List<ResourceJSON> listReserve(Map<String, Object> map);
	
	public int insertAlarm(Resource dto);
}
