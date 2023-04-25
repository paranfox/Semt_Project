<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
#content_container {
	margin: 0px 50px;
	margin-top: 100px;
}

#tab_container {
	display: flex;
	margin-top: 20px;
	/* border: 1px solid; */
}

.tab_con {
	padding: 10px 0;
	flex-grow: 1;
	text-align: center;
	width: 100%;
	height: 100%;
	border-bottom: 1px solid rgb(214, 214, 214);
	/* background-color: grey; */
}

.tab_con.active {
	color: red;
}

.tab_con:hover {
	border-bottom: 1px solid rgb(0, 0, 0);
	cursor: pointer;
}

#followers_container {
	margin: 40px 0px;
	display: flex;
	text-align: center;
	flex-wrap: wrap;
	justify-content: left;
	/* border: 1px brown solid; */
}

.fol_container {
	width: 180px;
	height: 220px;
	padding: 0px 15px;

	/* border: 1px solid; */
}

.fol_img img {
	width: 150px;
	height: 150px;
	object-fit: cover;
	border-radius: 50%;
	/* box-shadow: inset 0 0 1px rgba(0, 0, 0, .1); */
}

.fol_nickname a {
	text-decoration: none;
	color: black;
}

.fol_count {
	margin: 0px;
	padding: 0px;
	display: flex;
	/* border: 1px solid; */
	font-size: .8em;
}

.fol_count img {
	width: 12px;
	height: 13px;
	padding-left: 40px;
	padding-top: 2px;
	/* border: 1px solid; */
	opacity: .2;
}

.fol_count span {
	padding-left: 8px;
	text-decoration: none;
}

.fol_btn input {
	display: none;
	margin-left: 50px;
}

#followd_container {
	/* border: 1px solid; */
	display: flex;
}

#followd_container img {
	width: 120px;
	height: 120px;
	object-fit: cover;
	border-radius: 50%;
	box-shadow: inset 0 0 1px rgba(0, 0, 0, .1);
}

#followd_container span {
	font-weight: bold;
	font-size: 1.8em;
	padding-left: 20px;
}
</style>

</head>
<body>


	<jsp:include page="../test_main_top.jsp" />

	<div class="main_con"></div>

	<c:set var="bvo" value="${userVO }"></c:set>
	<c:set var="followerList" value="${followerList }"></c:set>

	<div id="content_container">

		<div id="followd_container">
			<img src="NationalGeographic_2572187_square.jpg"> 
			<span>FOLLOWERS OF ${bvo.getUser_nickname() }</span>
		</div>


		<div id="tab_container">
			<div class="tab_con">LIKES</div>
			<div class="tab_con">FOLLOWING</div>
			<div class="tab_con">HISTORY</div>
		</div>




		<div id="followers_container">
			<c:if test="${!empty followerList }">
			
				<c:forEach items="${followerList }" var="vo" varStatus="loop">
					<c:if test="${vo.getFollower_id() != sessionId }">
					
					<div id="fol_container_${loop.index}" class="fol_container" onmouseover="followcheck(${vo.getFollower_id() }, ${loop.index})" onmouseout="hidebutton(${loop.index})">
						<div class="fol_img"><img src="<%=request.getContextPath() %>/fileUpload/${vo.getUser_pic() }"></div>
						<div class="fol_nickname"><a href="<%=request.getContextPath() %>/user_main.do?user_id=${vo.getFollower_id() }">${vo.getUser_nickname() }</a></div>
						<div class="fol_count" id="followers_count">
							<a href="<%=request.getContextPath() %>/user_main.do?user_id=${vo.getFollower_id() }">
							<img src="<%=request.getContextPath() %>/fileUpload/group.png">
							</a>
							<a href="<%=request.getContextPath() %>/user_follower_list.do?user_id=${vo.getFollower_id() }">
							<span id="fol_count_${loop.index}">${vo.getFollowers_count() } FOLLOWER</span>
							</a>
						</div>
						<div class="fol_btn">
							<input type="button" class="follow_btn_check" id="follow_btn_${loop.index}"
						 	onclick="followUpDown(${vo.getFollower_id() }, ${loop.index})" 
						 	value="FOLLOW+">
						</div>
					</div>
					
					</c:if>
				</c:forEach>
			</c:if>
		</div>
		
		
	</div>
	
<script type="text/javascript">
function hidebutton(index) {
	
	button = document.getElementById("follow_btn_"+index);
	button.style.display = 'none';
	
}

function followcheck(user_id, index) {
	
	//alert(user_id);
	button = document.getElementById("follow_btn_"+index);
	button.style.display = 'block';
	
	$.ajax({
		// 팔로우여부에 따라 버튼 상태 바꾸기
		url : "user_follow_check.do",
		type : "post",
		data : {
			session_id : "${sessionId}", // 팔로우 받는 유저 (게시판)
			bbs_id : user_id // 팔로우 하는 유저 (현재 세션)
		},
		success : function(res) {
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
function followUpDown(user_id, index) {
	
	button = document.getElementById("follow_btn_"+index);

	$.ajax({
		// 팔로우여부에 따라 버튼 상태 + 팔로우 상태 바꾸기
		url : "user_follow_check.do",
		type : "post",
		data : {
			session_id : "${sessionId}", // 팔로우 받는 유저 (게시판)
			bbs_id : user_id // 팔로우 하는 유저 (현재 세션)
		},
		success : function(check) {
			$.ajax({
				url : "user_follow_up_down.do",
				type : "post",
				data : {
					status : check,
					session_id : "${sessionId}", // 팔로우 받는 유저 (게시판)
					bbs_id : user_id // 팔로우 하는 유저 (현재 세션)
				},
				success : function(res) {
					let check = res;
					if (res == 0) {
						button.value = "FOLLOW+";
					} else if (res == 1) {
						button.value = "FOLLOWING!";
					}
					$.ajax({
						url : "user_follower_count.do",
						type : "post",
						data : {
							bbs_id : user_id // 팔로우 하는 유저 (현재 세션)
						},
						success : function(res) {
							let count = res;
							let fol_count = document.getElementById("fol_count_"+index);
							fol_count.innerHTML = count+"FOLLOWER";
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


</script>

</body>
</html>