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
function loginUser(){
	var id="${id}";
	var username=$("[name=username]").val();
	var password=$("[name=password]").val();
	if(username==null || username=="" || password=="" || password==null){
		$("#alert").show();
		$("#alert").html("用户名或密码不能为空");
		return ;
	}
	$.post("loginUser",$("form").serialize(),function(result){
		if(result=="true"){
			$("#alert").hide();
			if(id!=""){
				location="/index/select?id="+id;
				return;
			}
			location="/index";
		}else{
			$("#alert").show();
			if(result=="usernameNo"){
				$("#alert").html("用户名不存在");
			}
			if(result=="passwordNot"){
				$("#alert").html("密码错误");
			}
			if(result=="locked"){
				$("#alert").html("用户已被禁止登录，请联系管理员");
			}
			
			return ;
		}
	});
	
}
</script>

</head>
<body>

    <div  style="padding: 10rem !important;">
        <div class="row justify-content-center"> 
            <div class="col-md-5">
                <div class="card p-2" style="border-width:3px">
                    <div class=" text-center  text-uppercase h4">
                       		 用户登录/注册
                    </div>
                    <hr>

                    <form action="loginUser" method="post">
                    	<div id="alert" class="alert alert-danger my-2" style="display: none;margin-left: 20px;width: 404px" role="alert">
						  
						</div>
                    	
	                    <div class="card-body py-3">
	                        <div class="form-group">
	                            <!-- <label class="form-control-label">用户名</label> -->
	                            <input type="text" name="username" placeholder="用户名" class="form-control">
	                        </div>
	
	                        <div class="form-group">
	                            <!-- <label class="form-control-label">密码</label> -->
	                            <input type="password" name="password" placeholder="密码" class="form-control">
	                        </div>
	
	                        <!-- <div class="custom-control custom-checkbox mt-4">
	                            <input type="checkbox" class="custom-control-input" id="login">
	                            <label class="custom-control-label" for="login">记住密码</label>
	                        </div> -->
	                    </div>
	                    <div class=" text-center  text-uppercase" style="margin-bottom: 20px">
	                       		<button type="button" class="btn btn-danger font-weight-bold" style="padding: 0.75rem 12rem;" onclick="loginUser()">登录</button>
	                    </div>
	                    
                    </form>
                   
                </div>
            </div>
            
        </div>
        <div class=" text-center  text-uppercase ">
	         <span class="btn my-3">登录/注册即表示你同意 用户协议 和 隐私条款</span>
	          <a href="register"  class="btn btn-link my-3">点击注册</a>
	    </div>
    </div>
   
</body>
</html>