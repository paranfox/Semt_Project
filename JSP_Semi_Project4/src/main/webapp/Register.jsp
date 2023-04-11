<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- action=request.getContextPath()h() %>/login_check.do" -->
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link rel="stylesheet" href="css/Register.css">
<link rel="stylesheet" href="css/Register_2.css">

</head>
<body>
	<form action="<%=request.getContextPath()%>/result.do" method="post"
		enctype="multipart/form-data">

		<h1>4운드 클라우드</h1>
		<div class="total">
			<div class="id">
				<strong class="td_1">ID</strong>
				<div class="td_2">
					<input type="text" name="user_id" class="input_id"><br><font
						id="checkId" size="2"></font>
				</div>
			</div>

			<br> <br>

			<div class="pw">
				<strong class="td_1">PW</strong>
				<div class="td_2">
					<input type="password" name="user_pwd" class="pw" id="password_1">
				</div>
			</div>

			<br> <br>

			<div class="pw_check">
				<strong class="td_1">PW 확인</strong>
				<div class="td_2" colspan="2">
					<input type="password" name="user_pwd2" class="pw" id="password_2">
					<font id="checkPw" size="2"></font>
				</div>
			</div>

			<br> <br>

			<div class="name">
				<strong class="td_1">이름</strong>
				<div class="td_2">
					<input type="text" name="user_name">
				</div>
			</div>

			<br> <br>

			<div class="nickName">
				<strong class="td_1">닉네임</strong>
				<div class="td_2">
					<input type="text" name="user_nickname" class="input_nickname">
					<font id="checkNickname" size="2"></font>
				</div>
			</div>

			<br> <br>

			<div class="phone">
				<strong class="td_1">전화번호</strong>
				<div class="td_2">
					<input type="text" name="user_phone">
				</div>
			</div>

			<br> <br>

			<div class="email">
				<strong class="td_1">이메일</strong>
				<div class="td_2">
					<input type="text" name="user_email">
				</div>
			</div>

			<br> <br>

			<div class="pic">
				<strong class="td_1">프로필 사진</strong>
				<div class="td_2">
					<input type="file" name="user_pic">
				</div>
			</div>

			<br> <br>

			<div class="register">
				<div colspan="2" align="center">
					<input type="submit" value="Register" >
				</div>
			</div>
		</div>
	</form>
	<br><br><br><br> 

	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script type="text/javascript">
		$('.input_id').focusout(function() {
			let userId = $('.input_id').val();
			$.ajax({
				url : "ajax.IdCheckService",
				type : "post",
				data : {
					userId : userId
				},
				dataType : 'json',
				success : function(result) {
					if (result == 0) {
						$("#checkId").html('사용할 수 없는 아이디입니다.');
						$("#checkId").attr('color', 'red');
					} else {
						$("#checkId").html('사용할 수 있는 아이디입니다.');
						$("#checkId").attr('color', 'green');
					}
				},
				error : function() {
					alert("서버요청실패");
				}
			})
		})

		$('.input_nickname').focusout(function() {
			let userNickname = $('.input_nickname').val();
			$.ajax({
				url : "NicknameCheckService",
				type : "post",
				data : {
					userNickname : userNickname
				},
				dataType : 'json',
				success : function(result) {
					if (result == 0) {
						$("#checkNickname").html('사용할 수 없는 닉네임 입니다.');
						$("#checkNickname").attr('color', 'red');
					} else {
						$("#checkNickname").html('사용할 수 있는 닉네임 입니다.');
						$("#checkNickname").attr('color', 'green');
					}
				},
				error : function() {
					alert("서버요청실패");
				}
			})
		})

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