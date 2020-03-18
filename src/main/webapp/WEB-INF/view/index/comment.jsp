<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:forEach  items="${comments.list}" var="comment">
	<li class="media">
		<a  style="text-decoration: none;"   href="javascript:void(0)">
			<img src="/pic/${comment.user.photo}" style="border-radius:50%" alt="..." width="50px" height="50px">
		</a> 
		<div  style="margin-left: 10px;">
			<a href="#" style="text-decoration : none;" ><span >${comment.user.username }&nbsp;&nbsp;
			<fmt:formatDate value="${comment.created }" pattern="yyyy-MM-dd HH-mm-ss" /></span></a>
			<br> 
			<span  style="font-size: 15px;">${comment.content }</span>
		</div>
	</li>
	<hr>
</c:forEach>
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item">
      <a class="page-link" href="javascript:goPage(${n==0?'1':comments.prePage})" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
     <c:forEach items="${comments.navigatepageNums}" var="n">
    	 <li class="page-item"><a class="page-link" href="javascript:goPage(${n})">${n}</a></li>
    </c:forEach> 
   
    
    <li class="page-item">
      <a class="page-link" href="javascript:goPage(${n==0?comments.pages:comments.nextPage})" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>