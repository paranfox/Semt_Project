<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery.js"></script>


<!-- 카카오 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
	Kakao.init('813cd237c40399ffe801d1e722e6e738');
	Kakao.isInitialized();
</script>

<!-- 구글 -->
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      

<!-- 네이버 -->
<script
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>


<title>로그인</title>
<link rel="stylesheet" href="login.css">
</head>
<body>
	<h3>로그인 화면</h3>


	<div>
		<a onclick="loginKakao();"> 
			<img src="img/kakao_login_medium_wide.png" alt="카카오 로그인"></img>
		</a>
	</div>

	<div id="buttonDiv"></div> 
	<!-- <div>
		<a onclick="loginGoogle();"> 
			<img src="img/btn_google_signin_light_pressed_web.png" alt="카카오 로그인"></img>
		</a>
	</div> -->

	<div>
		<form action="login_check.do" method="post">
			<table>
				<tr>
					<th>ID</th>
					<td><input name="id"></td>
				</tr>
				<tr>
					<th>PWD</th>
					<td><input name="pwd"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인">
						<input	type="button" value="회원가입" onclick="location.href='RegisterChoice.jsp'">
					</td>
				</tr>

			</table>
		</form>
		<input type="button" value="내 정보" onclick="location.href='main.jsp'">
	</div>


</body>

<script type='text/javascript'>

	function loginKakao() {
		//1. 로그인 시도
		Kakao.Auth.login({
			success : function(authObj) {
								/* var accessToken = Kakao.Auth.getAccessToken();	// 액세스 토큰 할당
								Kakao.Auth.setAccessToken(accessToken);	// 토큰 등록 
								alert(accessToken);*/

				//2. 로그인 성공시, API 호출
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(res) {						
								
								const kakao_id = res.id;
								/* const kakao_email = res.kakao_account.email;
								const kakao_nickname = res.properties.nickname;
								
								
								alert(id);
								alert(email); */
								
								<%-- location.href = "<%=request.getContextPath()%>/login_check.do?id="+id+"&pwd="+id; --%>
								// post 방식으로 값 전달..
								const form = document.createElement('form');        // form 태그 생성 
								let objs = document.createElement('input');             // 값을 넣을 input 생성 
								objs.setAttribute('type', 'hidden');                                  // 값의 type
								objs.setAttribute('name', "id");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
								objs.setAttribute('value', kakao_id);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
								form.appendChild(objs);
								let objs2 = document.createElement('input');             // 값을 넣을 input 생성 
								objs2.setAttribute('type', 'hidden');                                  // 값의 type
								objs2.setAttribute('name', "pwd");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
								objs2.setAttribute('value', kakao_id);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
								form.appendChild(objs2);
								form.setAttribute('method', 'post');                            //get,post 가능
								form.setAttribute('action', "login_check.do");         // 호출할 url : 인증 성공시 서버에서 받아서 셋팅 
								document.body.appendChild(form);
								form.submit();
					}
				})
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	};
	
	function handleCredentialResponse(response) {
    	const responsePayload = parseJwt(response.credential);
    	console.log("ID: " + responsePayload.sub);
        console.log('Full Name: ' + responsePayload.name);
        console.log('Given Name: ' + responsePayload.given_name);
        console.log('Family Name: ' + responsePayload.family_name);
        console.log("Image URL: " + responsePayload.picture);
        console.log("Email: " + responsePayload.email);
        
        const google_id = responsePayload.sub;
        
        const form = document.createElement('form');        // form 태그 생성 
		let objs = document.createElement('input');             // 값을 넣을 input 생성 
		objs.setAttribute('type', 'hidden');                                  // 값의 type
		objs.setAttribute('name', "id");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
		objs.setAttribute('value', google_id);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
		form.appendChild(objs);
		let objs2 = document.createElement('input');             // 값을 넣을 input 생성 
		objs2.setAttribute('type', 'hidden');                                  // 값의 type
		objs2.setAttribute('name', "pwd");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
		objs2.setAttribute('value', google_id);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
		form.appendChild(objs2);
		form.setAttribute('method', 'post');                            //get,post 가능
		form.setAttribute('action', "login_check.do");      	   // 호출할 url : 인증 성공시 서버에서 받아서 셋팅 
		document.body.appendChild(form);
		form.submit();
        
        
    }
	
    function parseJwt (token) {
        var base64Url = token.split('.')[1];
        var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));

        return JSON.parse(jsonPayload);
    };
    
    
    window.onload = function () {
      google.accounts.id.initialize({
        client_id: "1041087198718-inbdu2ft7ri1j36l72g3sojpumk19tea.apps.googleusercontent.com",
        callback: handleCredentialResponse
      });
      google.accounts.id.renderButton(
        document.getElementById("buttonDiv"),
        { theme: "outline", size: "large" }  // customization attributes
      );
      google.accounts.id.prompt(); // also display the One Tap dialog
    }
    
    
    
    
</script>
</html>