<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="module"
	src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule
	src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<style>
#container {
	margin-top: 400px;
	align-content: center;
	width: 70%;
	margin: 0 auto;
	position: relative;
	min-width: 700px;
}

#user_container {
	background-color: rgb(226, 226, 226);
	padding: 10px 5px 0px 5px;
	height: 230px;
	width: 100%;
	display: flex;
}

#user_con {
	display: flex;
	WIDTH: 100%;
	JUSTIFY-CONTENT: space-between;
}

#user_nickname {
	font-size: 1.6em;
}

#fol_part {
	padding: 0 0 0 0;
}

#mypageBtn {
	float: left;
	margin-top: 160px;
}

#uploadBtn {
	float: left;
	margin-top: 160px;
}

#follow_table {
	margin-top: 170px;
	text-align: center;
	font-size: .9em;
	height: 10px;
	width: 300px;
	/* border: 1px black solid; */
	float: right;
}

#music_cover {
	height: 200px;
}

#user_cover img {
	width: 200x;
	height: 200px;
	object-fit: cover;
	border-radius: 50%;
	box-shadow: inset 0 0 1px rgba(0, 0, 0, .1);
}

/* music list */
.music_content {
	height: 45px;
	display: flex;
	align-items: center;
	font-weight: 1000;
	padding: 0 0 4px 0;
	border-bottom: 1px solid rgb(214, 214, 214);
}

.music_content:hover {
	background-color: rgb(235, 235, 235);
}

.music_content img {
	margin-top: 10px;
	width: 40px;
	height: 40px;
	padding: 5px;
	object-fit: cover;
}

.music_title {
	margin-right: auto;
}

.music_like {
	margin-left: auto;
	color: rgb(77, 76, 76);
	font-size: .8em;
}

.music_count {
	color: rgb(77, 76, 76);
	font-size: .8em;
}

.music_like img {
	width: 11px;
	height: auto;
	opacity: .4;
	margin: 0;
	padding: 0;
}

.music_count img {
	width: 13px;
	height: auto;
	opacity: .4;
	margin: 0;
	padding: 0;
}

.music_count span {
	width: 13px;
	margin: 0;
	padding: 0;
}
</style>

</head>
<body>


	<jsp:include page="../test_main_top.jsp" />


	<div id="container">
		<c:set var="uservo" value="${userVO }" />

		<div id="user_container">
			<div id="user_cover">
				<img
					src="<%=request.getContextPath() %>/fileUpload/${uservo.getUser_pic() }">
			</div>
			<div id="user_con">
				<div id="fol_part">
					<div id="user_nickname">${uservo.getUser_nickname() }</div>
					<input id="mypageBtn" type="button"
						onclick="location.href='<%=request.getContextPath()%>/modify.do'"
						value="MYPAGE"> <input id="uploadBtn" type="button"
						onclick="location.href='<%=request.getContextPath()%>/upload_music.do'"
						value="UPLOAD">
				</div>
				<div id="table_part">
					<table id="follow_table">
						<tr>
							<td>FOLLOWERS</td>
							<td>FOLLOWING</td>
							<td>TRACKS</td>
						</tr>
						<tr>
							<td><a
								href="<%=request.getContextPath() %>/user_follower_list.do?user_id=${uservo.getUser_id() }">${followersCount }
							</a></td>
							<td><a
								href="<%=request.getContextPath() %>/user_following_list.do?user_id=${uservo.getUser_id() }">${followingCount }
							</a></td>
							<td><a href="#">${userTrackCount } </a></td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div id="music_list_container">
			<div class="music_content">
				<div class="music_cover">
					<img src="images.jpg" alt="">
				</div>
				<div class="text_cont"></div>
				<div class="music_author">작성자</div>
				&nbsp;
				<div>-</div>
				&nbsp;
				<div class="music_title">음악 제목</div>
				<div class="music_count">
					<img src="play_icon_134504.png"><span>&nbsp;777</span>
				</div>
			</div>
		</div>


	</div>







	<div class="main_con"></div>

	<div class="container mt-5">
		<div class="text-center">
			<hr class="w-75 bg-danger" align="center">
			<h3>MY List</h3>
			<hr class="w-75 bg-danger" align="center">
			<br>


			<c:set var="uservo" value="${userVO }" />
			<table align="center" border="1">
				<tr>
					<th>pic</th>
					<td><img
						src="<%=request.getContextPath() %>/	fileUpload/${uservo.getUser_pic() }"
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
					<td><input type="button"
						onclick="location.href='<%=request.getContextPath()%>/modify.do'"
						value="MYPAGE"> <input type="button"
						onclick="location.href='<%=request.getContextPath()%>/upload_music.do'"
						value="UPLOAD"></td>
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
						button.value = "follow+";
					} else if (res == 1) {
						button.value = "following!";
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