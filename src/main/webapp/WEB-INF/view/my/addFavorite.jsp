<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="/resource/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/resource/css/sb-admin.css" />
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>
<script type="text/javascript">
function add(){
	var text=$("[name=text]").val();
	var url=$("[name=url]").val();
	if(text==null || text=="") {
		$("#alert").html("收藏夹文本不能为空");
		$("#alert").show();
		return;
	}
	if(url==null || url=="") {
		$("#alert").html("收藏夹地址不能为空");
		$("#alert").show();
		return;
	}
	var zhengze=/^http:\/\/([\w-]+\.)+[\w-]+(\/[\w-.\/?%&=]*)?$/;
	if(!zhengze.test(url)){
		$("#alert").html("您输入的收藏夹地址不合法，请重新输入");
		$("#alert").show();
		return;
	}
	var user_id="${user.id}";
	var addFavorite=$("form").serialize();
	
	$.post(
			"/user/addFavorite",
			addFavorite,
			function(result){
				if(result==true){
					$("#alert").hide();
					alert("新增成功");
					$("#content-wrapper").load("/user/findFavorite?user_id="+user_id);
				}else if(result=="NoUrl"){
					$("#alert").html("收藏夹地址格式不正确");
					$("#alert").show();
					return;
				}
			}
	);
}
function link(){
	var user_id="${user.id}";
	$("#content-wrapper").load("/user/findFavorite?user_id="+user_id);
}
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
  padding:0.775rem 0rem;
  font-size: 1.25rem;
  line-height: 1.5;
  border-radius: 0.25rem;
  transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
</style>
</head>
<body>
<div style="padding: 0 10px 0 10px">
	<nav style="margin-left: 20px;width: 992px" aria-label="breadcrumb">
	  <ol class="breadcrumb">
	    <li class="breadcrumb-item"><a href="/admin" >首页</a></li>
	    <li class="breadcrumb-item"><a href="#" onclick="link()">我的收藏夹</a></li>
	    <li class="breadcrumb-item active" aria-current="page">添加收藏</li>
	  </ol>
	</nav>
	
	<form action="">
		<div id="alert" class="alert alert-danger my-2" style="display: none;margin-left: 20px;width: 992px" role="alert">
			  
		</div>
		
		<div class="card-body py-3">
               <div class="form-group">
                   <label class="form-control-label">收藏夹文本</label> 
                   <input type="text" name="text"  class="form-control">
                   <input type="hidden" name="user_id" value="${user.id}"  class="form-control">
               </div>

               <div class="form-group">
                   <label class="form-control-label">收藏夹地址</label>
                   <input type="text" name="url"  class="form-control">
               </div>

              <button type="button" style="float:right"  class="btn btn-success"  onclick="add()">确定增加</button>
           </div>
	</form>
</div>

</body>
</html>