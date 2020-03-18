package com.haohuimin.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.dao.CommentDao;
import com.haohuimin.cms.domain.Comment;
import com.haohuimin.cms.service.CommentService;
@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;

	@Override
	public PageInfo<Comment> findCommentList(Integer pageNum,Integer pageSize,Comment comment) {
		PageHelper.startPage(pageNum, pageSize);
		List<Comment> list=commentDao.findCommentList(comment);
		// TODO Auto-generated method stub
		return new PageInfo<Comment>(list);
	}

	@Override
	public void addComment(Comment comment) {
		// TODO Auto-generated method stub
		commentDao.addComment(comment);
	}

	@Override
	public int findCommentNum(String id) {
		// TODO Auto-generated method stub
		return commentDao.findCommentNum(id);
	}
}
