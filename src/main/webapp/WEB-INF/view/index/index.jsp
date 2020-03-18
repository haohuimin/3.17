<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 引入bootstrap样式 -->
<link rel="stylesheet" type="text/css"
	href="/resource/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/resource/css/sb-admin.css" />
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){

})
</script>
<style type="text/css">
.my-btn{
  display: inline-block;
  width:110px;
  font-weight: 400;
  color: #212529;
  text-align: center;
  vertical-align: middle;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  background-color: transparent;
  border: 1px solid transparent;
  padding: 0.5rem 1.25rem;
  font-size: 1.25rem;
  line-height: 1.5;
  border-radius: 0.25rem;
  transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
</style>
</head>

<body id="page-top">
	
	
	<!-- 今日头条系统顶部 -->
	<nav  style="background-color: black;height:34px;">
		<c:if test="${user==null}">
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 1100px;background-color: red;width:50px;text-align: center;"   href="/user/login">登录</a>
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="/user/register">注册</a>
		</c:if>
		<c:if test="${user!=null}">
			<a  style="margin-left:1010px;text-decoration: none;"   href="/user/homePage">
				<img src="/pic/${user.photo}" style="border-radius:50%" alt="..." width="30px" height="30px">
			</a> 
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left:10px;text-align: center;"   href="my">${user.nickname}</a>
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;background-color: red;width:50px;text-align: center;"   href="/user/logout">注销</a>
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="/my">个人中心</a>
		</c:if>
		
		<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="javascript:void(0)">侵权投诉</a>
		<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="javascript:void(0)">头条产品</a>
	</nav>
	
	<div  id="wrapper">
		<!-- 今日头条系统左部菜单 -->
		<ul style="background-color: white;width:173px !important" class="sidebar navbar-nav"></ul>
		<ul  style="text-align:center;list-style-type:none;background-color: white; " class="sidebar navbar-nav" >
			<li style="display:inline;list-style-type:none;margin-top: 20px;margin-bottom: 10px" class="nav-item">
				<a  href="index">
					<img src="//s3.pstatp.com/toutiao/static/img/logo.271e845.png"  alt="今日头条" style="width: 108px; height: 27px;">
				</a>
			</li>
			<li style="margin-top: 3px">
				<a  class=" my-btn btn-outline-danger ${article.channel_id==null?'active':''}" style="text-decoration:none;"   href="/index">
						 热点
				</a>
			</li>
			<c:forEach items="${channelList}" var="channel">
				<li style="margin-top: 3px">
					<a  class="my-btn btn-outline-danger ${article.channel_id==channel.id?'active':'' }" style="text-decoration:none;"   href="/index?channel_id=${channel.id}" >
							 ${channel.name}
					</a>
				</li>
			</c:forEach>
			
		</ul>
		
		<!-- 中间内容显示区域 -->
		<div id="content-wrapper" style="width:1000px !important">
		<!-- 搜索框 -->
			<form action="/search" method="get">
				<div class="input-group mb-3">
					<input type="text" name="key" value="${key}" class="form-control"
						placeholder="请输入要搜索的内容" aria-label="Recipient's username"
						aria-describedby="button-addon2">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" id="button-addon2">搜索</button>
					</div>
				</div>
			</form>
			<c:if test="${article.channel_id==null}">
				<!-- 	轮播图 -->
				  <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
							<li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
							<li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner">
							<c:forEach items="${slides}" var="s" varStatus="i">
								<div class="carousel-item ${i.index==0?'active':'' }">
									<img src="/pic/${s.picture}" class="d-block w-100" alt="..."
										width="200px" height="200px">
									<div class="carousel-caption d-md-block d-none">
										<h5>${s.title }</h5>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- 左右切换轮播图 -->
						<a class="carousel-control-prev" href="#carouselExampleCaptions"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
							role="button" data-slide="next"> <span
							class="carousel-control-next-icon" aria-hidden="true"></span> <span
							class="sr-only">Next</span>
						</a>
					</div>
					
				<div id="hotArticle" >
				<hr>
						<ul class="list-unstyled">
							<c:forEach items="${hots.list}" var="h">
								<li class="media">
									<a href="/index/select?id=${h.id }" >
										<img src="/pic/${h.picture }" class="mt-1" alt="..." width="150px" height="100px">
									</a>
									<div class="media-body " style="margin-left: 50px;padding-top: 10px">
										<h5 class="mt-0 mb-1 ">
											<a href="/index/select?id=${h.id }" 
											style="font-size: 25px;color: black;font-weight: bold;">${h.title }</a> 
										</h5>
										<br> ${h.user.username }&nbsp;&nbsp;&nbsp;
										<fmt:formatDate value="${h.created }" pattern="yyyy-MM-dd" />
									</div></li>
								<hr>
							</c:forEach>
						</ul>
					<!-- 分页 -->
					  <%-- <ul class="pagination">
					    <li class="page-item">
					      <a class="page-link" href="/index?pageNum=${page==0?'1':hots.prePage}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					     <c:forEach items="${hots.navigatepageNums}" var="page">
					    	 <li class="page-item"><a class="page-link" href="/index?pageNum=${page}">${page}</a></li>
					    </c:forEach> 
					   
					    
					    <li class="page-item">
					      <a class="page-link" href="/index?pageNum=${page==0?hots.pages:hots.nextPage}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>  --%>
						
				</div>
				
			</c:if>
			<!-- 栏目下的文章 -->
			<c:if test="${article.channel_id!=null}">
				<div >
				  <button type="button" class="btn" style="margin-right: 10px;font-weight: bolder;${article.category_id==null?'color:red':''}" onclick="location='/index?channel_id=${article.channel_id}'">全部</button>
				  <c:forEach items="${cates}" var="cate">
				  	<button type="button" class="btn " style="margin-right: 10px;font-weight: bolder; ${cate.id==article.category_id?'color:red':''}" onclick="location='/index?channel_id=${article.channel_id}&category_id=${cate.id}'">${cate.name}</button>
				  </c:forEach>
				  <hr style="background-color:#F0F0F0;height:2px;border:none;">
				</div>
				
			</c:if>	
			<div>
					<ul class="list-unstyled">
						<c:forEach items="${articles.list}" var="a">
							<li class="media">
								<a href="/index/select?id=${a.id }" >
									<img src="/pic/${a.picture }" class="mt-1" alt="..." width="150px" height="100px">
								</a>
								<div class="media-body " style="margin-left: 50px;padding-top: 10px">
									<h5 class="mt-0 mb-1 ">
										<a href="/index/select?id=${a.id }" 
										style="font-size: 25px;color: black;font-weight: bold;">${a.title }</a> 
									</h5>
									<br> ${a.user.username }&nbsp;&nbsp;&nbsp;
									<fmt:formatDate value="${a.created }" pattern="yyyy-MM-dd HH-mm-ss" />
								</div>
							</li>
							<hr>
						</c:forEach>
					</ul>
					 <!-- 分页 -->
					<%--   <ul class="pagination">
					    <li class="page-item">
					      <a class="page-link" href="/index?pageNum=${page==0?'1':hots.prePage}&channel_id=${article.channel_id}&category_id=${article.category_id}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					     <c:forEach items="${articles.navigatepageNums}" var="page">
					    	 <li class="page-item"><a class="page-link" href="/index?pageNum=${page}&channel_id=${article.channel_id}&category_id=${article.category_id}">${page}</a></li>
					    </c:forEach> 
					   
					    
					    <li class="page-item">
					      <a class="page-link" href="/index?pageNum=${page==0?hots.pages:hots.nextPage}&channel_id=${article.channel_id}&category_id=${article.category_id}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>  --%>
					  	<!-- 这是一个最简单的分页 -->
		 <a href="search?key=${key}&pageNum=${pageInfo.pageNum>1?pageInfo.pageNum-1:pageInfo.pageNum}">上一页</a>
	<a href="search?key=${key}&pageNum=${pageInfo.pageNum==pageInfo.pages?pageInfo.pageNum:pageInfo.pageNum+1 }">下一页</a>  
					  
				</div>
			

		</div>
		
		<div style="background-color: white;" class="sidebar navbar-nav">
				<div style="padding: 10px 20px">
					<h5 style="margin-top: 10px">最新文章</h5>
					<ul class="list-unstyled">
							<c:forEach items="${newArticle}" var="n">
								<li class="media">
									<a href="/index/select?id=${n.id }" >
										<img src="/pic/${n.picture }" class="mt-1" alt="..." width="50px" height="50px">
									</a>
									<div class="media-body " style="margin-left: 5px;">
										<a href="/index/select?id=${n.id }" 
										style="font-size: 10px;height:10px;color: black;overflow: hidden;white-space: nowrap;text-overflow:ellipsis ;">${n.title }</a>
										<p style="font-size: 10px;padding-top: 10px">${n.user.username }&nbsp;&nbsp;
									<fmt:formatDate value="${n.created }" pattern="yyyy-MM-dd HH-mm-ss" /></p> 
									</div>
								</li>
								<hr>
							</c:forEach>
					</ul>
				</div>
				<div style="padding: 10px 20px">
					<h5 style="margin-top: 10px">热门推荐</h5>
					<ul class="list-unstyled">
							<c:forEach items="${hotsTen}" var="h">
								<li class="media">
									<a href="/index/select?id=${h.id }" >
										<img src="/pic/${h.picture }" class="mt-1" alt="..." width="50px" height="50px">
									</a>
									<div class="media-body " style="margin-left: 5px;">
										<a href="/index/select?id=${h.id }" 
										style="font-size: 10px;height:10px;color: black;overflow: hidden;white-space: nowrap;text-overflow:ellipsis ;">${h.title }</a>
										<p style="font-size: 10px;padding-top: 10px">${h.user.username }&nbsp;&nbsp;
									<fmt:formatDate value="${h.created }" pattern="yyyy-MM-dd HH-mm-ss" /></p> 
									</div>
								</li>
								<hr>
							</c:forEach>
					</ul>
				</div>
		</div>
		<div style="background-color: white;" class="sidebar navbar-nav"></div>
	</div>
	
	<footer  style="height: 100px;background-color: #e9ecef;position: static;">
		<div class="copyright text-center my-auto" style="padding-top: 20px">
			友情链接：
			<c:forEach items="${links.list}" var="link">
				<a style="text-decoration: none;color: black;padding: 0px 5px;" href="${link.url}">${link.text}</a>
			</c:forEach>
		</div>
		<div class="copyright text-center my-auto" style="padding-top: 10px">
			<span>© Your Website 2020</span>
		</div>
	</footer>
	
</body>
</html>