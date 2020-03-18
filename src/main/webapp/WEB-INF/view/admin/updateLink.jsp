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
function toUpdate(){
	var text=$("[name=text]").val();
	var url=$("[name=url]").val();
	if(text==null || text=="") {
		$("#alert").html("链接名称不能为空");
		$("#alert").show();
		return;
	}
	if(url==null || url=="") {
		$("#alert").html("链接地址不能为空");
		$("#alert").show();
		return;
	}
	var zhengze=/^http:\/\/([\w-]+\.)+[\w-]+(\/[\w-.\/?%&=]*)?$/;
	if(!zhengze.test(url)){
		$("#alert").html("您输入的链接地址不合法，请重新输入");
		$("#alert").show();
		return;
	}
	var updateLink=$("form").serialize();
	$.post(
			"/link/update",
			updateLink,
			function(result){
				if(result){
					$("#alert").hide();
					alert("修改成功");
					$("#content-wrapper").load("/link/selects");
				}else {
					$("#alert").html("修改失败");
					$("#alert").show();
					return;
				}
			}
	);
}
function link(){
	$("#content-wrapper").load("/link/selects");
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
  padding: 0.5rem 0rem;
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
	    <li class="breadcrumb-item"><a href="#" onclick="link()">友情链接</a></li>
	    <li class="breadcrumb-item active" aria-current="page">添加友情链接</li>
	  </ol>
	</nav>
	
	<form action="">
		<div id="alert" class="alert alert-danger my-2" style="display: none;margin-left: 20px;width: 992px" role="alert">
			  
		</div>
		<div class="card-body py-3">
				<input type="hidden"  name="id" value="${link.id}" /> 
              <div class="form-group">
                  <label class="form-control-label">链接名称</label> 
                  <input type="text" name="text"  value="${link.text}"  class="form-control">
              </div>

              <div class="form-group">
                  <label class="form-control-label">链接地址</label>
                  <input type="text" name="url"  value="${link.url}" class="form-control">
              </div>

            <button type="button"  style="float: right;" class="btn btn-success"  onclick="toUpdate()">确定修改</button>
          </div>
		
		
	</form>
    
</div>
</body>
</html>