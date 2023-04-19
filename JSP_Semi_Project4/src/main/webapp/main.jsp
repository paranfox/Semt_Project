<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	<jsp:include page="test_main_top.jsp"/>

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