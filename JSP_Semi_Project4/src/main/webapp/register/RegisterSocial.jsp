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


	<jsp:include page="../test_main_top.jsp" />

	<div class="main_con"></div>
	
	<header>Create Your Account(Social)</header>

	<div>
		<form action="<%=request.getContextPath()%>/result.do" method="post" enctype="multipart/form-data">
			
			<input type="hidden" id="email_certification" name="emailCertification" value="1">
			<input type="hidden" name="user_id" value=${param.social_id }>
			<input type="hidden" name="user_pwd" value=${param.social_pwd }>
			
			<div class="total">

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
					<input type="text" name="user_nickname" class="input_nickname" value="${param.social_nickname }">
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
					<input type="text" name="user_email" class="input_email" value="${param.social_email }">
					<font id="checkEmail" size="2"></font>
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
	</div>

	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script type="text/javascript">
		
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
	
	
	</script>

</body>
</html>


