<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.*"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>UserList</title>

</head>
<body>
	<header> User register success </header>
	<p id=sect><%=request.getAttribute("greetings")%><br>
	<div>
		<%
		UserVO user = (UserVO) request.getAttribute("user");
		%>
		<table>
			<tr>
				<th>아이디</th>
				<th><%=user.getUser_id()%></th>

			</tr>
			<tr>
				<th>비밀번호</th>
				<th><%=user.getUser_pwd()%></th>

			</tr>
			<tr>
				<th>이름</th>
				<th><%=user.getUser_name()%></th>

			</tr>
			<tr>
				<th>닉네임</th>
				<th><%=user.getUser_nickname()%></th>
			</tr>
			<tr>
				<th>이메일</th>
				<th><%=user.getUser_email()%></th>
			</tr>
			<tr>
				<th>전화번호</th>
				<th><%=user.getUser_phone()%></th>
			</tr>

			<tr>
				<th>사진</th>
				<th><%=user.getUser_pic()%></th>
			</tr>
		</table>
	</div>
	<div>
		<p>
			<br> <a
				href="http://localhost:8787/JSP_Semi_Project/UserServlet?cmd=list"
				target="_self"> <strong>전체 회원 목록 보기 </strong></a>

		</p>
	</div>


</body>
</html>