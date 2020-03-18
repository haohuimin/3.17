package com.haohuimin.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.haohuimin.cms.domain.Category;
import com.haohuimin.cms.domain.Channel;

public interface ChannelDao {

	List<Channel> channelList();

	List<Category> selectCategory(@Param("id")String id);

	Channel getChannel(Integer channel_id);

}
