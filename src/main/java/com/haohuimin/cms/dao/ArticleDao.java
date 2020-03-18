package com.haohuimin.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.haohuimin.cms.domain.Article;


public interface ArticleDao {

	List<Article> getArticleList(Article article);


	List<Article> getstatusList(Article article);

	Article selectArticle(String id);
	@Update("update cms_article set status=#{status} where id=#{id}")
	int updateStatus(@Param("status")String status, @Param("id")String id);

	void add(Article article);

	@Update("update cms_article set hot=1 where id=#{id}")
	void updateHot(String id);

	@Update("update cms_article set hits=#{hits} where id=#{id}")
	void updateHit(Article article);
 
	
	
}
