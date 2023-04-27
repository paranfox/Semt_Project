<%@page import="model.MusicVO"%>
<%@page import="persistence.MusicDAO"%>
<%@page import="java.util.List"%>
<%@page import="persistence.SlideDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>4undCLOUD</title>
<link rel="stylesheet" href="css/main.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">

#previousButton, #nextButton {
   background-color: #f50;
   border: none;
   color: white;
   padding: 5px 10px;
   border-radius: 3px;
   cursor: pointer;
}

.carousel-item {
  opacity: 0.3;
  transition: opacity 0.5s ease;
}

.carousel-item.active {
  opacity: 1;
}

</style>
</head>
<body>
   <jsp:include page="test_main_top2.jsp" />
   <br>
   <br>
   <br>
   <br>
   <br>
   <div align="center">
	<form class="search" action="<%=request.getContextPath()%>/search.do" method="post">
		<select name="find">
			<option value="All">ALL</option>
			<option value="name">NICKNAME</option>
			<option value="title">ALBUM</option>
			<option value="content">CONTENT</option>
		</select> <input class="search-txt" type="text" name="keyword" placeholder="Search for artists, bands, tracks, podcasts">
		<button class="search-btn" type="submit">&#128269;</button><font size=5> &nbsp;</font> <font size=5> or </font><font size=5> &nbsp;</font> <button id="previousButton" onclick="location.href='<%=request.getContextPath()%>/upload_music.do'">Upload your own</button> 
	 </form>
	</div> 
   <br>
   <h2 align="center">Hear what’s trending for free in the 4undCloud community </h2>
   <br>
   <% SlideDAO slideDao = SlideDAO.getInstance(); List<MusicVO> musicList = slideDao.getAllMusic();%>
   <div id="albumCarousel" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
         <%
         for (int i = 0; i < musicList.size(); i++) {
         %>
         <li data-target="#albumCarousel" data-slide-to="<%=i%>"
            <%=(i == 0) ? "class=\"active\"" : ""%>></li>
         <%
         }
         %>
      </ol>
      <div class="carousel-inner">
         <%
         for (int i = 0; i < musicList.size(); i++) {
            MusicVO music = musicList.get(i);
         %>
         <div class="carousel-item <%=(i == 0) ? "active" : ""%>">
            <img
               src="<%=request.getContextPath() %>/fileUpload/<%= music.getMusic_pic() %>"
               class="album-image d-block mx-auto my-3" style="max-width: 20%;"
               alt="<%=music.getMusic_title()%>"
               data-mp3="<%=request.getContextPath() %>/fileUpload/<%=music.getMusic_mp3() %>"
               data-album-title="<%=music.getMusic_title() %>"
               width="250" height="250"
               data-image="<%=request.getContextPath() %>/fileUpload/<%=music.getMusic_pic() %>">

            <div class="carousel-caption d-none d-md-block">
               <h3><%=music.getMusic_title()%></h3>
               <p><%=music.getMusic_contents()%></p>
            </div>
         </div>
         <%
         }
         %>
      </div>
      <a class="carousel-control-prev" href="#albumCarousel" role="button"
         data-slide="prev"> <span class="carousel-control-prev-icon"
         aria-hidden="true"></span> <span class="sr-only">Previous</span>
      </a> <a class="carousel-control-next" href="#albumCarousel" role="button"
         data-slide="next"> <span class="carousel-control-next-icon"
         aria-hidden="true"></span> <span class="sr-only">Next</span>
      </a>
   </div>
   <br>
   <div align="center">
      <button id="previousButton"
         onclick="location.href='<%=request.getContextPath()%>/user_music_list.do'">Explore
         trending playlists</button>
   </div>
   <br>
   <div class="music-player-container"><jsp:include
         page="mp3Player.jsp" /></div>
   <script type="module"
      src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
   <script nomodule
      src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
<script type="text/javascript">
const audioPlayer = document.querySelector("#audioPlayer");

document.querySelectorAll(".album-image").forEach((img) => {
    img.addEventListener("click", (event) => {
        const mp3Path = event.target.dataset.mp3;
        const albumTitle = event.target.dataset.albumTitle;
        const albumImage = img.dataset.image;
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

		document.querySelectorAll(".album-image-container").forEach((container) => {
			  container.addEventListener("mouseenter", () => {
			    container.querySelector(".play-icon").style.display = "block";
			  });
		
			  container.addEventListener("mouseleave", () => {
			    container.querySelector(".play-icon").style.display = "none";
			  });
			});
      
      function loadIframe(link) {
          const iframe = document.getElementById("contentIframe");
          if (iframe.style.visibility === "hidden") {
              iframe.style.visibility = "visible";
          } else {
              iframe.src = "<%=request.getContextPath()%>/user_music_list.do";
            iframe.style.display = "block";
         }
      }
</script>
</html>