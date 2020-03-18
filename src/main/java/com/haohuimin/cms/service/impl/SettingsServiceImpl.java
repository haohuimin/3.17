package com.haohuimin.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.haohuimin.cms.dao.SettingsDao;
import com.haohuimin.cms.domain.Settings;
import com.haohuimin.cms.service.SettingsService;
@Service
public class SettingsServiceImpl implements SettingsService{

	
	@Autowired
	private SettingsDao settingsDao;
	
	@Override
	public void registerAdmin(Settings settings) {
		
		settingsDao.registerAdmin(settings);
	}

	@Override
	public Settings loginAdmin(Settings settings) {
		// TODO Auto-generated method stub
		return settingsDao.loginAdmin(settings);
	}

}
