<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="vo" value="${userVO }"></c:set>
	<h3>Follows of ${vo.getUser_nickname() }</h3>
	
	<table border="1">
		<tr>
			<th>프로필 사진</th>
			<th>닉네임</th>
			<th>팔로워</th>
		</tr>
		
		<c:set var="followerList" value="${followerList }"></c:set>
		<c:if test="${!empty followerList }">
			<c:forEach items="${followerList }" var="fvo" >
				<tr>
					<td>${fvo.getUser_pic() }</td>				
					<td>${fvo.getUser_nickname() }</td>				
					<td>${fvo.getFollowers_count() }</td>				
				</tr>
			</c:forEach>
		</c:if>
		
	</table>
	
</body>
</html>