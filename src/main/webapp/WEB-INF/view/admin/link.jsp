<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

function check(){
	var text=$("[name=text]").val();
	var url="/link/selects?text="+text;
	$("#content-wrapper").load(url);
}
function goPage(pageNum){
	var text=$("[name=text]").val();
	var url="/link/selects?pageNum="+pageNum+"&text="+text;
	$("#content-wrapper").load(url);
}
//修改
function update(id){
	$("#content-wrapper").load("/link/selectLinkID?id="+id);
	
}

//新增
function add(){
	$("#content-wrapper").load("/link/toAdd");
}
</script>
</head>
<body>
	<div style="padding: 0 10px 0 10px">
		<div>
			<form id="f1">
				链接名称: <input type="text" name="text" value="${text}" /> 
				<button type="button" class="btn btn-success" onclick="check()">搜索</button>
				<button type="button" class="btn btn-success" onclick="add()">添加链接</button>
			</form>
		</div>
		<br>

		<div class="table-responsive-sm">
			<table class="table table-striped">
				<thead>
				<tr>
					<th>编号</th>
					<th>链接名称</th>
					<th>链接地址</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
				</thead>
				<c:forEach items="${link}" var="l" varStatus="i">
					<tr>
						<td>${l.id }</td>
						<td>${l.text}</td>
						<td>${l.url}</td>
						<td><fmt:formatDate value="${l.created}" /></td>
						<td>
							<button type="button" onclick="update(${l.id})" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalScrollable">
							 修改
							</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<jsp:include page="/WEB-INF/view/public/page.jsp"></jsp:include>

	</div>

		
</body>
</html>