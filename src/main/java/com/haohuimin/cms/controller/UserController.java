package com.haohuimin.cms.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.domain.Favorite;
import com.haohuimin.cms.domain.User;
import com.haohuimin.cms.service.FavoriteService;
import com.haohuimin.cms.service.UserService;

@RequestMapping("user")
@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private FavoriteService favoriteService;

	/**
	 * 
	 * @Title: selects 
	 * @Description: 查看用户列表
	 * @param m
	 * @param username
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: Object
	 */
	@RequestMapping("selects")
	public Object selects(Model m, @RequestParam(defaultValue = "") String username,
			@RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "3") Integer pageSize) {
		PageInfo<User> info = userService.getUserList(username, pageNum, pageSize);
		//String page = PageUtil.page(pageNum, info.getPages(), "/user/selects?username=" + username, pageSize);
		m.addAttribute("page", info);
		m.addAttribute("username", username);
		m.addAttribute("list", info.getList());
		return "admin/user";
	}
	/**
	 * 
	 * @Title: updateLocated 
	 * @Description: 修改用户状态
	 * @param id
	 * @param locted
	 * @return
	 * @return: Object
	 */
	@RequestMapping("updateLocated")
	@ResponseBody
	public Object updateLocated(String id,String locted) {
		int i=userService.updateLocated(id,locted);
		return i>=1?true:false;
	}
	
	/**
	 * 
	 * @Title: login 
	 * @Description: 进入用户登陆界面
	 * @return
	 * @return: Object
	 */
	@RequestMapping("/login")
	public Object login(Model m,String id) {
		m.addAttribute("id", id);
		return "public/login";
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
		session.removeAttribute("user");
		return "redirect:/index";
	}
	/**
	 * 
	 * @Title: register 
	 * @Description: 进入用户注册界面
	 * @return
	 * @return: Object
	 */
	@RequestMapping("/register")
	public Object register() {
		return "public/register";
	}

	/**
	 * 
	 * @Title: loginUser 
	 * @Description: 用户登录
	 * @param user
	 * @param session
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("/loginUser")
	public Object loginUser(User user,HttpSession session) {
		
		String password=user.getPassword();
		user=userService.loginUser(user);
		//把输入的密码  加密  过后 和数据库中的已有的加密的密码比对
		String md5Hex = DigestUtils.md5Hex(password);
		if(user==null) {
			return "usernameNo";
		}else if(user.getLocked()==1) {
			return "locked";
		}else if(!user.getPassword().equals(md5Hex)) {
			return "passwordNot";
		}
		session.setAttribute("user", user);
		return "true";
		
	}
	
	/**
	 * 
	 * @Title: registerUser 
	 * @Description: 注册用户
	 * @param user
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("/registerUser")
	public Object registerUser(User user) {
		User testUser =new User();
		testUser.setUsername(user.getUsername());
		testUser=userService.loginUser(testUser);
		if(null!=testUser) {
			return "existUser";
		}
		//注册之前对密码进行md5加密  使用apach工具类进行加密
		String md5Hex = DigestUtils.md5Hex(user.getPassword());
		user.setPassword(md5Hex);
		userService.registerUser(user);
		return "true";
	}
	/**
	 * 
	 * @Title: homePage 
	 * @Description: 跳转至个人主页，可以进行修改资料
	 * @return
	 * @return: Object
	 */
	@RequestMapping("homePage")
	public Object homePage() {
		return "/public/homePage";
	}
	/**
	 * 
	 * @Title: updateUser 
	 * @Description: 修改用户资料
	 * @param session
	 * @param user
	 * @param myFile
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("updateUser")
	public Object updateUser(HttpSession session,User user,@RequestParam(required=false)MultipartFile myFile) {
		
		
		if(null!=myFile && !myFile.equals("")) {
			//获得文件名
			String fileName = myFile.getOriginalFilename();
				//获得文件后缀名
				String endName = fileName.substring(fileName.lastIndexOf("."));
				//随机生成新的文件名
				String newName = UUID.randomUUID().toString();
				//上传到图片库
				String path="e:/pic/";
				File file=new File(path+newName+endName);
				try {
					myFile.transferTo(file);
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				user.setPhoto(newName+endName);
			
			
		}
		Boolean flag=userService.updateUser(user);
		if(flag) {
			User user2 = userService.loginUser(user);
			session.setAttribute("user", user2);
		}
		return flag;
	}
	
	/**
	 * 
	 * @Title: findFavorite 
	 * @Description: 进入我的收藏夹，查询收藏夹列表
	 * @param m
	 * @param user_id
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: Object
	 */
	@RequestMapping("findFavorite")
	public Object findFavorite(Model m,String user_id,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "3")Integer pageSize) {
		Favorite favorite=new Favorite();
		favorite.setUser_id(Integer.parseInt(user_id));
		PageInfo<Favorite> page=favoriteService.findFavorite(favorite,pageNum,pageSize);
		m.addAttribute("page", page);
		return "/my/favorite";
	}
	/**
	 * 
	 * @Title: deleteFavorite 
	 * @Description: 删除收藏夹
	 * @param id
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("deleteFavorite")
	public Object deleteFavorite(String id) {
		boolean flag=favoriteService.deleteFavorite(id);
		return flag;
	}
	/**
	 * 
	 * @Title: addFavorite 
	 * @Description: 添加收藏夹
	 * @param favorite
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("addFavorite")
	public Object addFavorite(Favorite favorite) {
		favoriteService.add(favorite);
		return true;
	}
	/**
	 * 
	 * @Title: toAddFavorite 
	 * @Description: 前往添加收藏夹界面
	 * @return
	 * @return: Object
	 */
	@RequestMapping("toAddFavorite")
	public Object toAddFavorite() {
		return "/my/addFavorite";
	}
}
