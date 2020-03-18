package com.haohuimin.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.dao.UserDao;
import com.haohuimin.cms.domain.User;
import com.haohuimin.cms.service.UserService;
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	@Override
	public PageInfo<User> getUserList(String username,Integer pageNum,Integer pageSize) {
		// TODO Auto-generated method stub
		PageHelper.startPage(pageNum, pageSize);
		List<User> userList = userDao.getUserList(username);
		return new PageInfo<User>(userList);
	}

	@Override
	public int updateLocated(String id, String locted) {
		// TODO Auto-generated method stub
		return userDao.updateLocated(id,locted);
	}

	@Override
	public User loginUser(User user) {
		// TODO Auto-generated method stub
		return userDao.loginUser(user);
	}

	@Override
	public Boolean registerUser(User user) {
		// TODO Auto-generated method stub
		return userDao.registerUser(user)>0;
	}

	@Override
	public Boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return userDao.updateUser(user)>0;
	}

	
}
