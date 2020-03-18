package com.haohuimin.cms.dao;

import java.util.List;

import org.springframework.data.elasticsearch.repository.ElasticsearchCrudRepository;

import com.haohuimin.cms.domain.Article;

//就是仓库接口，让他继承一个接口，这个接口就具备了CRUD的方法
public interface ArticleRepository extends ElasticsearchCrudRepository<Article,Integer>{

	List<Article> findByTitle(String key);
   
}
