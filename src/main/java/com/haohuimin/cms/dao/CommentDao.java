package com.haohuimin.cms.dao;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.haohuimin.cms.domain.Comment;


public interface CommentDao {

	List<Comment> findCommentList(Comment comment);

	void addComment(Comment comment);

	int findCommentNum(@RequestParam("id")String id);
}
