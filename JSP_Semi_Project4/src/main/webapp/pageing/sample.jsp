<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%-- 페이징 처리 하나 만들어 놓고 연속으로 써먹기 --%>
	
	   <nav>
	      <ul class="pagination">
	         <li class="page-item">   <!-- 처음 페이지로 이동 -->
	            <a class="page-link" href="pageing_list.do?page=1">First</a>
	         </li>
	         <li>     <!-- 현재 페이지의 이전 페이지로 이동 -->
	            <a class="page-link" href="pageing_list.do?page=${page - 1 }">Previous</a>
	         </li>
	                                 <!-- 부트 스트랩 사용 -->
	         <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
	            <c:if test="${i == page }">
	               <li class="page-item active" aria-current="page">
	                  <a class="page-link" href="pageing_list.do?page=${i }">${i }</a>
	               </li>
	            
	            </c:if>
	             <c:if test="${i != page }">
	               <li class="page-item">
	                  <a class="page-link" href="pageing_list.do?page=${i }">${i }</a>
	               </li>
	            
	            </c:if>
	         </c:forEach>
	                         <!-- 페이지가 5이상인 경우 6이상은 사라지게 만듬. -->
	         <c:if test="${endBlock < allPage }">
	             <li class="page-item">
	                  <a class="page-link" href="pageing_list.do?page=${page + 1 }">Next</a>
	             </li>
	             <li class="page-item">
	                  <a class="page-link" href="pageing_list.do?page=${allPage }">End</a>
	             </li>
	             
	         </c:if>
	      </ul>
	      
	   </nav>
	   
</body>
</html>