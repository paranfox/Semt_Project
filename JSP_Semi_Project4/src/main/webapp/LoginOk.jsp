<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String result = (String)session.getAttribute("member");
	
	if(result == null){
		response.sendRedirect("LogInForm.jsp");
	}
	
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2><%=name %> 회원님 환영합니다.</h2>
	<hr>

</body>
</html>