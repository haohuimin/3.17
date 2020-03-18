package com.haohuimin.cms.kafka;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.listener.MessageListener;

import com.alibaba.fastjson.JSON;
import com.haohuimin.cms.dao.ArticleDao;

import com.haohuimin.cms.domain.Article;
//监听爬虫项目发来的文章的json串
public class ArticleListener implements MessageListener<String, String>{
    @Autowired
    ArticleDao articleDao;

	/*
	 * @Autowired ArticleRepository articleRepository;
	 */
	@Override
	public void onMessage(ConsumerRecord<String, String> data) {
		
		
		System.err.println("收到了消息");
		String jsonString = data.value();//shenhe=103
		if (jsonString.startsWith("shenhe")) {
			//执行审核的逻辑
			String[] split = jsonString.split("=");
			/* int id = Integer.parseInt(split[1]); */
			//查看这个id取数据找对应文章
			Article selectArticle = articleDao.selectArticle(split[1]);
			//得到文章之后就开始往es索引库中保存
			/* articleRepository.save(selectArticle); */
		    System.err.println("同步es索引库成功");
		}else if (jsonString.startsWith("xuefeng")) {
			//要做削峰的逻辑
			String[] split = jsonString.split("=");
			//根据id查询文章
			Article article = articleDao.selectArticle(split[1]);
			//获取原有的点击量
			Integer hits = article.getHits();
			//点击量+1
			article.setHits(hits+1);
			//更新到数据库
			articleDao.updateHit(article);
			System.err.println("用kafka的方式增加点击量");
		}else {
			//由于jsonstring是一个json类型的字符串，所以我们要吧这个json的字符串转换成文章对象，保存到mysql
			Article article = JSON.parseObject(jsonString, Article.class);
			System.out.println(article.getContent());
		    //注入articledao然后就可以直接调用保存方法
			articleDao.add(article);
			System.err.println("保存文章对象到mysql数据库");
		}
		
	
	}

}
