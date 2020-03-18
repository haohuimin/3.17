<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Sidebar -->
<ul style="background-color: white;" class="sidebar navbar-nav"></ul>
<ul  style="text-align:center;list-style-type:none;background-color: white;" class="sidebar navbar-nav" >
			<li style="display:inline;list-style-type:none;margin-top: 20px;margin-bottom: 10px;" class="nav-item">
				<a  href="my">
					<img src="//s3.pstatp.com/toutiao/static/img/logo.271e845.png"  alt="今日头条" style="width: 108px; height: 27px;">
				</a>	
			</li>
			
			
			<li style="margin-top: 3px"><a class="my-btn btn-outline-danger" style="text-decoration:none;"  href="javascript:void(0)" data="article/selectArticleList">
					<span>查看文章</span>
			</a></li>
		
			<li style="margin-top: 3px"><a class="my-btn btn-outline-danger" style="text-decoration:none;"  href="javascript:void(0)" data="article/toAdd">
					 <span>发布文章</span>
			</a></li>
			<li style="margin-top: 3px"><a class="my-btn btn-outline-danger" style="text-decoration:none;"  href="javascript:void(0)" data="user/findFavorite?user_id=${user.id}">
					 <span>我的收藏夹</span>
			</a></li>
			<li style="margin-top: 3px"><a class="my-btn btn-outline-danger" style="text-decoration:none;" href="javascript:void(0)" data="待开发">
					 <span>资源管理</span>
			</a></li>
			<li style="margin-top: 3px"><a class="my-btn btn-outline-danger" style="text-decoration:none;" href="javascript:void(0)" data="待开发">
					 <span>其他管理</span>
			</a></li>
			<li style="margin-top: 3px"><a class="my-btn btn-outline-danger" style="text-decoration:none;"  href="javascript:void(0)" data="article/toAdd">
					 <span>发布图片</span>
			</a></li>
			
</ul>

