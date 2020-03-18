package com.haohuimin.cms.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;

import com.haohuimin.cms.domain.Article;
import com.haohuimin.cms.domain.Category;
import com.haohuimin.cms.domain.Channel;
import com.haohuimin.cms.domain.User;
import com.haohuimin.cms.service.ArticleService;
import com.haohuimin.cms.service.ChannelService;


@Controller
@RequestMapping("article")
public class ArticleController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private ChannelService channelService;
	/*
	 * @Autowired private ArticleRepository articleRepository;
	 */
    @Autowired
    private KafkaTemplate<String,String> kafkaTemplate;
	
	/**
	 * 
	 * @Title: selects 
	 * @Description: 文章管理，查询文章列表，实现分页
	 * @param m
	 * @param article
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: Object
	 */
	@RequestMapping("selects")
	public Object selects(Model m, Article article, @RequestParam(defaultValue = "1") Integer pageNum,
			@RequestParam(defaultValue = "3") Integer pageSize) {

		PageInfo<Article> page = articleService.getstatusList(article, pageNum,
				pageSize);

		m.addAttribute("page", page);
		m.addAttribute("title", article.getTitle());
		m.addAttribute("status", article.getStatus());
		m.addAttribute("list", page.getList());

		return "admin/article";
	}

	/**
	 * 
	 * @Title: selectArticle 
	 * @Description: 根据id查看文章详情
	 * @param id
	 * @return
	 * @return: Object
	 */
	@RequestMapping("selectArticle")
	@ResponseBody
	public Object selectArticle(String id) {
		Article article = articleService.selectArticle(id);
		return article;
	}

	/**
	 * 
	 * @Title: updateStatus 
	 * @Description: 修改文章状态
	 * @param status
	 * @param id
	 * @return
	 * @return: Object
	 */
	//审核文章的时候，不让他同步es索引库，直接发送到kafka一条消息，通知消费者去同步es
	@RequestMapping("updateStatus")
	@ResponseBody
	public Object updateStatus(String status, String id) {
        //直接向kafka发送一条消息，通知es索引库（解耦合）
		//ssm中整合kafka的生产者
		//1.可以注入kafkaTemplate
		//2.调用发送消息的方法
		kafkaTemplate.send("cms_article","shenhe"+"="+id);
		//==================================================
		//审核文章的同时添加es索引库
		//根据id来从mysql中查询文章数据，把这个这个文章的数据保存到es索引库
//		Article selectArticle = articleService.selectArticle(id);
//		articleRepository.save(selectArticle);
//		System.err.println("同步es索引库成功");
		int i = articleService.updateStatus(status, id);
		return i >= 1 ? true : false;
	}

	/**
	 * 
	 * @Title: selectArticleList 
	 * @Description: 个人中心的查看文章
	 * @param m
	 * @param article
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: Object
	 */
	@RequestMapping("selectArticleList")
	public Object selectArticleList(Model m, Article article, @RequestParam(defaultValue = "1") Integer pageNum,
			@RequestParam(defaultValue = "3") Integer pageSize,HttpSession session) {
		User user = (User) session.getAttribute("user");
		if(user!=null) {
			article.setUser_id(user.getId());
		}
		PageInfo<Article> page = articleService.getstatusList(article, pageNum,
				pageSize);

		m.addAttribute("page", page);
		m.addAttribute("title", article.getTitle());
		m.addAttribute("status", article.getStatus());
		m.addAttribute("list", page.getList());
		return "my/article";
	}

	/**
	 * 
	 * @Title: toAdd 
	 * @Description: 去发布文章页面
	 * @return
	 * @return: Object
	 */
	@RequestMapping("toAdd")
	public Object toAdd() {
		return "my/release";
	}
	/**
	 * 
	 * @Title: channelList 
	 * @Description: 查询栏目列表
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("channelList")
	public Object channelList() {
		List<Channel> list=channelService.channelList();
		return list;
	}
	/**
	 * 
	 * @Title: categoryList 
	 * @Description: 查询分类列表
	 * @param id
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("categoryList")
	public Object categoryList(String id) {
		List<Category> list=channelService.categoryList(id);
		return list;
	}
	/**
	 * 
	 * @Title: add 
	 * @Description: 个人中心文章发布
	 * @param article
	 * @param file
	 * @param session
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("add")
	public Object add(Article article,String content,@RequestParam("file")MultipartFile file,HttpSession session) {
		User user = (User)(session.getAttribute("user"));
		if(null!=user) {
			article.setUser_id(user.getId());
		}
		article.setContent(content);
		try {
			if(file.getSize()>0) {
				//上传图片的路劲
				String path="e:/pic/";
				//获得上传图片的名称
				String originalFilename = file.getOriginalFilename();
				//获得后缀
				String endName = originalFilename.substring(originalFilename.lastIndexOf("."));
				//获得新的文件名称
				String fileName = UUID.randomUUID().toString()+endName;
				//创建上传的文件
				File file2 = new File(path+fileName);
				
				file.transferTo(file2);
				article.setPicture(fileName);
				
			}
			articleService.add(article);
			return true;
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
}
