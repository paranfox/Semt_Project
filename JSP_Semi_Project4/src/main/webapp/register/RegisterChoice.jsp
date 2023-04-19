<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>Register</title>
</head>
<body>


	<jsp:include page="../test_main_top.jsp" />

	<div class="main_con"></div>
	
	<h2>Create Your Account</h2>

	<div>
		<a onclick="registerKakao();" style="cursor: pointer"> <img
				src="../img/kakao_login_medium_wide.png" alt="카카오 로그인"></img>
		</a>
		
		<div id="buttonDiv"></div> 
		
		<br>
		
		<button class="api-btn" onclick="location.href='Register.jsp'">4운드 회원가입</button>
	</div>

</body>



<script type='text/javascript'>

	function registerKakao() {
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
								
								const id = res.id;
								const email = res.kakao_account.email;
								const nickname = res.properties.nickname;
								const nickname_endcoded = encodeURIComponent(nickname);
								
								//alert(id);
								//alert(nickname);
								//alert(email);

								// post 방식으로 값 전달..
								const form = document.createElement('form');        // form 태그 생성 
								let objs = document.createElement('input');             // 값을 넣을 input 생성 
								objs.setAttribute('type', 'hidden');                                  // 값의 type
								objs.setAttribute('name', "social_id");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
								objs.setAttribute('value', id);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
								form.appendChild(objs);
								let objs2 = document.createElement('input');             // 값을 넣을 input 생성 
								objs2.setAttribute('type', 'hidden');                                  // 값의 type
								objs2.setAttribute('name', "social_pwd");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
								objs2.setAttribute('value', id);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
								form.appendChild(objs2);
								let objs3 = document.createElement('input');             // 값을 넣을 input 생성 
								objs3.setAttribute('type', 'hidden');                                  // 값의 type
								objs3.setAttribute('name', "social_nickname");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
								objs3.setAttribute('value', nickname);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
								form.appendChild(objs3);
								let objs4 = document.createElement('input');             // 값을 넣을 input 생성 
								objs4.setAttribute('type', 'hidden');                                  // 값의 type
								objs4.setAttribute('name', "social_email");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
								objs4.setAttribute('value', email);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
								form.appendChild(objs4);
								form.setAttribute('method', 'post');                            //get,post 가능
								form.setAttribute('action', "register_social_email_check.do");         // 호출할 url : 인증 성공시 서버에서 받아서 셋팅 
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
	
	

	// 구글로그인
	function handleCredentialResponse(response) {
    	const responsePayload = parseJwt(response.credential);
    	console.log("ID: " + responsePayload.sub);
        console.log('Full Name: ' + responsePayload.name);
        console.log('Given Name: ' + responsePayload.given_name);
        console.log('Family Name: ' + responsePayload.family_name);
        console.log("Image URL: " + responsePayload.picture);
        console.log("Email: " + responsePayload.email);
        
        const id = responsePayload.sub;
        const email = responsePayload.email;
        const nickname = responsePayload.given_name;
        const nickname_endcoded = encodeURIComponent(nickname);
        
		// post 방식으로 값 전달..
		const form = document.createElement('form');        // form 태그 생성 
		let objs = document.createElement('input');             // 값을 넣을 input 생성 
		objs.setAttribute('type', 'hidden');                                  // 값의 type
		objs.setAttribute('name', "social_id");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
		objs.setAttribute('value', id);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
		form.appendChild(objs);
		let objs2 = document.createElement('input');             // 값을 넣을 input 생성 
		objs2.setAttribute('type', 'hidden');                                  // 값의 type
		objs2.setAttribute('name', "social_pwd");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
		objs2.setAttribute('value', id);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
		form.appendChild(objs2);
		let objs3 = document.createElement('input');             // 값을 넣을 input 생성 
		objs3.setAttribute('type', 'hidden');                                  // 값의 type
		objs3.setAttribute('name', "social_nickname");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
		objs3.setAttribute('value', nickname);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
		form.appendChild(objs3);
		let objs4 = document.createElement('input');             // 값을 넣을 input 생성 
		objs4.setAttribute('type', 'hidden');                                  // 값의 type
		objs4.setAttribute('name', "social_email");                  // 값을 담을 변수 이름 : 인증 성공 시 서버에서 받아서 셋팅 
		objs4.setAttribute('value', email);          // 값 : 인증 성공시 서버에서 받아서 셋팅 
		form.appendChild(objs4);
		form.setAttribute('method', 'post');                            //get,post 가능
		form.setAttribute('action', "register_social_email_check.do");         // 호출할 url : 인증 성공시 서버에서 받아서 셋팅 
		document.body.appendChild(form);
		form.submit();
        
    }
	
	// 구글 정보 변환
    function parseJwt (token) {
        var base64Url = token.split('.')[1];
        var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));

        return JSON.parse(jsonPayload);
    };
    
    // 구글 버튼 및 구글 제공 정보 입력
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