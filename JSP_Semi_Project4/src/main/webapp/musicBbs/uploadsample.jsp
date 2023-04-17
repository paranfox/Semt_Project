<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>넣은 음원의 추가적인 정보 등록</title>
<link rel="stylesheet" href="css/upload1.css">
</head>
<body>

	<div align="center">
		<hr width="50%" color="marmoon">
		<h3>업로드 파일 폼 페이지</h3>
		<hr width="50%" color="marmoon">
		<br>
	</div>

	<form action="<%=request.getContextPath()%>/user_file.do" method="post"
		enctype="multipart/form-data">
		
		<input type="hidden" name ="user_id" value=${sessionId }>
		<input type="hidden" name ="user_nickname" value=${sessionUserNickName }>
		<div class="wrapper">
			<div class="content">
				<h3>파일을 넣어주세요</h3>
				<div class="file">
					<label for="file">음원파일</label> <input type="file" id="file"
						name="music_mp3"> <br>
					<br>
					<table>
						<tr>
							<td>앨범 이름</td>
							<td><input type="text" name="music_id" class="input_id">
							</td>
						</tr>

						<tr>
							<td>앨범 사진</td>
							<td><label for="music_pic">앨범사진</label> <input
								id="music_pic" type="file" name="music_pic"></td>
						</tr>

						<tr>
							<td>음원 제목</td>
							<td><input type="text" name="music_title"></td>
						</tr>

						<tr>
							<td>음원 설명</td>
							<td><textarea rows="7" cols="25" name="music_contents"></textarea>
							</td>
						</tr>

						<tr>
							<td colspan="2" align="center"><input type="submit"
								value="음원 등록"></td>
						</tr>

					</table>
				</div>

			</div>
		</div>

	</form>

</body>
</html>