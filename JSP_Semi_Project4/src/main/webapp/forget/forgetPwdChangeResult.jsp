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
	

	<h3>비밀번호 찾기</h3>

	<div>
		<form action="<%=request.getContextPath()%>/forget_pwd_change.do"
			method="post">
			<input type="hidden" name="id" value="<%=request.getAttribute("id") %>">

			<div class="pw">
				<strong class="td_1">새 비밀번호</strong>
				<div class="td_2">
					<input type="password" name="user_pwd" class="pw" id="password_1">
				</div>
			</div>

			<br> <br>

			<div class="pw_check">
				<strong class="td_1">새 비밀번호 확인</strong>
				<div class="td_2" colspan="2">
					<input type="password" name="user_pwd2" class="pw" id="password_2">
					<font id="checkPw" size="2"></font>
				</div>
			</div>
			<br> <br>
			
			<input type="submit" value="확인">
			<input type="reset" value="다시작성">
		</form>
	</div>


	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script type="text/javascript">
		$('.pw').keyup(function() {
			let pass1 = $("#password_1").val();
			let pass2 = $("#password_2").val();

			if (pass1 != "" || pass2 != "") {
				if (pass1 == pass2) {
					$("#checkPw").html('비밀번호가 일치합니다.');
					$("#checkPw").attr('color', 'green');
				} else if (pass1 != pass2) {
					$("#checkPw").html('비밀번호가 불일치 합니다.');
					$("#checkPw").attr('color', 'red');
				}
			}
		})
	</script>
</body>
</html>