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
	var title=$("[name=title]").val();
	var status=$("[name=status]").val();
	var url="/article/selects?title="+title+"&status="+status;
	$("#content-wrapper").load(url);
}
function goPage(pageNum){
	var title=$("[name=title]").val();
	var status=$("[name=status]").val();
	var url="/article/selects?pageNum="+pageNum+"&"+$("#f1").serialize();
	$("#content-wrapper").load(url);
}

//查看详情
function look(id){
	//根据id  查询文章
	 $.post(
		"/article/selectArticle",
		{id:id},
		function(result){
			//把值给谁?
			$("#exampleModalLabel").html(result.title);
			$(".modal-body").html(result.content);
			$("[name='id']").val(result.id);
		}
	); 
}

function changeStatus(status,obj){
	var id=$(obj).val();
	$.post("/article/updateStatus",{status:status,id:id},function(result){
		if(result){
			alert("审核成功!");
			check();
		}else{
			alert("审核失败!");
		}
	});
	
}
</script>
</head>
<body>
	<div style="padding: 0 10px 0 10px">


		<div>
			<form id="f1">
				姓名: <input type="text" name="title" value="${title}" /> 状态:<select
					name="status">
					<option value="">请选择</option>
					<option value="0" ${status==0?'selected':'' }>待审</option>
					<option value="1" ${status==1?'selected':'' }>审核通过</option>
					<option value="-1" ${status==-1?'selected':'' }>审核未通过</option>
				</select>

				<button type="button" class="btn btn-success" onclick="check()">搜索</button>
			</form>
		</div>
		<br>

		<div class="table-responsive-sm">



			<table class="table table-striped">
				<thead>
				<tr>
					<th>编号</th>
					<th>标题</th>
					<th>标题图片</th>
					<th>作者</th>
					<th>点击量</th>
					<th>是否热门</th>
					<th>是否审核通过</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
				</thead>
				<c:forEach items="${list}" var="a" varStatus="i">
					<tr>
						<td>${a.id }</td>
						<td>${a.title}</td>
						<td>
							<img alt="" style="width: 60px;" src="/pic/${a.picture}">
						</td>
						<td>${a.user.username}</td>
						<td>${a.hits}</td>
						<td>${a.hot>=10?'是':'否'}</td>
						<td>${a.status==0?'待审':a.status==1?'审核通过':'审核未通过'}</td>
						<td><fmt:formatDate value="${a.created}" /></td>
						<td>
							
							<button type="button" onclick="look(${a.id})" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalScrollable">
							 详情
							</button>
						</td>
					</tr>


				</c:forEach>

			</table>
		</div>
		<jsp:include page="/WEB-INF/view/public/page.jsp"></jsp:include>

	</div>

	


		<!-- Modal -->
		<div class="modal fade" id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-scrollable" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		       <h5 class="modal-title" id="exampleModalLabel"></h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        ...
		      </div>
		      <div class="modal-footer">
		       <button type="button" name="id" class="btn btn-success"
					data-dismiss="modal" onclick="changeStatus(1,this)">通过</button>
				<button type="button" name="id" class="btn btn-primary"
					data-dismiss="modal" onclick="changeStatus(-1,this)">不通过</button>
		      </div>
		    </div>
		  </div>
		</div>

	
	
</body>
</html>