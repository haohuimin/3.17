<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function check(){
	var username=$("[name=username]").val();
	var url="/user/selects?username="+username;
	$("#content-wrapper").load(url);
}
function locted(locted,id){
	var loct=locted==0?1:0;
	$.post("user/updateLocated",{locted:loct,id:id},function(result){
		check();
	},"json");
}

function goPage(pageNum){
	var username=$("[name=username]").val();
	var url="/user/selects?username="+username+"&pageNum="+pageNum;
	$("#content-wrapper").load(url);
}
</script>
</head>
<body>

<div  style="padding: 0 10px 0 10px;">

	<div>
		用户名:
		<input type="text" name="username" value="${username}"/>
		<button type="button" class="btn btn-success" onclick="check()">搜索</button>
	</div>
	<br>

	<table class="table table-bordered">
		<tr>
				<td>序号</td>
				<td>用户名</td>
				<td>昵称</td>
				<td>性别</td>
				<td>生日</td>
				<td>注册日期</td>
				<td>修改日期</td>
				<td>状态</td>
			</tr>
			<c:forEach items="${list }" var="u" varStatus="i">
				<tr>
					<td>${i.index+1 }</td>
					<td>${u.username }</td>
					<td>${u.nickname }</td>
					<td>${u.gender.displayName}</td>
					<td>
					<fmt:formatDate value="${u.birthday }"/>
					</td>
					<td>
					<fmt:formatDate value="${u.created}"/>
					</td>
					<td>
					<fmt:formatDate value="${u.updated}"/>
					</td>
					<td>
						<c:if test="${u.locked==0}">
						<button type="button" class="btn btn-success" onclick="locted(${u.locked},${u.id})">改为禁用</button>
							
						</c:if>
						
						<c:if test="${u.locked==1}">
						<button type="button" class="btn btn-secondary" onclick="locted(${u.locked},${u.id})">改为正常</button>
							
						</c:if>
					</td>
				</tr>


			</c:forEach>
			
	</table>
	<jsp:include page="/WEB-INF/view/public/page.jsp" flush="true"></jsp:include>
	
</div>
</body>
</html>