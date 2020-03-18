package com.haohuimin.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.dao.LinkDao;
import com.haohuimin.cms.domain.Link;
import com.haohuimin.cms.service.LinkService;


@Service
public class LinkServiceImpl implements LinkService {

	
	@Autowired
	private LinkDao linkDao;

	@Override
	public PageInfo<Link> selects(Link link, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Link> list=linkDao.selects(link);
		return new PageInfo<Link>(list);
	}

	@Override
	public Link selectLinkID(String id) {
		// TODO Auto-generated method stub
		return linkDao.selectLinkID(id);
	}

	@Override
	public boolean update(Link link) {
		// TODO Auto-generated method stub
		return linkDao.update(link)>0;
	}

	@Override
	public boolean add(Link link) {
		// TODO Auto-generated method stub
		return linkDao.add(link)>0;
	}
}
