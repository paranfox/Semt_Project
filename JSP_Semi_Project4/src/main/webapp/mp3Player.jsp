<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.container {
	width: 800px;
	margin: 1px auto;
}

.mejs { &__container { margin-top:10px;
	
}

&
__controls {
	display: block;
}

&
__controls, &__container {
	background: none !important;
}

&
__time {
	color: #777;
	font-weight: normal;
}

}
.podcast {
	background: #f0f0f0;
	padding: 30px;
	border-radius: 3px; & __episode_title { font-size : 28px;
	font-weight: bold;
	line-height: 0.5;
	margin-bottom: 0;
	padding-bottom: 0;
	margin-top: 0;
	color: #333;
}

&
__title {
	margin-top: 10px;
	text-transform: uppercase;
	font-size: 11px;
	color: #555; i { font-style : normal;
	font-weight: normal;
	text-transform: capitalize;
	margin-left: 10px;
}

}
&
__meta {
	background: #ddd;
	margin: 40px -30px -30px -30px;
	padding: 0 30px 30px 30px;
	display: flex;
	justify-content: space-between;
	border-bottom-left-radius: 3px;
	border-bottom-right-radius: 3px; . artwork { margin-right : 0;
	transform: translateY(-70px); > img { border-radius : 3px;
	width: 150px;
	height: 150px;
	box-shadow: 0 4px 6px 0 hsla(0, 0%, 0%, 0.1);
	margin-bottom: -80px;
}

}
}
}
.mejs-prepended-buttons {
	display: flex
}

.mejs-appended-buttons {
	display: flex;
	justify-content: space-evenly;
}

.mejs__play>button {
	background: transparent
		url('https://cdn.jsdelivr.net/gh/ivorpad/images-src/mediaplayer-sprite-gray.svg')
		no-repeat;
}

.mejs__pause>button {
	background: transparent
		url('https://cdn.jsdelivr.net/gh/ivorpad/images-src/mediaplayer-sprite-gray.svg')
		no-repeat;
	background-position: -20px 0;
}

.mejs__mute>button {
	background: transparent
		url('https://cdn.jsdelivr.net/gh/ivorpad/images-src/mediaplayer-sprite-gray.svg')
		no-repeat;
	background-position: -60px 0;
}

.mejs__unmute>button {
	background: transparent
		url('https://cdn.jsdelivr.net/gh/ivorpad/images-src/mediaplayer-sprite-gray.svg')
		no-repeat;
	background-position: -40px 0;
}

.mejs-skip-back-button>button, .mejs__skip-back-button>button {
	background: transparent
		url('https://cdn.jsdelivr.net/gh/ivorpad/images-src/skipback.svg');
}

.mejs-jump-forward-button>button, .mejs__jump-forward-button>button {
	background:
		url('https://cdn.jsdelivr.net/gh/ivorpad/images-src/jumpforward.svg')
		no-repeat;
}

.mejs__button>button {
	color: #555;
}

.mejs__horizontal-volume-slider {
	display: none !important;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="mediaelement-master/build/mediaelementplayer.css" />
<script type="text/javascript"
	src="mediaelement-master/build/mediaelement-and-player.js">
"use strict";

const options = {
  defaultSpeed: '1.00',
  speeds: ['1.25','1.50', '2.00', '0.75'],
  loop: true,
  skipBackInterval: 15,
  jumpForwardInterval: 15,
  features: [
    "playpause",
    "progress",
    "current",
    "duration",
    "skipback",
    "changespeed",
    "volume",
    "jumpforward",
  ]
}

new MediaElementPlayer(
  document.querySelector("audio"),
  options
 );

(() => {
   const elementTop = document.createElement('div');
  const elementBottom = document.createElement('div');
   elementTop.classList.add('mejs-prepended-buttons');
  elementBottom.classList.add('mejs-appended-buttons');

   const controls = document.querySelector('.mejs__controls');
   controls.prepend(elementTop);
  controls.append(elementBottom);
  
   const controlsChildren = Array.from(controls.childNodes).filter(v => v.className.startsWith("mejs_"));

  controlsChildren.slice(0, 3).forEach(elem => {
     elementTop.append(elem)
  });
  
  controlsChildren.slice(3, controlsChildren.length).forEach(elem => {
    elementBottom.append(elem)
  })
})()


</script>
</head>
<body>
	<div class="container">
		<div class="podcast" align="center">
			<h3 class="podcast__episode_title" id="albumTitle">[Click Play
				Button]</h3>
<!-- 			<h5 class="podcast__title">
				장르<i>작곡가</i>
			</h5> -->
			<div class="podcast__meta">
				<button id="previousButton">이전</button>
				<audio id="audioPlayer" controls style="width: 50%;">
					<source
						src="fileUpload/LP1607110010_임샛별_On the hill (Organ ver.).mp3"
						type="audio/mpeg">
				</audio>
				<a href="#" class="artwork"> <img id="albumImage"
					src="img/pic_1.png" alt="앨범 이미지가 표시됩니다." width="60" height="60"
					class="rounded">
				</a>
				<button id="nextButton">다음</button>
			</div>
		</div>
	</div>
</body>
</html>