<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div align="center">
		<h2>로그인 페이지</h2>
		
		<form method="post" action="http://localhost:8989/JSP_Semi_Project/LoginServlet?cmd=login">
		
		<table>
			<tr>
				<th>아이디</th>			
				<td> <input type="text" name="id" maxlength="50"> </td>
			</tr>
			<tr>
				<th>비밀번호</th>			
				<td> <input type="password" name="pwd" maxlength="50"> </td>
			</tr>
		</table>
		<br>
		
		<input type="submit" value="로그인">
		<input type="button" value="회원가입" onclick="location.href='Register.jsp'"> 
		
		</form>
	</div>
</body>
</html>