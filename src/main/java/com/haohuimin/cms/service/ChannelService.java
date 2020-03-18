package com.haohuimin.cms.service;

import java.util.List;

import com.haohuimin.cms.domain.Category;
import com.haohuimin.cms.domain.Channel;


public interface ChannelService {

	List<Channel> channelList();

	List<Category> categoryList(String id);

	Channel getChannel(Integer channel_id);

	

}
