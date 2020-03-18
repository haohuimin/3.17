package com.haohuimin.cms.controller;

import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.dao.ArticleDao;
import com.haohuimin.cms.domain.Article;
import com.haohuimin.cms.domain.Channel;
import com.haohuimin.cms.service.ArticleService;
import com.haohuimin.cms.service.ChannelService;
import com.haohuimin.cms.service.CommentService;

@Controller
@RequestMapping("/index")
public class IndexController {
	
	@Autowired
	private RedisTemplate redisTemplate;

	@Autowired
	private ArticleService articleService;
	@Autowired
	private ChannelService channelService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private KafkaTemplate kafkaTemplate;
	
	/**
	 * 
	 * @Title: select 
	 * @Description: 今日文章详情页，内部包含：文章内容，评论，最新文章
	 * @param m
	 * @param id
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: Object
	 */
	
	 
	@Autowired
	private ThreadPoolTaskExecutor executor;
	@SuppressWarnings("unchecked")
	@RequestMapping("select")
	public Object select(HttpServletRequest request,Model m,String id,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "3")Integer pageSize) {
		
		//点击量增加
	articleService.addHits(id);
		//根据文章id查文章详情
		Article article=articleService.selectArticle(id);
		m.addAttribute("article", article);
		
		Article relevant=new Article();
		relevant.setChannel_id(article.getChannel_id());
		
		//=================================kafka方式增加点击量================
		/**
		 * 请你利用Kafka进行流量削峰。
		 * 当用户浏览文章时，往Kafka发送文章ID，
		 * 在消费端获取文章ID，再执行数据库加1操作。
		 */
		
		kafkaTemplate.send("cms_article","xuefeng="+article.getId());
		
		
		
		
		 /**
		   * 
		      当用户浏览文章时，将“Hits_${文章ID}_${用户IP地址}”为key，
		      查询Redis里有没有该key，如果有key，则不做任何操作。
		      如果没有，则使用Spring线程池异步执行数据库加1操作，
		      并往Redis保存key为Hits_${文章ID}_${用户IP地址}，value为空值的记录，而且有效时长为5分钟
		   */
	
		 //=================redis增加点击量 //1. 当用户浏览文章时，将“Hits_${文章ID}_${用户IP地址}”为key，
		 String ip = request.getRemoteAddr(); String
		 key="Hits_"+relevant.getId()+"_"+ip; System.err.println(key); //2.
		 // 查询Redis里有没有该key，如果有key，则不做任何操作。
		 Boolean rediskey = redisTemplate.hasKey(key);
		  if (!rediskey) { 
			  //rediskey为false说明没有这个key //3.如果没有，则使用Spring线程池异步执行数据库加1操作
		  //3.1在说ssm中整合线程池操作 //spring.xml中加上一个约束头，加上配置 //3.2直接注入spring线程池
		  executor.execute(new Runnable() {
		  
		  @Override public void run() { //数据库加1操作 //获取原来的点击量 Integer hits =
		  article.getHits(); //让原来的点击量加1 article.setHits(hits+1); //重新保存到数据库
		  articleDao.updateHit(article); System.err.println("点击量已经+1了");
		  redisTemplate.opsForValue().set(key, "", 5,TimeUnit.MINUTES); } });
		  }
		 
	
		
		//最新文章
		//relevant.setCategory_id(article.getCategory_id());
	    PageInfo<Article> pageInfo=articleService.getArticleList(relevant,1,3);
		m.addAttribute("relevantArticle", pageInfo.getList());
		
		//该文章的栏目
		Channel channel=channelService.getChannel(article.getChannel_id());
		m.addAttribute("articleChannel", channel);
		return "index/article";
	}
}
