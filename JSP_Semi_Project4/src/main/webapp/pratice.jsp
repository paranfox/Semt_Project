<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
<script type="text/javascript">

	$.ajax({
		type : "POST",
		url : "/save_played_music.do", // 서버에 데이터를 전송할 URL
		data : {
			user_id : "YOUR_USER_ID", // 현재 사용자 ID (올바른 값으로 교체해야 함)
			music_id : "YOUR_MUSIC_ID" // 현재 재생 중인 음악 ID (올바른 값으로 교체해야 함)
		},
		success : function(response) {
			console.log("재생 정보 저장 성공");
		},
		error : function(xhr, status, error) {
			console.error("재생 정보 저장 실패: " + error);
		}
	});
</script>
</html>