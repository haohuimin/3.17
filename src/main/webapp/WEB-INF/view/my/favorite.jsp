<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function goPage(pageNum){
	var user_id="${user.id}";
	var url="/user/findFavorite?pageNum="+pageNum+"&user_id="+user_id;
	$("#content-wrapper").load(url);
}
function deleteFavorite(id){
	if(confirm("确定删除？")){
		var user_id="${user.id}";
		$.post("/user/deleteFavorite",{id:id},function(result){
			if(result){
				alert("删除成功");
				$("#content-wrapper").load("/user/findFavorite?user_id="+user_id);
			}else{
				alert("删除失败");
			}
		});
	}
}
function add(){
	$("#content-wrapper").load("/user/toAddFavorite");
}
</script>
</head>
<body>
<div style="padding-top: 10px">

		<ul class="list-unstyled">
			<c:forEach items="${page.list}" var="f">
			<li class="media">
				<div style="margin-left: 100px">
					<h5 class="mt-0 mb-1 "><a  href="javascript:void(0)" onclick="location='${f.url}'" style="font-size: 25px;color: black;font-weight: bold;" >${f.text }</a></h5><br>
					时间&nbsp;&nbsp;：&nbsp;&nbsp;
					<fmt:formatDate value="${f.created }" pattern="yyyy-MM-dd"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a  href="javascript:void(0)" onclick="deleteFavorite(${f.id})"  >删除</a>
				</div>
			</li>
			<hr>
			</c:forEach>
			
			<jsp:include page="/WEB-INF/view/public/page.jsp"></jsp:include>
			<button style="float: right;" type="button" class="btn btn-success" onclick="add()">添加收藏</button>
			
		</ul>
	</div>
	


</body>
</html>