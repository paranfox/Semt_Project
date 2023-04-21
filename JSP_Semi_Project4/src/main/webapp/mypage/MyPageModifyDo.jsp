<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPageModifyDO</title>
</head>
<body>


	<form method="post"
		action="<%=request.getContextPath()%>/modifyOk.do?id=${dto.getUser_id()}"
		enctype="multipart/form-data">

		<c:set var="dto" value="${userCont }" />

		<table border="1" width="400">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="user_id"
					value=${dto.getUser_id() } readonly></td>
			</tr>

			<tr>
				<th>이름</th>
				<td><input type="text" name="user_name"
					value=${dto.getUser_name() } readonly></td>
			</tr>

			<tr>
				<th>닉네임</th>
				<td><input type="text" name="user_nickname"
					value=${dto.getUser_nickname() }></td>
			</tr>

		
			<tr>
				<th>이메일</th>
				<td><input type="text" name="user_email"
					value=${dto.getUser_email() }></td>
			</tr>



			<tr>
				<th>핸드폰</th>
				<td><input type="text" name="user_phone"
					value=${dto.getUser_phone() }></td>
			</tr>

			<tr>
				<th>프로필사진</th>
				<td><input type="file" name="user_pic"
					value=${dto.getUser_pic() }></td>
			</tr>


			<tr>
				<th>제출</th>
				<td align="center"><input type="submit" value="수정">
					&nbsp;&nbsp;&nbsp; <input type="reset" value="다시작성"></td>

			</tr>

		</table>
	</form>

</body>
</html>