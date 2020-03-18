<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="/resource/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/resource/css/sb-admin.css" />
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>
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
 #fileDiv{
     position: relative;
 }
 #fileInput{
     opacity:0;
     filter:alpha(opacity=0);
     height: 95px;
     width: 100px;
     position: absolute;
     top: 0;
     left: 0;
     z-index: 9;
 }
</style>
<script type="text/javascript">
$(function(){
	$("#fileInput").change(function(){
		var file = this.files[0]; //获取File对象
		if(!/image\/\w+/.test(file.type)) {
			alert("请选择一张图片");
			return false;
		}
		if(typeof FileReader != "undefined") {
			//创建读取文件的对象
			var reader = new FileReader();
			//创建文件读取相关的变量
			var imgFile;
			//正式读取文件
			reader.readAsDataURL(file);
			//为文件读取成功设置事件
			var str = "";
			reader.onload = function(e) {
				imgFile = e.target.result;
				$("#photo").attr("src", imgFile);
			};
		} else {
			var URL = window.URL || window.webkitURL;
			var imageURL = URL.createObjectURL(file);
			$("#photo").attr("src", imageURL);
		}
	}); 
	var sex="${user.gender.displayName}";
	if(sex=="女"){
		$("#gridRadios2").prop("checked",true);
	}else if(sex=="男"){
		$("#gridRadios1").prop("checked",true);
	}
})

function updateUser(){
	
	if($("#inputNickname").val()==null || $("#inputNickname").val()==""){
		$("#alert").show();
		$("#alert").html("昵称不能为空");
		return;
	}
	if($("#inputBirther").val()==null || $("#inputBirther").val()==""){
		$("#alert").show();
		$("#alert").html("生日不能为空");
		return;
	}
	var formData=new FormData($("#updateUser")[0]);
	$.ajax({
		//设置ajax不要处理数据
		processData:false,
		//没有请求头
		contentType:false,
		url:"/user/updateUser",
		data:formData,	
		type:"post",
		success:function(result){
			if(result){
				$("#alert").hide();
				alert("修改成功");
				location.href="/user/homePage";
			}else{
				$("#alert").hide();
				alert("修改失败");
				location.href="/user/homePage";
			}
			
		}
	});
	
} 
</script> 
</head>
<body id="page-top">
	
	
	<!-- 今日头条系统顶部 -->
	<nav  style="background-color: black;height:34px;">
		<c:if test="${user==null}">
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 1100px;background-color: red;width:50px;text-align: center;"   href="/user/login">登录</a>
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="/user/register">注册</a>
		</c:if>
		<c:if test="${user!=null}">
			<a  style="margin-left:900px;text-decoration: none;"   href="/user/homePage">
				<img src="/pic/${user.photo}" style="border-radius:50%" alt="..." width="30px" height="30px">
			</a> 
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left:10px;text-align: center;"   href="my">${user.nickname}</a>
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;background-color: red;width:50px;text-align: center;"   href="/user/logout">注销</a>
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="/my">个人中心</a>
			<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="/index">头条首页</a>
		</c:if>
		
		<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="javascript:void(0)">侵权投诉</a>
		<a class="navbar-brand mr-1" style="color: white;font-size: 1rem;margin-left: 20px;text-align: center;"   href="javascript:void(0)">头条产品</a>
	</nav>
	
	<nav style="height:50px;margin-top: 10px; ">
		<p ></p>	
		<img src="//s3.pstatp.com/toutiao/static/img/logo.271e845.png"  alt="今日头条" style="width: 108px; height: 27px;margin-left: 230px;">
	    <p ></p>	
	    <hr style="background-color:#B8B8B8;height:1px;border:none;">
	</nav>
		
		
	
	<!-- 中间显示内容 -->
	<div id="wrapper" style="padding-top: 0px;background-color:#F0F0F0;">
		<!-- 中间左侧边框 --> 
		<div style="background-color: white;width:340px !important;background-color:#F0F0F0;" class="sidebar navbar-nav"></div>
		
		
		
		<!-- 中间内容显示区域 -->
		<div id="content-wrapper" style="background-color: #F0F0F0;" >
			<!-- 中间上部内容         显示区域 -->
			<div style="background-color: white;height: 250px">
				<div style="background-color: red;height: 180px;background: url(/pic/${user.photo}) no-repeat;background-size: cover;">
					
				</div>
				<a  style="text-decoration: none;"   href="#">
					<img  src="/pic/${user.photo}" style="border-radius:50%;position:absolute;top: 250px;left: 260px;" alt="..." width="100px" height="100px">
				</a>
				<p style="padding-left: 140px;padding-top:8px;font-size:x-large;font-weight: bold;">${user.nickname}</p>
			</div>
			
			<!-- 资料修改         显示区域 -->
			<div style="background-color: white;height: 600px;width: 700px;margin-top: 20px;float: left;">
				<p  style="font-weight:600;margin-top: 15px;margin-left: 40px" >个人资料</p>
				<hr>
				<form method="post" id="updateUser" action="/user/updateUser" enctype="multipart/form-data"  style="width:600px">
				<div style="margin-top: 15px;margin-left: 40px">
					<div id="alert" class="alert alert-danger my-2" style="display: none;width: 560px;" role="alert">
						  
					</div>
					<div class="form-group row">
					    <label for="fileInput" class="col-sm-2 col-form-label">头像 </label>
					    <div id="fileDiv" class="col-sm-10">
					    	<input id="fileInput" name="myFile"  type="file">
					    	<input  name="id" type="hidden" value="${user.id}">
					      	<img id="photo" src="/pic/${user.photo}"   alt="..." width="100px" height="100px">
					    </div>
					</div>
				
					<div class="form-group row">
					    <label for="inputNickname" class="col-sm-2 col-form-label">昵称</label>
					    <div class="col-sm-10">
					      <input type="text" name="nickname" value="${user.nickname }" class="form-control" id="inputNickname">
					    </div> 
					</div>
					<div class="form-group row">
					    <label for="inputBirther" class="col-sm-2 col-form-label">生日</label>
					    <div class="col-sm-10">
					      <input type="date" name="birthday" value="<fmt:formatDate value='${user.birthday }' pattern='yyyy-MM-dd' />" class="form-control" id="inputBirther">
					    </div>
					</div>
					  <fieldset class="form-group">
					    <div class="row">
					      <legend class="col-form-label col-sm-2 pt-0">性别</legend>
					      <div class="col-sm-10">
					        <div class="form-check">
					          <input class="form-check-input" type="radio" name="gender" id="gridRadios1" value="MAN" checked>
					          <label class="form-check-label" for="gridRadios1">
					            	男
					          </label>
					        </div>
					        <div class="form-check">
					          <input class="form-check-input" type="radio" name="gender" id="gridRadios2" value="WOMAN">
					          <label class="form-check-label" for="gridRadios2">
					            	女
					          </label>
					        </div>
					      </div>
					    </div>
					  </fieldset>
					  
					  <div class="form-group row">
					    <div class="col-sm-10">
					      <button type="button" onclick="updateUser()" class="btn btn-primary">修改</button>
					    </div>
					  </div>
				</div>
				</form>
			</div>
			
			<!-- 文章数据         显示区域 -->
			<div style="background-color: white;height: 100px;width: 327px;margin-left:20px;margin-top: 20px;float: left;">
			
			</div> 
		</div>
		
		
		<!-- 中间右侧边框 -->
		<div style="background-color: white;width:340px !important;background-color:#F0F0F0;" class="sidebar navbar-nav"></div>
		
	</div>
	
	<footer  style="height: 100px;background-color:white;position: static;">
		
		<div class="copyright text-center my-auto" style="padding-top: 30px">
			<span>光辉制作© Your Website 2020</span>
		</div>
	</footer>
	
</body>

</html>