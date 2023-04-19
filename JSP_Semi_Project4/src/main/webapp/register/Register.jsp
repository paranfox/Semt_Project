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


	<jsp:include page="../test_main_top.jsp" />

	<div class="main_con"></div>
	
	<div>
	<form action="<%=request.getContextPath()%>/result.do" method="post"
		enctype="multipart/form-data">

		<input type="hidden" id="email_certification" name="email_certification" value="0">

		<h1>4운드 클라우드</h1>
		
		<div class="total">
			<div class="id">
				<strong class="td_1">ID</strong>
				<div class="td_2">
					<input type="text" name="user_id" class="input_id"><br>
					<font id="checkId" size="2"></font>
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
					<input type="text" name="user_email" class="input_email">
					<button id="email_check_btn" onclick="sendEmail()">인증코드 전송</button>
					<br> <font id="checkEmail" size="2"></font>
				</div>
			</div>
			<br>

			<div class="td_2">
				<input type="text" name="email_code" class="email_code">
				<button type="button" onclick="checkCode()">인증코드 확인</button>
				<br> <font id="checkCode" size="2"></font>
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
					<input type="submit" value="Register">
				</div>
			</div>
		</div>
	</form>
	<br>
	<br>
	<br>
	<br>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script type="text/javascript">
	
		// 아이디 중복 검사
		$('.input_id').focusout(function() {
			let userId = $('.input_id').val();
			$.ajax({
				url : "userId_check.do",
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
					alert("서버요청실패1");
				}
			})
		})
		
		// 닉네임 중복 검사
		$('.input_nickname').focusout(function() {
			let userNickname = $('.input_nickname').val();
			$.ajax({
				url : "nickname_check.do",
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
					alert("서버요청실패2");
				}
			})
		})
	
		// 비밀번호 일치 확인
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

		
		// 인증 코드를 저장할 전역 변수
		let code;

		// 이메일 전송
		function sendEmail() {
			
			// 전송 버튼 클릭 후 재전송 버튼으로 바꾸기
		    const button = document.getElementById('email_check_btn');
		    button.innerText = '인증코드 재전송';
			
		    // 작성한 이메일
			let userEmail = $('.input_email').val();

			$.ajax({
				// db 이메일 유무 파악
				url : "email_check.do",
				type : "post",
				data : {
					userEmail : userEmail
				},
				success : function(res) {
					if (res == 0) {
					// 등록되지 않은 이메일 > 진행 가능
						$.ajax({
							// 이메일 보내기
							url : "register_send_email.do",
							type : "post",
							data : {
								// input 이메일 보내기
								userEmail : userEmail
							},
							success : function(result) {
								code = result; // 전역 변수에 코드 저장. => 코드 비교
								// alert(code);
								$("#checkEmail").html('인증코드가 전송되었습니다. 이메일을 확인하세요.');
								$("#checkEmail").attr('color', 'green');
							},
							error : function() {
								alert("이메일 주소를 확인하세요.");
							}	
						});
					} else if (res == 1) {
						// 등록된 이메일 > 진행 불가능
						alert("이미 가입된 이메일입니다. 다른 이메일을 입력하세요.");
					}

				},
				error : function() {
					alert("이메일 체크 서버 요청 실패");
				}
			});
		}
	
		// 메일 인증 코드 비교
		function checkCode() {
			
			
			const email_certification = document.getElementById('email_certification');
			let certification;

			let email_code = $(".email_code").val();
			let email_code_trim = email_code.trim();
			code_trim = code.trim();
			//console.log(typeof code);
			//console.log(typeof email_code_trim);

			if (!(email_code_trim === "") && !(code_trim === "")) {
				if (email_code_trim === code_trim) {
					$("#checkCode").html('인증 완료');
					$("#checkCode").attr('color', 'green');

					certification = 1;
					alert("인증결과" + certification);
					email_certification.value = certification;
				} else {
					$("#checkCode").html('인증 코드를 다시 확인하세요.');
					$("#checkCode").attr('color', 'red');

				}
			}

		}

	</script>


</body>
</html>