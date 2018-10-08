package com.sp.config;

import java.util.List;

public interface ConfigService {
	public List<Config> selectConfigByGroup(String groups) throws Exception;
	public Config selectConfigByName(String name) throws Exception;
	public void insertConfig(Config config) throws Exception;
	public void updateConfig(Config config) throws Exception;
	public void deleteConfig(String name) throws Exception;
}
