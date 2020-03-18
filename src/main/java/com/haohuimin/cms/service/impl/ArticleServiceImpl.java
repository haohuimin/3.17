package com.haohuimin.cms.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.dao.ArticleDao;
import com.haohuimin.cms.domain.Article;
import com.haohuimin.cms.service.ArticleService;
@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	private ArticleDao articleDao;
	

	@Override
	public PageInfo<Article> getArticleList(Article article, Integer pageNum, Integer pageSize) {
		// TODO Auto-generated method stub
		PageHelper.startPage(pageNum, pageSize);
		List<Article> list=articleDao.getArticleList(article);
		return new PageInfo<Article>(list);
	}
	@Override
	public PageInfo<Article> getstatusList(Article article, Integer pageNum, Integer pageSize) {
		// TODO Auto-generated method stub
		PageHelper.startPage(pageNum, pageSize);
		List<Article> list=articleDao.getstatusList(article);
		return new PageInfo<Article>(list);
	}

	@Override
	public Article selectArticle(String id) {
		// TODO Auto-generated method stub
		return articleDao.selectArticle(id);
	}

	@Override
	public int updateStatus(String status, String id) {
		// TODO Auto-generated method stub
		return articleDao.updateStatus(status,id);
	}

	@Override
	public void add(Article article) {
		// TODO Auto-generated method stub
		articleDao.add(article);
	}
	/**
	 * 增加点击量
	 */
	@Override
	public void addHits(String id) {
		 Article article = articleDao.selectArticle(id);
		//点击量过20为热门
		if(article.getHits()==19) {
			articleDao.updateHot(id);
		}
		article.setHits(article.getHits()+1);
		articleDao.updateHit(article);
	}

   
}
