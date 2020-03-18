package com.haohuimin.cms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.domain.Link;
import com.haohuimin.cms.service.LinkService;

@Controller
@RequestMapping("link")
public class LinkController {

	
	@Autowired
	private LinkService linkService;
	/**
	 * 
	 * @Title: selects 
	 * @Description: 查询友情链接列表，返回友情链接界面
	 * @param m
	 * @param link
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: Object
	 */
	@RequestMapping("selects")
	public Object selects(Model m,Link link,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "3")Integer pageSize) {
		
		PageInfo<Link> page=linkService.selects(link,pageNum,pageSize);
		m.addAttribute("link", page.getList());
		m.addAttribute("text", link.getText());
		m.addAttribute("page", page);
		return "admin/link";
	}
	/**
	 * 
	 * @Title: selectLinkID 
	 * @Description: 按id查询友情链接，返回友情链接修改界面
	 * @param id
	 * @return
	 * @return: Object
	 */
	@RequestMapping("selectLinkID")
	public Object selectLinkID(Model m,String id) {
		Link link=linkService.selectLinkID(id);
		m.addAttribute("link", link);
		return "admin/updateLink";
	}
	/**
	 * 
	 * @Title: update 
	 * @Description: 友情链接修改
	 * @param link
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("update")
	public Object update(Link link) {
		boolean flag=linkService.update(link);
		return flag;
	}
	/**
	 * 
	 * @Title: toAdd 
	 * @Description: 跳转界面至添加友情链接界面
	 * @return
	 * @return: Object
	 */
	@RequestMapping("toAdd")
	public Object toAdd() {
		
		return "admin/addLink";
	}
	/**
	 * 
	 * @Title: add 
	 * @Description: 友情链接新增
	 * @param link
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("add")
	public Object add(Link link) {
		boolean flag=linkService.add(link);
		return flag;
	}
}
