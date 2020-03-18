package com.haohuimin.cms.service;


import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.domain.Article;

public interface ArticleService {

	PageInfo<Article> getArticleList(Article article, Integer pageNum, Integer pageSize);
	
	PageInfo<Article> getstatusList(Article article, Integer pageNum, Integer pageSize);

	Article selectArticle(String id);

	int updateStatus(String status, String id);

	void add(Article article);

	void addHits(String id);


}
