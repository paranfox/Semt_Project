<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
	<header>Create Your Account</header>
	
	<div>
		<form
			action="http://localhost:8989/JSP_Semi_Project/UserServlet?cmd=join"
			method="post">
			<fieldset>
				<legend>Personnel Information</legend>
				<ul>
					<li>아이디 : <input type="text" name="user_id" autofocus required
						placeholder="공백없이 입력하세요"></li>
					<li>비밀번호 : <input type="text" name="user_pwd" required
						placeholder="공백없이 입력하세요"></li>
					<li>이름 : <input type="text" name="user_name" required
						placeholder="공백없이 입력하세요"></li>
					<li>닉네임 : <input type="text" name="user_nickname" required
						placeholder="공백없이 입력하세요"></li>
					<li>이메일 : <input type="text" name="user_email" required
						placeholder="공백없이 입력하세요"></li>
					<li>전화번호 : <input type="text" name="user_phone"
						placeholder="공백없이 입력하세요"></li>
					<li>사진 : <input type="text" name="user_pic"
						placeholder="공백없이 입력하세요"></li>
				</ul>
			</fieldset>
			<br>
			<fieldset>
				<input type="submit" name="submit" value="보내기"> <input
					type="reset" name="reset" value="다시 작성">
			</fieldset>
		</form>
	</div>

</body>
</html>