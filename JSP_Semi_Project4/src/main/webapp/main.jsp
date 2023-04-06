<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<link rel="stylesheet" href="main.css">
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
				<li class="profile_top">
					<ul class="profile_inner">
						<a href="/JSP_Semi_Project4/Register.jsp">프로필</a>
						<li><a href="http://www._____.com/MyPage">마이페이지</a></li>
						<li><a href="http://www._____.com/LIkeList">좋아요<br>플레이리스트
						</a></li>
						<li><a href="http://www._____.com/HateList">싫어요<br>플레이리스트
						</a></li>
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


	<div class="slideshow-container">

		<div class="mySlides fade">
			<a href="http://www._____.com/slideshow-container">
				<div class="genre">발라드</div>
				<div class="singer">가수</div> <img class="imgs" src="img/img1.png">
				<img class="pic" src="img/pic_1.png">
			</a>
		</div>

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
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>


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
</script>
</html>