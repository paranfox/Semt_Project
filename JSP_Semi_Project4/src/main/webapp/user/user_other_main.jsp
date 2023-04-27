<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Add Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
td {
	text-align: "center";
}
</style>
</head>
<body>


	<jsp:include page="../test_main_top.jsp" />

	<div class="main_con"></div>

	<div class="container mt-5">
		<div class="text-center">
			<hr class="w-75 bg-danger" align="center">
			<h3>Music List</h3>
			<hr class="w-75 bg-danger" align="center">
			<br>


			<c:set var="uservo" value="${userVO }" />
			<table align="center" border="1">
				<tr>
					<th>pic</th>
					<td><img
						src="<%=request.getContextPath() %>/fileUpload/${uservo.getUser_pic() }?ver=1"
						width="60" height="60"></td>
				</tr>
				<tr>
					<th>nickname</th>
					<td>${uservo.getUser_nickname() }</td>
				</tr>
				<tr>
					<th>follower</th>
					<td id="followers_count"><a
						href="<%=request.getContextPath() %>/user_follower_list.do?user_id=${uservo.getUser_id() }">
							${followersCount } </a></td>
				</tr>
				<tr>
					<th>following</th>
					<td><a
						href="<%=request.getContextPath() %>/user_following_list.do?user_id=${uservo.getUser_id() }">
							${followingCount } </a></td>
				</tr>
				<tr>
					<th>TRACKS</th>
					<td><a href="#">${userTrackCount } </a></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" id="follow_btn"
						onclick="followUpDown()" value="follow+"></td>
				</tr>
			</table>

			<!-- Add Bootstrap table classes -->
			<table class="table table-bordered table-striped w-75 mx-auto">
				<thead class="bg-warning">
					<tr>
						<th>앨범 제목</th>
						<th>앨범 이미지</th>
						<th>music_mp3(파일명)</th>
						<th>앨범 설명(contents)</th>
						<th>작성자</th>
						<th>좋아요+</th>
						<th>재생수</th>
						<th>상제 정보 들어가기</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="list" value="${userMusicList }" />
					<c:if test="${!empty list }">
						<c:forEach items="${list }" var="vo">
							<tr>
								<td>${vo.getMusic_title() }</td>
								<td><img
									src="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }"
									width="60" height="60"></td>
								<td>${vo.getMusic_mp3() }</td>
								<td>${vo.getMusic_contents() }</td>
								<td><a
									href="<%=request.getContextPath() %>/user_main.do?user_id=${vo.getUser_id() }">${vo.getUser_nickname() }</a></td>
								<td>${vo.getMusic_likecnt() }</td>
								<td>${vo.getMusic_playcnt() }</td>
								<td><a
									href="<%=request.getContextPath() %>/user_music_content.do?id=${vo.getMusic_id() }">들어가기</a></td>
						</c:forEach>

					</c:if>

					<c:if test="${empty list }">
						<tr>
							<td colspan="10" class="text-center">
								<h3>앨범 리스트가 없습니다.</h3>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Add Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		window.onload = function() {
			let button = document.getElementById("follow_btn");
			//alert(button.value);
			//let followed_id = "${sessionId}";

			$.ajax({
				// 팔로우여부에 따라 버튼 상태 바꾸기
				url : "user_follow_check.do",
				type : "post",
				data : {
					session_id : "${sessionId}", // 팔로우 받는 유저 (게시판)
					bbs_id : "${userVO.getUser_id() }" // 팔로우 하는 유저 (현재 세션)
				},
				success : function(res) {
					// let check = res;
					// alert(check);
					if (res == 0) {
						button.value = "FOLLOW+";
					} else if (res == 1) {
						button.value = "FOLLOWING!";
					}
				},
				error : function() {
					alert("팔로우 체크 서버 요청 실패");
				}
			});

		}

		// 팔로우 버튼 눌러서 팔로우, 팔로우 취소하기
		function followUpDown() {

			let button = document.getElementById("follow_btn");

			$.ajax({
				// 팔로우여부에 따라 버튼 상태 + 팔로우 상태 바꾸기
				url : "user_follow_check.do",
				type : "post",
				data : {
					session_id : "${sessionId}", // 팔로우 받는 유저 (게시판)
					bbs_id : "${userVO.getUser_id() }" // 팔로우 하는 유저 (현재 세션)
				},
				success : function(check) {
					$.ajax({
						url : "user_follow_up_down.do",
						type : "post",
						data : {
							status : check,
							session_id : "${sessionId}", // 팔로우 받는 유저 (게시판)
							bbs_id : "${userVO.getUser_id() }" // 팔로우 하는 유저 (현재 세션)
						},
						success : function(res) {
							let check = res;
							//alert(check);
							if (res == 0) {
								button.value = "follow+";
							} else if (res == 1) {
								button.value = "following!";
							}
							$.ajax({
								url : "user_follower_count.do",
								type : "post",
								data : {
									bbs_id : "${userVO.getUser_id() }" // 팔로우 하는 유저 (현재 세션)
								},
								success : function(res) {
									let count = res;
									//alert(count);
									let followerCountElement = document
											.getElementById("followers_count");
									followerCountElement.innerHTML = count;
								},
								error : function() {
									alert("팔로우 카운트 실패")
								}
							})

						},
						error : function() {
							alert("팔로우 실패")
						}
					});

				},
				error : function() {
					alert("팔로우 체크 서버 요청 실패");
				}
			});

		}

		// 팔로우 팔로워 수
	</script>
</body>
</html>