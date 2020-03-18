package com.haohuimin.cms.service;

import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.domain.Link;

public interface LinkService {

	PageInfo<Link> selects(Link link, Integer pageNum, Integer pageSize);

	Link selectLinkID(String id);

	boolean update(Link link);

	boolean add(Link link);
}
