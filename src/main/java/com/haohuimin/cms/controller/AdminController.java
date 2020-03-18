package com.haohuimin.cms.controller;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.dao.ArticleRepository;
import com.haohuimin.cms.domain.Article;
import com.haohuimin.cms.domain.Category;
import com.haohuimin.cms.domain.Channel;
import com.haohuimin.cms.domain.Link;
import com.haohuimin.cms.domain.Settings;
import com.haohuimin.cms.domain.Slide;
import com.haohuimin.cms.service.ArticleService;
import com.haohuimin.cms.service.ChannelService;
import com.haohuimin.cms.service.LinkService;
import com.haohuimin.cms.service.SettingsService;
import com.haohuimin.cms.service.SlideService;
import com.haohuimin.cms.service.UserService;
import com.haohuimin.cms.util.HLUtils;

@Controller
public class AdminController {
    @Autowired
    private  RedisTemplate redisTemplate;
	
	@Autowired
	private ChannelService channelService;
	
	@Autowired
	private UserService userService;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private SlideService slideService;
	@Autowired
	private SettingsService settingsService;
	@Autowired
	private LinkService linkService;
	@SuppressWarnings("unused")
	@Autowired
    private ArticleRepository articleRepository;
	@Autowired
	private ElasticsearchTemplate elasticsearchTemplate;
    
	/**
	 * 
	    * @Title: search
	    * @Description: TODO 搜索的方法
	    * @param @return    参数
	    * @return String    返回类型
	    * @throws
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/search")
	public String search(String key,Model model,@RequestParam(defaultValue = "1")int pageNum,@RequestParam(defaultValue = "5")int pageSize) {
		//这里搜索是从es索引库中搜索，不是mysql中搜索
		//ssm中整合es
		//启动es服务，导入es数据
		//要想能在前台利用es搜索到文章数据，必须把mysql中的数据导入es的索引库
		
//		List<Article> list=articleRepository.findByTitle(key);
//		for (Article article : list) {
//			System.err.println(article);
//		}
		PageInfo<Article> pageInfo = (PageInfo<Article>) HLUtils.findByHighLight(elasticsearchTemplate, Article.class, pageNum,pageSize, new String[] {"title"}, "id", key);
		model.addAttribute("articles",pageInfo);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("key",key);
		return "index/index";
	}
	
	/**
	 * 
	 * @Title: admin
	 * @Description: 进入后台管理
	 * @return
	 * @return: Object
	 */
	@RequestMapping("/admin")
	public Object admin() {
		return "admin/index";
	}
	/**
	 * 
	 * @Title: my
	 * @Description: 进入个人中心
	 * @return
	 * @return: Object
	 */
	@RequestMapping("/my")
	public Object my() {
		return "my/index";
	}
	/**
	 * 
	 * 
	 * @Title: index
	 * @Description: 进入今日头条首页
	 * @return
	 * @return: Object
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/index")
	public Object index(Model m,Article article,@RequestParam(defaultValue = "6")Integer pageSize,@RequestParam(defaultValue = "1")Integer pageNum) {
		//查询所有栏目
		//1.先从redis中查询栏目
		List<Channel> newsChannels=redisTemplate.opsForList().range("new_channel",0,-1);
		//2.从redis查询出来判断这个数据是否为空
		if (newsChannels==null||newsChannels.size()==0) {
			//从mysql中查询数据
			System.err.println("从mysql查询了最新栏目");
			List<Channel> list=channelService.channelList();
			//3.如果为空，从mysql查询数据，保存到redis并返回前台
			System.err.println("最新栏目保存到了redis");
			redisTemplate.opsForList().leftPushAll("new_channel",list.toArray());
			m.addAttribute("channelList", list);
		}else {

			//4.如果非空，直接返回redis查询的最新数据
			
			System.err.println("从redis查询了最新栏目");
			m.addAttribute("channelList", newsChannels);
			
		}
		
		
		//最新文章
	    //如何从redis中查最新文章
		//=======第一次访问=========
		//1.无论redis中有没有最新文章的数据先从redis中查询最新数据
		List<Article> newscArticles=redisTemplate.opsForList().range("new_articles",0,2);
		//2.从redis中查询出来的数据，判断这个数据是否为空
		if (newscArticles==null||newscArticles.size()==0) {
			//3.如果为空，-->mysql中查询，并且存入redis，返回给前台
			//从mysql中获取数据
			System.err.println("从mysql查询了最新文章");
			PageInfo<Article> newArticle=articleService.getArticleList(article, pageNum, 3);
			System.err.println("最新文章保存到了redis");
			redisTemplate.opsForList().leftPushAll("new_articles",newArticle.getList().toArray());
			//让redis的最新文章5分钟过期
			redisTemplate.expire("new_articles", 5, TimeUnit.MINUTES);
			m.addAttribute("newArticle", newArticle.getList());
		}else {
			//======第二次访问========
			//4.如果非空-->意味着redis中已经存了最新文章，直接返回redis中的最新数据就ok
			System.err.println("从redis查询了最新文章");
			m.addAttribute("newArticle", newscArticles);
		}
		//判断是否有选择栏目  非空查询栏目下文章   空默认为热门
		if(article.getChannel_id()!=null) {
			//获取栏目下的所有分类
			List<Category> cates=channelService.categoryList(article.getChannel_id().toString());
			m.addAttribute("cates", cates);
			//查询文章
			PageInfo<Article> pageInfo=articleService.getArticleList(article,pageNum,4);
			m.addAttribute("articles", pageInfo);
		}else {
			//查询广告表，制作轮播图
			List<Slide> slides=slideService.slideList();
			m.addAttribute("slides", slides);
			//查询最热文章
			article.setHot(1);
			PageInfo<Article> pageInfo=articleService.getArticleList(article, pageNum, 3);
			m.addAttribute("hots", pageInfo);
		}
		//查询热门推荐
		//用redis来优化热点文章
		//第一次访问
		//1.从redis查询数据返回到页面
		List<Article> newsHot= redisTemplate.opsForList().range("new_hot", 0,5);
		//2.如果为null，从mysql查询数据，保存到redis，并返回页面
		if (newsHot==null||newsHot.size()==0) {
			article.setHot(1);
			System.err.println("从mysql查询热点文章");
			PageInfo<Article> pageInfo1=articleService.getArticleList(article, 1, 3);
			redisTemplate.opsForList().leftPushAll("new_hot", pageInfo1.getList().toArray());
			redisTemplate.expire("new_hot", 5, TimeUnit.MINUTES);
			m.addAttribute("hotsTen", pageInfo1.getList());
			System.err.println("热点文章保存到了mysql");
			
		}else {
			
			m.addAttribute("hotsTen", newsHot);
			System.err.println("从redis查询热点文章");
		}
		//3.如果非空，直接保存redis数据，返回页面
		//第二次访问
		m.addAttribute("article", article);
	
		//
		
		//查询友情链接,显示最新的10条链接
		Link link=new Link();
		PageInfo<Link> links=linkService.selects(link, 1, 10);
		m.addAttribute("links", links);
		return "index/index";
	}
	/**
	 * 
	 * @Title: login 
	 * @Description: 进入管理员登陆界面
	 * @param m
	 * @return
	 * @return: Object
	 */
	@RequestMapping("/login")
	public Object login() {
		return "admin/login";
	}
	/**
	 * 
	 * @Title: register 
	 * @Description: 进入管理员注册界面
	 * @return
	 * @return: Object
	 */
	@RequestMapping("/register")
	public Object register() {
		return "admin/register";
	}
	/**
	 * 
	 * @Title: loginAdmin
	 * @Description: 管理员登录
	 * @param user
	 * @param session
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("/loginAdmin")
	public Object loginAdmin(Settings settings,HttpSession session) {

		String password=settings.getAdmin_password();
		settings=settingsService.loginAdmin(settings);
		//把输入的密码  加密  过后 和数据库中的已有的加密的密码比对
		String md5Hex = DigestUtils.md5Hex(password);
		if(settings==null) {
			return "usernameNo";
		}else if(!settings.getAdmin_password().equals(md5Hex)) {
			return "passwordNot";
		}
		session.setAttribute("adminUser", settings);
		return "true";
	}
	
	/**
	 * 
	 * @Title: registerAdmin 
	 * @Description: 管理员注册
	 * @param user
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("/registerAdmin")
	public Object registerAdmin(Settings settings) {
		Settings Testsettings=new Settings();
		Testsettings.setAdmin_username(settings.getAdmin_username());
		Testsettings=settingsService.loginAdmin(Testsettings);
		if(null!=Testsettings) {
			return "existUser";
		}
		//注册之前对密码进行md5加密  使用apach工具类进行加密
		String md5Hex = DigestUtils.md5Hex(settings.getAdmin_password());
		settings.setAdmin_password(md5Hex);
		settingsService.registerAdmin(settings);
		return "true";
	}
	/**
	 * 
	 * @Title: logout
	 * @Description: 注销
	 * @return
	 * @return: Object
	 */
	@RequestMapping("/logout")
	public Object logout(HttpSession session) {
		session.removeAttribute("adminUser");
		return "admin/index";
	}
	
}
