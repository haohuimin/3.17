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
function register(){
	var username=$("[name=username]").val();
	var password=$("[name=password]").val();
	var password2=$("[name=password2]").val();
	if(username==null || username=="" || password=="" || password==null  || password2=="" || password2==null){
		$("#alert").show();
		$("#alert").html("用户名或密码不能为空");
		return ;
	}
	if(password!=password2){
		$("#alert").show();
		$("#alert").html("两次密码不一致");
		return ;
	}
	$.post("registerUser",$("form").serialize(),function(result){
		if(result=="true"){
			$("#alert").hide();
			location="/user/login";
		}else{
			$("#alert").show();
			if(result="existUser"){
				$("#alert").html("用户已存在");
				return ;
			}
			return ;
		}
	});
}

</script>
</head>
<body>
<div  style="padding: 9rem !important;">
        <div class="row justify-content-center"> 
            <div class="col-md-5">
                <div class="card p-2" style="border-width:3px">
                    <div class=" text-center  text-uppercase h4">
                       		 用户注册
                    </div>
                    <hr>
					<form action="user/registerUser" method="post">
						<div id="alert" class="alert alert-danger" style="display: none;margin-left: 20px;width: 417px" role="alert">
						  
						</div>
						  <div class="card-body py-2">
	                        <div class="form-group">
	                            
	                            <input type="text" name="username" placeholder="用户名" class="form-control">
	                        </div>
	
	                        <div class="form-group">
	                            
	                            <input type="password" name="password" placeholder="密码" class="form-control">
	                        </div>
	                        <div class="form-group">
	                            
	                            <input type="password" name="password2" placeholder="确认密码" class="form-control">
	                        </div>
	
	                        
	                    </div>
	                    <div class=" text-center  text-uppercase " style="margin-bottom: 20px">
	                       		
	                       		<button type="button" class="btn btn-danger font-weight-bold" style="padding: 0.75rem 12rem;" onclick="register()">注册</button>
	                    </div>
					</form>
                  
                </div>
            </div>
        </div>
    </div>
</body>
</html>