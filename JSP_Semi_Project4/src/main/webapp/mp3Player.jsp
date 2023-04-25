<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Soundcloud Style MP3 Player</title>
<style type="text/css">


body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
}

.container {
	width: 800px;
	margin: 30px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
}

.mejs__controls {
	background: #f7f7f7 !important;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	padding: 5px;
}

.mejs__time {
	color: #555;
}

.podcast__episode_title {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 10px;
	color: #333;
}

.podcast__meta {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 0;
}

#previousButton, #nextButton {
	background-color: #f50;
	border: none;
	color: white;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
}

#previousButton:hover, #nextButton:hover {
	background-color: #d43e0a;
}

#albumImage {
	border-radius: 3px;
	width: 60px;
	height: 60px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
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
	src="mediaelement-master/build/mediaelement-and-player.js"></script>
<script>
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
</script>
</head>
<body>
	<div class="container">
		<div class="podcast" align="center">
			<h3 class="podcast__episode_title" id="albumTitle">[Click Play
				Button]</h3>
			<div class="podcast__meta">
				<button id="previousButton">이전</button>
				<audio id="audioPlayer" controls style="width: 50%;">
					<source
						src="fileUpload/LP1607110010_임샛별_On the hill (Organ ver.).mp3"
						type="audio/mpeg">
				</audio>
				<a href="#" class="artwork"> 
					<img id="albumImage"
						src="img/pic_1.png" alt="앨범 이미지가 표시됩니다." width="60" height="60"
						class="rounded">
				</a>
				<button id="nextButton">다음</button>
			</div>
		</div>
	</div>
</body>
</html>
				
