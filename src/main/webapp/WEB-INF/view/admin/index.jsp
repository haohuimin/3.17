<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 引入bootstrap样式 -->
<link rel="stylesheet" type="text/css"
	href="resource/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="resource/css/sb-admin.css" />
<script type="text/javascript" src="resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="resource/js/bootstrap.min.js"></script>
<script type="text/javascript">
//给左侧(left.jsp)中的所有的连接绑定点击事件
$(function(){
	$("[style='text-decoration:none;']").click(function(){
		$("[style='text-decoration:none;']").attr("class","my-btn btn-outline-danger");
		$(this).attr("class","my-btn btn-outline-danger active");
		//获得跳转路径
		var url=$(this).attr("data");
		//跳转到url  查询的结果得在index页面中id="content-wrapper"的div中显示
		$("#content-wrapper").load(url);
		
	})
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
  padding: 0.5rem 0rem;
  font-size: 1.25rem;
  line-height: 1.5;
  border-radius: 0.25rem;
  transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
</style>
</head>

<body id="page-top">
	
	
	<!-- 后台管理系统顶部 -->
	<jsp:include page="top.jsp" />
	<div id="wrapper">
		<!-- 后台管理系统左部菜单 -->
		<jsp:include page="left.jsp" />
		<!-- 中间内容显示区域 -->
		<div id="content-wrapper">
				<br /> <br />
				<br /> <br />
				<h1 align="center">欢迎光临CMS系统后台</h1>
		</div>
		<ul style="background-color: white;" class="sidebar navbar-nav"></ul>
	</div>
</body>
</html>