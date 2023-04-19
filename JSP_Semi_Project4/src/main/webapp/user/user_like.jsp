<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<jsp:include page="../test_main_top.jsp" />

	<div class="main_con"></div>
	
	
	<div align="center">
	<hr width="85%" color="red">
	<h3>회원님에 전체 좋와요 페이지</h3>
	<hr width="85%" color="red">
	</div>
	<a href="main.jsp">홈으로</a>
	<br>

	<table border="1" cellspacing="0" width="85%">
		<tr bgcolor="#ffcc00">
			<th>가장 최근 누른 좋와요 곡</th>
			<th>앨범명</th>
			<th>올린 유저명</th>
			<th>커버 이 미 지</th>
			<th>좋와요 라벨</th>
			
		</tr>
		<c:set var="list" value="${user_likelist }" />
		<c:forEach items="${list }" var="dto">
				<tr>
					<td><section class="tape">
							<audio
								src="<%=request.getContextPath() %>/fileUpload/${dto.getMusic_mp3() }"
								crossorigin="anonymous"></audio>

							<button data-playing="false" class="tape-controls-play"
								role="switch" aria-checked="false">
								<span>Play/Pause</span>
							</button>
						</section></td>
					<td>${dto.getMusic_title() }</td>
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
	
<%-- img alt="" src="<%=request.getContextPath() %>/upload/"
	width="60" height="60"--%>

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