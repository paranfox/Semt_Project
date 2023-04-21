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
	
	<c:if test="${empty id }">
		<h3>아이디 찾기</h3>
	</c:if>
	<c:if test="${!empty id }">
		<h3>비밀번호 찾기</h3>
	</c:if>
	
	<h4>인증코드 확인</h4>
	<h4>이메일 인증 코드를 입력하세요</h4>
	
	
		<div>
			<form action="<%=request.getContextPath() %>/forget_email_check.do" method="post">
			
				<c:if test="${empty id }">
					<input type="hidden" name="type" value="아이디찾기">
				</c:if>
				<c:if test="${!empty id }">
					<input type="hidden" name="type" value="비밀번호찾기">
					<input type="hidden" name="id" value="${id }">
				</c:if>
				
				<input type="hidden" name="true_code" value="${code }">
				<input type="hidden" name="user_email" value="${email }">
				${email }으로 인증코드를 전달하였습니다. 
				<br>
				인증 코드 : ${code }
				<br> 
				<input name="input_code">
				<input type="submit" value="확인">
			</form>
		</div>

</body>
</html>