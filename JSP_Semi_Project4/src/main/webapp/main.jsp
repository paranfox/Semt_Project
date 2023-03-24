<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<link rel="stylesheet" href="main.css">
</head>
<body>

<div class="top" >
	<nav class="clearfix1">
		<ul class="clearfix1">
			<li class="logo"><a href="http://www._____.com">LOGO</a></li>
			<li class="feed"><a href="http://www._____.com/About">피드</a></li> <!--""<-여기 부분에 URL 작성하면 됨-->
		</ul>
	</nav>
	
	<nav class="clearfix2">
		<ul class="clearfix2">
			<li class="find"><a href="http://www._____.com/Project">검색창</a></li>
			<li class="pay"><a href="http://www._____.com/Travel">이용권</a></li>
			<li class="profile"><a href="http://www._____.com/Contact">프로필</a></li>
		</ul>
	</nav>
</div>

<br> <br> <br> <br> <br> 

<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel"   align="center">
	<ol class="carousel-indicators">
		<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
		<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
	</ol>
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img src="img/store1.jpg" class="d-block w-100" alt="...">
		</div>
		<div class="carousel-item">
			<img src="img/store2.jpg" class="d-block w-100" alt="...">
		</div>
		<div class="carousel-item">
			<img src="img/store3.jpg" class="d-block w-100" alt="...">
		</div>
	</div>
	<button class="carousel-control-prev" type="button" data-target="#carouselExampleIndicators" data-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</button>
	<button class="carousel-control-next" type="button" data-target="#carouselExampleIndicators" data-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</button>
</div>

<br> <br> <br> <br> <br> 

<div>
	<section class="music-player-section">
		<audio src="sound.mp3" autoplay loop controls id="myAudio">오디오 지원되지 않는 브라우저</audio>
		
	</section>
</div>




</body>
</html>l>