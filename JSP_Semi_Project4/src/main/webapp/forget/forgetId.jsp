<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	<div>
		<form action="<%=request.getContextPath() %>/forget_id_check.do" method="post">
			<table>
				<tr>
					<th>NAME</th>
					<td><input name="name" placeholder="이름을 입력하세요"></td>
				</tr>
				<tr>
					<th>email</th>
					<td><input name="email" placeholder="이메일 입력하세요"></td>
				</tr>
				<tr>
					<td><input type="submit" value="다음"></td>
				</tr>
			</table>
		</form>
		</div>


</body>
</html>