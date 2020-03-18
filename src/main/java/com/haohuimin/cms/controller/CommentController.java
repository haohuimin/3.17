package com.haohuimin.cms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.domain.Comment;
import com.haohuimin.cms.service.CommentService;

@RequestMapping("comment")
@Controller
public class CommentController {

	
	@Autowired
	private CommentService commentService;
	/**
	 * 
	 * @Title: addComment 
	 * @Description: 新增评论
	 * @param m
	 * @param comment
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("addComment")
	public Object addComment(Model m,Comment comment) {
		commentService.addComment(comment);
		//文章评论
		PageInfo<Comment> page=commentService.findCommentList(1, 6, comment);
		m.addAttribute("comments", page);
		return true;
	}
	/**
	 * 
	 * @Title: commentList 
	 * @Description: 查询评论列表
	 * @param m
	 * @param id
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: Object
	 */
	@RequestMapping("commentList")
	public Object commentList(Model m,String id,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "10")Integer pageSize) {
		//文章评论
		Comment comment=new Comment();
		comment.setArticle_id(Integer.parseInt(id));
		PageInfo<Comment> page=commentService.findCommentList(pageNum, pageSize, comment);
		m.addAttribute("comments", page);
		return "/index/comment";
	}
	/**
	 * 
	 * @Title: findCommentNum 
	 * @Description: 文章评论个数
	 * @param id
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("findCommentNum")
	public Object findCommentNum(String id) {
		int num=commentService.findCommentNum(id);
		return num;
	}
	
	
	
}
