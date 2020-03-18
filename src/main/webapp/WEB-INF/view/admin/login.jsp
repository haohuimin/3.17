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
	var username=$("[name=admin_username]").val();
	var password=$("[name=admin_password]").val();
	if(username==null || username=="" || password=="" || password==null){
		$("#alert").show();
		$("#alert").html("管理员账号或密码不能为空");
		return ;
	}
	$.post("/loginAdmin",$("form").serialize(),function(result){
		
		if(result=="true"){
			$("#alert").hide();
			location="/admin";
		}else{
			$("#alert").show();
			if(result=="usernameNo"){
				$("#alert").html("管理员账号不存在");
			}
			if(result=="passwordNot"){
				$("#alert").html("密码错误");
			}
			
			return ;
		}
	});
	
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

<!-- class="container" card border border-danger -->
    <div  style="padding: 10rem !important;">
        <div class="row justify-content-center"> 
            <div class="col-md-5">
                <div class="card p-3" style="border-width:3px">
                    <div class=" text-center  text-uppercase h4">
                       		 管理员登录/注册
                    </div>
					<form action="loginUser" method="post">
                    	<div id="alert" class="alert alert-success" style="display: none;margin-left: 20px;width: 404px" role="alert">
						  
							</div>
	                    <div class="card-body py-3">
	                        <div class="form-group">
	                            <label class="form-control-label">管理员账号</label>
	                            <input type="text" name="admin_username" class="form-control">
	                        </div>
	
	                        <div class="form-group">
	                            <label class="form-control-label">管理员密码</label>
	                            <input type="password" name="admin_password" class="form-control">
	                        </div>
	
	                        <!-- <div class="custom-control custom-checkbox mt-4">
	                            <input type="checkbox" class="custom-control-input" id="login">
	                            <label class="custom-control-label" for="login">记住密码</label>
	                        </div> -->
	                    </div>
	
	                    
	                        <div class="row text-center">
	                            <div class="col-6">
	                                <button type="button" class="btn btn-dark px-5" onclick="loginUser()">登录</button>
	                            </div>
	
	                            <div class="col-6">
	                                <a href="register" class="btn btn-dark px-5">注册</a>
	                            </div>
	                        </div>
                   </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>