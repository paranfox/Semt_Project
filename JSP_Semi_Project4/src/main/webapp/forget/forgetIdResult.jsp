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

	<jsp:include page="../test_main_top.jsp" />

	<div class="main_con"></div>
	
		<h3>아이디 찾기</h3>
		이메일 정보와 일치하는 아이디 입니다.
		
		<br>
		아이디 : ${userId }
		
		<br>
		<input type="button" value="로그인" onclick="location.href='login/login.jsp'">
		<input type="button" value="비밀번호 찾기" onclick="location.hrefs='forget/forgetPwd.jsp'">
		
		
		
</body>
</html>