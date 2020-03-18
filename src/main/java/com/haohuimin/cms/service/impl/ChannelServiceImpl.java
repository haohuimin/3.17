package com.haohuimin.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.haohuimin.cms.dao.ChannelDao;
import com.haohuimin.cms.domain.Category;
import com.haohuimin.cms.domain.Channel;
import com.haohuimin.cms.service.ChannelService;
@Service
public class ChannelServiceImpl implements ChannelService {

	@Autowired
	private ChannelDao channelDao;

	@Override
	public List<Channel> channelList() {
		// TODO Auto-generated method stub
		return channelDao.channelList();
	}

	@Override
	public List<Category> categoryList(String id) {
		// TODO Auto-generated method stub
		return channelDao.selectCategory(id);
	}

	@Override
	public Channel getChannel(Integer channel_id) {
		// TODO Auto-generated method stub
		return channelDao.getChannel(channel_id);
	}
	
}
