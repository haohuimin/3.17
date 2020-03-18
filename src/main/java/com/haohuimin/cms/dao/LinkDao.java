package com.haohuimin.cms.dao;

import java.util.List;

import com.haohuimin.cms.domain.Link;


public interface LinkDao {

	List<Link> selects(Link link);

	Link selectLinkID(String id);

	
	int update(Link link);

	int add(Link link);

}
