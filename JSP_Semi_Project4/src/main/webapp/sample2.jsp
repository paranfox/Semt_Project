<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap JS 파일 및 종속성 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>앨범 List</title>
<!-- Add Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">

<meta charset="UTF-8">
</head>
<body>
	<c:set value="${user_likelist }" var="list" />


	<table border="1" cellspacing="0" width="400">
		<tr>
			<th colspan="6">가장 많이 들어 본 노래</th>
		</tr>
		<c:forEach items="${list }" var="vo">
			<tr>
				<td>${vo.getMusic_lank() }<input type="hidden"
					value="${vo.getMusic_lank() }" name="music_lank" id="music_lank">
				</td>
				<td>${vo.getMusic_title() }</td>
				<td>노래제목</td>
				<td><img width="50px" height="50px"
				name="music_pic"	src="<%=request.getContextPath()%>/fileUpload/${vo.getMusic_pic() }">
				</td>

				<td>가수</td>
				<td><button type="button" class="btn btn-primary"
						data-bs-toggle="modal" data-bs-target="#exampleModal" id="model">:</button>
				</td>
			</tr>
			<input type="hidden" id="music_id" value="${vo.getMusic_id() }"
				name="music_id">
		</c:forEach>
	</table>
	<form action="<%=request.getContextPath()%>/user_myplaylistok.do"
		method="post" enctype="multipart/form-data">

		<!-- Modal -->

		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">내가 만들 플레이
							리스트</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>플레이리스트 제목</p>
						<input type="text" name="my_play_listname"> <br>
						<hr>

						<img width="50px" height="50px"
							src="<%=request.getContextPath()%>/fileUpload/${music_pic }"> <input
							type="text" readonly="readonly" class="music_mame">
						<p></p>
						<br>
						<hr>









					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">저장</button>
					</div>
				</div>
			</div>
		</div>

	</form>
	<script type="text/javascript">
	$(document).ready(function() {
		var music_lank = $('.modal').eq(2).find('input[name="music_lank"]').val();
		if(music_lank == 3) {
		  $('#model').on('click', function() {
			  
		    var musicId = $('.modal').eq(2).find('input[name="music_id"]').val(); // 3번째 vo 객체의 music_id 값 가져오기
		    var music_mame = $('.modal').eq(2).find('input[name="music_mame"]').val();
		    var music_pic = $('.modal').eq(2).find('input[name="music_pic"]').val();
		   
		    
		    document.getElementID("music_mame").value = music_mame;
		    document.getElementID("music_pic") = music_pic;
		    
		    $('input[name="music_id"]').val(musicId); // music_id input 요소의 value 속성 값으로 musicId 할당
		  });
		}
		  
	});
		  
	
	
	
	</script>

</body>
</html>