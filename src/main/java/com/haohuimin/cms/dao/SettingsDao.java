package com.haohuimin.cms.dao;

import com.haohuimin.cms.domain.Settings;

public interface SettingsDao {

	Settings loginAdmin(Settings settings);

	void registerAdmin(Settings settings);

}
