<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<style type="text/css">
	
	.pagination {
		justify-content: center;
	}
</style>
</head>
<body>
	<header id="top">
	<div class="top">
	<ul>
	<li class="home"> MY LIST PAGE</li>
	</ul>
	
	</div>
	<a href="main.jsp">홈으로</a>
	<br>
	</header>

	<table border="1" cellspacing="0" width="85%">
		<tr>
			<th>가장 최근 추가한 곡</th>
			<th>앨범명</th>
			<th>올린 유저명</th>
			<th>커버 이 미 지</th>
			<th>기타</th>

		</tr>
		<c:set var="list" value="${my_playlist }" />
		<c:forEach items="${list }" var="dto">
				<tr>
					<td><section class="tape">
							<audio
								src="<%=request.getContextPath() %>/fileupload/${dto.getMusic_mp3() }"
								crossorigin="anonymous"></audio>

							<button data-playing="false" class="tape-controls-play"
								role="switch" aria-checked="false">
								<span>Play/Pause</span>
							</button>
						</section></td>
					<td> <a href="<%=request.getContextPath() %>/user_music_content.do?id=${dto.getUser_id() }&page=${page }">${dto.getMusic_title() }</a></td>
					<td>${dto.getUser_id() }</td>
					<td id="music">
					<img src="<%=request.getContextPath() %>/fileUpload/${dto.getMusic_pic() }" style="width: 80px;">
					</td>
				<td>
				<input type="button" value="❤️" id="liked">
					</td>
			
				</tr>
				
			</c:forEach>
	</table>
	
	
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
</body>
</html>