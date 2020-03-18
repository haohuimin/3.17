package com.haohuimin.cms.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.haohuimin.cms.dao.ArticleDao;
import com.haohuimin.cms.dao.ArticleRepository;
import com.haohuimin.cms.domain.Article;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-beans.xml")
public class TestImportData2Es {
   //注入mapper
	@Autowired
    private ArticleDao articleDao;
	
	 @Autowired
	 private ArticleRepository articleRepository;
	 
	//一.需求：保证数据时时更新，-->保证mysql中的数据和es索引库中的数据同步（一致性）
	//二分析需求：
	//1.当对文章进行发布(增加)，修改，删除，此时对mysql中的数据修改
	//2.在发布文章修改文章删除文章的同时要添加es索引库，修改es索引库，删除es索引库
	//三.进行编码
	//1.编码的思路：
	//只需要找到文章的发布方法，修改方法，删除方法，然后再这些方法内加上一个操作添加es索引库(添加方法里)，修改es索引库（修改方法里，）删除es索引库（删除方法）
	
	//问题：发布文章的时候添加es索引库？还是审核通过后添加es索引库
	//不审核通过的文章不能在首页显示，意味着，搜素也搜不到
	//必须保证审核通过的文章，才能添加es索引库，因此我们可以找到审核的方法，在审核的方法添加es索引库
	@Test
   public void testImport() {
	   //1.必须从mysql中查询出来所有数据
	   List<Article> articleList = articleDao.getArticleList(null);
	   for (Article article : articleList) {
	     System.out.println(article);
	}
		articleRepository.saveAll(articleList); 
	   //2.把从mysql中查询出来的数据，存入es索引库
	   
   }
}
