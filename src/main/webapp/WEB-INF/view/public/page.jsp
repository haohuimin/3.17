<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item">
      <a class="page-link" href="javascript:goPage(${n==0?'1':page.prePage})" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
     <c:forEach items="${page.navigatepageNums}" var="n">
    	 <li class="page-item"><a class="page-link" href="javascript:goPage(${n})">${n}</a></li>
    </c:forEach> 
   
    
    <li class="page-item">
      <a class="page-link" href="javascript:goPage(${n==0?page.pages:page.nextPage})" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>