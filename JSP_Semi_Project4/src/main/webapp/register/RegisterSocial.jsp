<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
	<header>Create Your Account(Social)</header>

	<div>
		<form
			action="<%=request.getContextPath()%>/register.do"
			method="post">
			
			<input type="hidden" name="user_id" value=${param.social_id }>
			<input type="hidden" name="user_pwd" value=${param.social_pwd }>
			<fieldset>
				<legend>추가 정보 입력</legend>
				<ul>
					<li>이름 : <input type="text" name="user_name" required placeholder="공백없이 입력하세요"></li>
					<li>닉네임 : <input type="text" name="user_nickname" value="${param.social_nickname }" required></li>
					<li>이메일 : <input type="text" name="user_email" value="${param.social_email }" required></li>
					<li>전화번호 : <input type="text" name="user_phone" placeholder="공백없이 입력하세요"></li>
					<li>사진 : <input type="file" name="user_pic"></li>
				</ul>
			</fieldset>
			<br>
			<fieldset>
				<input type="submit" name="submit" value="보내기"> 
				<input type="reset" name="reset" value="다시 작성">
			</fieldset>
		</form>
	</div>

</body>
</html>


