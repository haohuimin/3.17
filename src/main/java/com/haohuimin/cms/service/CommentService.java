package com.haohuimin.cms.service;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.domain.Comment;


public interface CommentService {

	PageInfo<Comment> findCommentList(Integer pageNum,Integer pageSize,Comment comment);

	void addComment(Comment comment);

	int findCommentNum(String id);
}
