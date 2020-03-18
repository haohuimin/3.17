package com.haohuimin.cms.service;

import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.domain.User;

public interface UserService {

	PageInfo<User> getUserList(String username,Integer pageNum,Integer pageSize);

	int updateLocated(String id, String locted);

	User loginUser(User user);

	Boolean registerUser(User user);

	Boolean updateUser(User user);

	

}
