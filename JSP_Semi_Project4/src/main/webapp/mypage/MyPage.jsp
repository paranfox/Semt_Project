<%@page import="model.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage.jsp</title>
</head>
<body>


	<table border="2" cellspacing="0" width="500" align="center"> 
	 
		<c:set var="vo" value="${vo }" />                   
		      
		<tr>
			<th>아이디</th>
			<td>${vo.getUser_id() }</td>
		</tr>

		<tr>
			<th>이름</th>
			<td>${vo.getUser_name() }</td>
		</tr>

		<tr>
			<th>닉네임</th>
			<td>${vo.getUser_nickname() }</td>
		</tr>

		<tr>
			<th>이메일</th>
			<td>${vo.getUser_email() }</td>
		</tr>

		<tr>
			<th>핸드폰</th>
			<td>${vo.getUser_phone() }</td>
		</tr>

		<tr>
			<td colspan="2" align="center">
				<a href="<%=request.getContextPath()%>/modify.do?num=${vo.getUser_id() }">수정</a> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<a href="<%=request.getContextPath() %>/changePwd.do?num=${vo.getUser_id()}">비밀번호 변경</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<a href="<%=request.getContextPath() %>/delete.do?num=${vo.getUser_id()}">회원 탈퇴</a>
			</td>
		</tr>

	</table>


</body>
</html>