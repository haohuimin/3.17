package com.haohuimin.cms.service;

import com.haohuimin.cms.domain.Settings;

public interface SettingsService {

	void registerAdmin(Settings settings);

	Settings loginAdmin(Settings settings);

}
