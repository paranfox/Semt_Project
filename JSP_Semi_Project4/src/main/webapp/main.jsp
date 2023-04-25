<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>4undCLOUD</title>
<link rel="stylesheet" href="css/main.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%-- 	<jsp:include page="test_main_top.jsp"/> --%>

	<header id="top">
		<div class="top">
			<ul>
				<li class="home"><a href="main.jsp">4undCLOUD</a></li>
				<li class="feed"><a href="http://www._____.com/About">FEED</a></li>
				<li class="library"><a href="best_like_list.do">LIBRARY</a></li>

				<li class="search_top">
					<form class="search"
						action="<%=request.getContextPath()%>/search.do" method="post">
						<select name="find">
							<option value="All">전체</option>
							<option value="name">닉네임</option>
							<option value="title">앨범명</option>
							<option value="content">내용</option>
						</select> <input class="search-txt" type="text" name="keyword" placeholder="검색어를 입력해 주세요">
						<button class="search-btn" type="submit">&#128269;</button>
					</form>
				</li>

				<c:set value="${user }" var="list" />
				<c:set value="${sessionUserVO }" var="vo" />

				<%-- 로그인되지 않았을 때 --%>
				<c:if test="${empty vo }">
					<li class="login"><a href="login/login.jsp">LOGIN</a></li>
					<li class="account"><a href="register/RegisterChoice.jsp">CREATE ACCOUNT</a></li>
					<li class="upload"><a href="musicBbs/uploadsample.jsp">UPLOAD</a></li>
				</c:if>

				<%-- 로그인되었을 때 --%>
				<c:if test="${!empty vo }">
				
					<li class="upload"><a href="musicBbs/uploadsample.jsp">UPLOAD</a></li>
					
					<iframe id="contentIframe" frameborder="0" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;"></iframe>
					<iframe id="contentIframe" frameborder="0" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;"></iframe>
					<li class="nickname">
						<a>${vo.getUser_nickname() }님 환영합니다</a>
						<ul class="profile_inner_1">
							<li><a href="musicBbs/uploadsample.jsp">PROFILE</a></li>
							
							<%-- <li><a href="<%=request.getContextPath()%>/my_music_list.do?id=${vo.getUser_id() }">FOLLOWING</a></li> --%>
							<li><a href="<%=request.getContextPath()%>/my_music_list.do?id=${vo.getUser_id() }">MY UPLOADED ALBUM</a></li>
							<li><a href="<%=request.getContextPath()%>/like_list.do">LIKES PLAYLIST</a></li>
							<li><a href="#" class="goToContentBtn" onclick="loadIframe(this);">SHOW ALL ALBUM</a></li>
							<li><a href="<%=request.getContextPath()%>/user_music_list.do">SHOW ALL ALBUM</a></li>
							<li><a href="<%=request.getContextPath()%>/user_myplaylist_show.do">MY<br>플레이리스트</a></li>
							<%-- <li><a href="<%=request.getContextPath()%>/user_myplaylist_show.do">MY<br>플레이리스트</a></li> --%>
							<!-- <li><a href="#" class="goToContentBtn" onclick="loadMframe(this);">PLAYED ALBUM HISTORY</a></li> -->
							<li><a href="<%=request.getContextPath()%>/show_played_music.do?id=${vo.getUser_id() }">PLAYED ALBUM HISTORY</a></li>						
						</ul>
					</li>
					<li class="settings">
					  <a class="settings-link" href="#"><ion-icon class="settings-outline" name="settings-outline"></ion-icon></a>
					  <ul class="profile_inner_2">
					    <li><a href="<%=request.getContextPath()%>/my_page.do?num=${vo.getUser_id() }">마이페이지</a></li>
					    <li><a href="<%=request.getContextPath()%>/logout_check.do">로그아웃</a></li>
					  </ul>
					</li> 
				</c:if>
			</ul>
		</div>
	</header>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div id="content"></div>
	<div class="slideshow-container">


		<div class="mySlides fade">
			<a href="http://www._____.com/slideshow-container">
				<div class="genre">발라드</div>
				<div class="singer">가수</div> <img class="imgs" src="img/img2.png">
				<img class="pic" src="img/pic_1.png">
			</a>
		</div>

		<div class="mySlides fade">

			<a href="http://www._____.com/slideshow-container">

				<div class="genre">발라드</div>
				<div class="singer">가수</div> <img class="imgs" src="img/img3.png">
				<img class="pic" src="img/pic_1.png">

			</a>

		</div>

		<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next"
			onclick="plusSlides(1)">&#10095;</a>

	</div>

	<br>

	<div style="text-align: center">
		<span class="dot" onclick="currentSlide(1)"></span> <span class="dot"
			onclick="currentSlide(2)"></span> <span class="dot"
			onclick="currentSlide(3)"></span>
	</div>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
<a href="<%=request.getContextPath() %>/music_list_sample.do">음악 리스트 로 가는 버튼 아직미완성</a>

	<div class="music-player-container">
		<jsp:include page="mp3Player.jsp" />
	</div>

<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

<script type="text/javascript">
	var slideIndex = 1;
	showSlides(slideIndex);

	function plusSlides(n) {
		showSlides(slideIndex += n);
	}

	function currentSlide(n) {
		showSlides(slideIndex = n);
	}
	function showSlides(n) {
		var i;
		var slides = document.getElementsByClassName("mySlides");
		var dots = document.getElementsByClassName("dot");
		if (n > slides.length) {

			slideIndex = 1

		}
		if (n < 1) {

			slideIndex = slides.length
		}
		for (i = 0; i < slides.length; i++) {
			slides[i].style.display = "none";
		}
		for (i = 0; i < dots.length; i++) {
			dots[i].className = dots[i].className.replace(" active", "");
		}
		slides[slideIndex - 1].style.display = "block";
		dots[slideIndex - 1].className += " active";
	}

	$(document).ready(function() {
		loadMusicList();
	});

	function loadMusicList() {
		$.ajax({
			url : "music_list.jsp",
			type : "GET",
			success : function(data) {
				$("#content").html(data);
			},
			error : function(xhr, status, error) {
				console.error("Error loading music list:", error);
			}
		});
	}

	   function loadIframe(link) {
	       const iframe = document.getElementById("contentIframe");
	       if (iframe.style.visibility === "hidden") {
	           iframe.style.visibility = "visible";
	       } else {
	           iframe.src = "<%=request.getContextPath()%>/user_music_list.do";
				iframe.style.display = "block";
			}
		}
	   
	   function loadMframe(link) {
		   const iframe = document.getElementById("contentIframe");
		   if (iframe.style.visibility === "hidden") {
		       iframe.style.visibility = "visible";
		   } else {
		       const sessionId = '<%= session.getId() %>'; // 세션 아이디를 받아옵니다.
		       iframe.src = "<%=request.getContextPath()%>/show_played_music.do?sessionId=" + sessionId;
		       iframe.style.display = "block";
		   }
		}
	   
</script>
</html>