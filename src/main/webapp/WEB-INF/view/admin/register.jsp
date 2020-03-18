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
	var username=$("[name=admin_username]").val();
	var password=$("[name=admin_password]").val();
	var password2=$("[name=admin_password2]").val();
	if(username==null || username=="" || password=="" || password==null  || password2=="" || password2==null){
		$("#alert").show();
		$("#alert").html("管理员账号或密码不能为空");
		return ;
	}
	if(password!=password2){
		$("#alert").show();
		$("#alert").html("两次密码不一致");
		return ;
	}
	$.post("/registerAdmin",$("form").serialize(),function(result){
		if(result=="true"){
			$("#alert").hide();
			location="/login";
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
<div  style="padding: 9rem !important;">
        <div class="row justify-content-center"> 
            <div class="col-md-5">
                <div class="card p-3" style="border-width:3px">
                    <div class=" text-center  text-uppercase h4">
                       		 管理员注册
                    </div>
					<form action="user/registerUser" method="post">
						<div id="alert" class="alert alert-success" style="display: none;margin-left: 20px;width: 417px" role="alert">
						  
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
	                        <div class="form-group">
	                            <label class="form-control-label">确认密码</label>
	                            <input type="password" name="admin_password2" class="form-control">
	                        </div>
	
	                    </div>
	                    <div class=" text-center  text-uppercase h4">
	                       		<button type="button" class="btn btn-dark px-5" onclick="register()">注册</button>
	                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>