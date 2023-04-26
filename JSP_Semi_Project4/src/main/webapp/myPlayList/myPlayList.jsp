<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>My Playlist</title>
<style>

	ul {
		list-style-type: none;
		padding: 0;
		margin: 0;
		display: flex;
		flex-wrap: wrap;
	}

	li {
		margin: 10px;
	}

	img {
		width: 100px;
		height: 100px;
		border-radius: 70%;
		align: center;
	}
	
	
	.music-player-container {
		position: fixed;
		bottom: 0;
		left: 0;
		right: 0;
	}
	
</style>
</head>
<body>
<jsp:include page="../test_main_top.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<h1>My Playlists</h1>
	<% List<model.PlaylistVO> playlists = (List<model.PlaylistVO>) request.getAttribute("playlists"); %>
	<% Map<Integer, List<model.MusicVO>> playlistMusicMap = (Map<Integer, List<model.MusicVO>>) request.getAttribute("playlistMusicMap"); %>
	<% if (playlists != null) { %>
		<% for (model.PlaylistVO playlist : playlists) { %>
			<h2><%= playlist.getPlaylist_name() %></h2>
			<% List<model.MusicVO> albumList = playlistMusicMap.get(playlist.getPlaylist_id()); %>
			<% if (albumList != null) { %>
				<ul>
				<% for (model.MusicVO music : albumList) { %>
					<li>
						<img 
						src="<%=request.getContextPath() %>/fileUpload/<%= music.getMusic_pic() %>" alt="album_cover"
						data-mp3="<%=request.getContextPath() %>/fileUpload/<%=music.getMusic_mp3() %>"
						data-album-title="<%=music.getMusic_title() %>"
						data-image="<%=request.getContextPath() %>/fileUpload/<%=music.getMusic_pic() %>"
						width="60" height="60" class="album-image rounded-circle" 
						onclick="pauseContentAudioPlayer();">
						<div align="center"><%= music.getMusic_title() %></div>
						<div align="center"><a  href="#" class="goToContentBtn" data-album-id="<%=music.getMusic_id() %>" onclick="loadIframe(this);">ABOUT</a></div>
						<%-- <div align="center"><%= music.getMusic_title() %></div> --%>
					</li>
				<% } %>
				</ul>
			<% } else { %>
				<p>No albums in this playlist.</p>
			<% } %>
		<% } %>
	<% } else { %>
		<p>No playlists found.</p>
	<% } %>
	

	<div class="music-player-container">
		<jsp:include page="../mp3Player.jsp" />
	</div>
	<iframe id="contentIframe" frameborder="0" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;"></iframe>
	<script type="text/javascript">
	   
    const audioPlayer = document.querySelector("#audioPlayer");
   
    document.querySelectorAll(".album-image").forEach((img) => {
        img.addEventListener("click", (event) => {
            const mp3Path = event.target.dataset.mp3;
            const albumTitle = event.target.dataset.albumTitle;
            const albumImage = event.target.dataset.image;
            audioPlayer.querySelector("source").src = mp3Path;
            audioPlayer.load();
            audioPlayer.play();

            document.getElementById("albumTitle").textContent = albumTitle;
            document.getElementById("albumImage").src = albumImage;
        
            $.ajax({
               type : "POST",
               url : "save_played_music.do",
               data: {
                 user_id : '${sessionScope.sessionId}',
                 music_id : event.target.parentElement.parentElement.querySelector(".goToContentBtn").dataset.albumId
               },
               success: function(response) {
                 console.log("재생 정보 저장 성공");
               },
               error : function(xhr, status, error) {
                  console.error("재생 정보 저장 실패: " + error);
               }
            });
        
        });
    });
    
    function loadIframe(link) {
        const albumId = link.getAttribute("data-album-id");
        const iframe = document.getElementById("contentIframe");
        iframe.src = "<%=request.getContextPath()%>/user_music_content.do?id=" + albumId;
        iframe.style.display = "block";
      }
      
    function pauseContentAudioPlayer() {
        const contentIframe = window.parent.document.getElementById("contentIframe");
        if (contentIframe) {
            const contentAudioPlayer = contentIframe.contentWindow.document.getElementById("audioPlayer");
            if (contentAudioPlayer) {
                contentAudioPlayer.pause();
            }
        }
    }
    
    function playNextTrack() {
        const audioPlayer = document.querySelector("#audioPlayer");
        const albumImages = document.querySelectorAll(".album-image");
        let currentIndex = -1;

        albumImages.forEach((img, index) => {
            const currentMP3Path = new URL(img.dataset.mp3, document.baseURI).href;
            if (currentMP3Path === new URL(audioPlayer.querySelector("source").src, document.baseURI).href) {
                currentIndex = index;
            }
        });

        if (currentIndex !== -1) {
            const nextIndex = (currentIndex + 1) % albumImages.length;
            const nextImage = albumImages[nextIndex];

            const mp3Path = nextImage.dataset.mp3;
            const albumTitle = nextImage.dataset.albumTitle;
            const albumImage = nextImage.dataset.image;

            audioPlayer.querySelector("source").src = mp3Path;
            audioPlayer.load();
            audioPlayer.play();

            document.getElementById("albumTitle").textContent = albumTitle;
            document.getElementById("albumImage").src = albumImage;
        }
    }

    audioPlayer.addEventListener("ended", playNextTrack);

    function playTrack(index) {
        const img = document.querySelectorAll(".album-image")[index];
        const mp3Path = img.dataset.mp3;
        const albumTitle = img.dataset.albumTitle;
        const albumImage = img.dataset.image;
        audioPlayer.querySelector("source").src = mp3Path;
        audioPlayer.load();
        audioPlayer.play();

        document.getElementById("albumTitle").textContent = albumTitle;
        document.getElementById("albumImage").src = albumImage;
    }

    document.getElementById("previousButton").addEventListener("click", () => {
        const albumImages = document.querySelectorAll(".album-image");
        let currentIndex = -1;

        albumImages.forEach((img, index) => {
            const currentMP3Path = new URL(img.dataset.mp3, document.baseURI).href;
            if (currentMP3Path === new URL(audioPlayer.querySelector("source").src, document.baseURI).href) {
                currentIndex = index;
            }
        });

        if (currentIndex !== -1) {
            const prevIndex = (currentIndex - 1 + albumImages.length) % albumImages.length;
            playTrack(prevIndex);
        }
    });

    document.getElementById("nextButton").addEventListener("click", () => {
        const albumImages = document.querySelectorAll(".album-image");
        let currentIndex = -1;

        albumImages.forEach((img, index) => {
            const currentMP3Path = new URL(img.dataset.mp3, document.baseURI).href;
            if (currentMP3Path === new URL(audioPlayer.querySelector("source").src, document.baseURI).href) {
                currentIndex = index;
            }
        });

        if (currentIndex !== -1) {
            const nextIndex = (currentIndex + 1) % albumImages.length;
            playTrack(nextIndex);
        }
    });
	</script>
</body>
<script type="text/javascript">

document.getElementById("closeIframeBtn").addEventListener("click", function () {
    location.href = "main.jsp";
});

</script>
</html>
