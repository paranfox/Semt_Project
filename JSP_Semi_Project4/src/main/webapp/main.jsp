<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String result = (String) session.getAttribute("sessionNickName");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>main</title>

<link rel="stylesheet" href="css/main.css">

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


						<c:set value="${user }" var="list" />
						<c:set value="${sessionUserVO }" var="vo" />
						<c:if test="${!empty vo }">

							<a>${vo.getUser_nickname() }님 환영합니다</a>
							<li><a href="<%=request.getContextPath()%>/logout_check.do">로그아웃</a></li>
							<li><a href="http://www._____.com/MyPage">마이페이지</a></li>
							<li><a href="uploadsample.jsp"> 뮤직업로드 </a></li>
							<li><a href="http://www._____.com/LIkeList">좋아요<br>플레이리스트
							</a></li>
							<li><a href="<%=request.getContextPath()%>/upload_music.do">앨범
									등록</a></li>

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


	<div class="slideshow-container">

		<div class="mySlides fade">
			<div class="genre">${list.getMusic_id() }</div>
			<div class="singer">가수</div>
			<img class="imgs" src="img/img1.png"> <img class="pic"
				src="<%=request.getContextPath() %>/fileupload/${list.getMusic_pic() }">

			<div id="boombox">
				<div class="boombox-handle"></div>

				<div class="boombox-body">
					<section class="master-controls">
						<input type="range" id="volume" class="control-volume" min="0"
							max="2" value="1" list="gain-vals" step="0.01"
							data-action="volume" />
						<datalist id="gain-vals">
							<option value="0" label="min"></option>
							<option value="2" label="max"></option>
						</datalist>

						<label for="volume">VOL</label> <input type="range" id="panner"
							class="control-panner" list="pan-vals" min="-1" max="1" value="0"
							step="0.01" data-action="panner" />
						<datalist id="pan-vals">
							<option value="-1" label="left"></option>
							<option value="1" label="right"></option>
						</datalist>

						<label for="panner">PAN</label>

						<button class="control-power" role="switch" aria-checked="false"
							data-power="on">
							<span>On/Off</span>
						</button>
					</section>



					<section class="tape">
						<audio
							src="<%=request.getContextPath() %>/fileupload/${list.getMusic_mp3() }"
							crossorigin="anonymous"></audio>

						<!-- 			type="audio/mpeg" -->

						<button data-playing="false" class="tape-controls-play"
							role="switch" aria-checked="false">
							<span>Play/Pause</span>
						</button>
					</section>
				</div>
				<!-- boombox-body -->
			</div>

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
console.clear();

// 음악 커넥션
let audioCtx;

// 음악출력
const audioElement = document.querySelector("audio");
let track;

const playButton = document.querySelector(".tape-controls-play");

// 플래이버튼 활성화
playButton.addEventListener(
  "click",
  () => {
    if (!audioCtx) {
      init();
    }

    // 자동음악 체므
    if (audioCtx.state === "suspended") {
      audioCtx.resume();
    }

    if (playButton.dataset.playing === "false") {
      audioElement.play();
      playButton.dataset.playing = "true";
      // 만약 자동음악이 아닐경우 정지
    } else if (playButton.dataset.playing === "true") {
      audioElement.pause();
      playButton.dataset.playing = "false";
    }

    // 음악이 정지시 확인
    let state =
      playButton.getAttribute("aria-checked") === "true" ? true : false;
    playButton.setAttribute("aria-checked", state ? "false" : "true");
  },
  false
);

// 음악이 끝까지 작동했을 시
audioElement.addEventListener(
  "ended",
  () => {
    playButton.dataset.playing = "false";
    playButton.setAttribute("aria-checked", "false");
  },
  false
);

function init() {
  audioCtx = new AudioContext();
  track = new MediaElementAudioSourceNode(audioCtx, {
    mediaElement: audioElement,
  });

  // 볼륨 조절
  const gainNode = new GainNode(audioCtx);

  const volumeControl = document.querySelector('[data-action="volume"]');
  volumeControl.addEventListener(
    "input",
    () => {
      gainNode.gain.value = volumeControl.value;
    },
    false
  );

  const panner = new StereoPannerNode(audioCtx, { pan: 0 });

  const pannerControl = document.querySelector('[data-action="panner"]');
  pannerControl.addEventListener(
    "input",
    () => {
      panner.pan.value = pannerControl.value;
    },
    false
  );

  // 오디오 api연결
  track.connect(gainNode).connect(panner).connect(audioCtx.destination);
}


</script>
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