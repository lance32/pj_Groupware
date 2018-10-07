package com.sp.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("config.service")
public class ConfigServiceImpl implements ConfigService {	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Config> selectConfigByGroup(String groups) throws Exception {
		List<Config> list = null;
		
		try {
			list = dao.selectList("config.selectConfigByGroup", groups);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Config selectConfigByName(String name) throws Exception {
		Config config = null;
		
		try {
			config = dao.selectOne("config.selectConfigByName", name);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return config;
	}

	@Override
	public void insertConfig(Config config) throws Exception {
		try {
			dao.insertData("config.insertConfig", config);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateConfig(Config config) throws Exception {
		try {
			dao.updateData("config.updateConfig", config);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteConfig(String name) throws Exception {
		try {
			dao.deleteData("config.deleteConfig", name);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
