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
	var url="/article/selectArticleList?pageNum="+pageNum;
	$("#content-wrapper").load(url);
}
function look(id){
	
	$.post("/article/selectArticle",{id:id},function(result){
		$("#exampleModalLabel").html(result.title);
		$(".modal-body").html(result.content);
		
		
	});
}
</script>
</head>
<body>
<div style="padding-top: 10px">

		<ul class="list-unstyled">
			<c:forEach items="${list}" var="a">
			<li class="media">
				<a  href="javascript:void(0)" onclick="look(${a.id})" data-toggle="modal" data-target="#exampleModal">
					<img style="margin-left: 100px" src="/pic/${a.picture}" class="mr-3" alt="..."  width="120px" height="100px">
				</a>
				
				<div style="margin-left: 100px">
					<h5 class="mt-0 mb-1 "><a  href="javascript:void(0)" onclick="look(${a.id})" style="font-size: 25px;color: black;font-weight: bold;" data-toggle="modal" data-target="#exampleModal">${a.title }</a></h5><br>
					${a.user.username }&nbsp;&nbsp;·&nbsp;&nbsp;
					<fmt:formatDate value="${a.created }" pattern="yyyy-MM-dd"/>
					
				</div></li>
				<hr>
				</c:forEach>
				<jsp:include page="/WEB-INF/view/public/page.jsp"></jsp:include>
		</ul>
	</div>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog"   role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

 		
</body>
</html>