<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>플레이 리스트</h1>


<c:set var="list" value="${myPlayList }"/>
<c:if test="${!empty list }">
<c:forEach items="${list }" var="vo">
<p>
<a href="<%=request.getContextPath()%>/my_playlist.do?name=${vo.getPlaylist_name() }">
${vo.getPlaylist_name() }</a>
</p>
</c:forEach>
</c:if>

<ul>
<li>하이루</li>
</ul>

</body>
</html>