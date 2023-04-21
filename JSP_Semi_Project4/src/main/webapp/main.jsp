<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%   
     session.setMaxInactiveInterval(18000);                                                
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>main</title>

<link rel="stylesheet" href="css/main.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>

<body>

	<header id="top">
		<div class="top">
			<ul>
				<li class="home"><a href="http://www._____.com">4운드 클라우드</a></li>
				<li class="feed"><a href="http://www._____.com/About">feed</a></li>

				<li class="search"><a href="http://www._____.com/Project">
						<input class="search-txt" type="text" placeholder=" 검색어를 입력해 주세요">&nbsp;
						<button class="search-btn" type="submit">검색</button>
				</a></li>
				<li class="pay"><a href="http://www._____.com/Travel">이용권</a></li>
				<li class="upload"><a href="musicBbs/uploadsample.jsp">UPLOAD</a></li>
				<li class="profile_top">
					<ul class="profile_inner">

						<%-- 로그인되었을 때 --%>
						<c:set value="${user }" var="list" />
						<c:set value="${sessionUserVO }" var="vo" />

						<c:if test="${!empty vo }">
							<a>${vo.getUser_nickname() }님 환영합니다</a>
							<li><a href="<%=request.getContextPath()%>/logout_check.do">로그아웃</a></li>
							<li><a
								href="<%=request.getContextPath()%>/my_page.do?num=${vo.getUser_id() }">마이페이지</a></li>
							<li><a href="musicBbs/uploadsample.jsp">앨범 등록</a></li>
							<li><a
								href="<%=request.getContextPath()%>/user_music_list.do">앨범리스트</a></li>
							<li><a
								href="<%=request.getContextPath()%>/my_music_list.do?id=${vo.getUser_id() }">내가
									업로드한 파일</a></li>
							<li><a href="<%=request.getContextPath()%>/like_list.do">좋아요<br>플레이리스트
							</a></li>
							<li><a href="<%=request.getContextPath()%>/user_myplaylistok.do">MY<br>플레이리스트
							</a></li>
							
						</c:if>

						<c:if test="${empty vo }">
							<%-- 로그인되지 않았을 때 --%>
							<a>프로필</a>
							<li><a href="login/login.jsp">로그인</a></li>
							<li><a href="register/RegisterChoice.jsp">회원가입</a></li>
							<li><a href="http://www._____.com/LIkeList">좋아요<br>플레이리스트
							</a></li>
							<li><a href="http://www._____.com/HateList">싫어요<br>플레이리스트
							</a></li>
							<li><a
								href="<%=request.getContextPath()%>/user_music_list.do">앨범리스트</a></li>
						</c:if>
					</ul>
				</li>
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
			
				<div class="genre">발라드</div>
				<div class="singer">가수</div> <img class="imgs" src="img/img2.png">
				<img class="pic" src="img/pic_1.png">
			
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
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

<a href="<%=request.getContextPath() %>/music_list.do">음악 리스트 로 가는 버튼</a>

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

	// 추가: 음악 상세 페이지를 AJAX로 불러오는 함수입니다.
	function loadMusicDetails(musicId) {
		$.ajax({
			url : "music_details.jsp",
			type : "GET",
			data : {
				id : musicId
			},
			success : function(data) {
				$("#content").html(data);
			},
			error : function(xhr, status, error) {
				console.error("Error loading music details:", error);
			}
		});
	}
</script>
</html>