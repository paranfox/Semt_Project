<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>앨범 List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
a {
   text-decoration: none;
}

.music-player-container {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
}

.music_content {
   height: 45px;
   display: flex;
   align-items: center;
   font-weight: 1000;
   padding: 0 0 4px 0;
   border-bottom: 1px solid rgb(214, 214, 214);
}

.music_content:hover {
   background-color: rgb(235, 235, 235);
}

.music_content img {
   margin-top: 10px;
   width: 40px;
   height: 40px;
   padding: 5px;
   object-fit: cover;
}

.music_title {
   margin-right: auto;
}

.music_like {
   margin-left: auto;
   color: rgb(77, 76, 76);
   font-size: .8em;
}

.music_count {
   color: rgb(77, 76, 76);
   font-size: .8em;
}

.music_like img {
   width: 11px;
   height: auto;
   opacity: .4;
   margin: 0;
   padding: 0;
}

.music_count img {
   width: 13px;
   height: auto;
   opacity: .4;
   margin: 0;
   padding: 0;
}

.music_count span {
   width: 13px;
   margin: 0;
   padding: 0;
}
</style>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../test_main_top.jsp" />
<br>
<br>
<br>
   <div class="container mt-5">
		<div class="playlist-section mt-5">
			<h4 class="text-center"></h4>
			<div class="text-center">
				<input type="text" id="newPlaylistName" placeholder="Eenter Playlist name">
				<font size=5> &nbsp;</font>
				<button class="btn btn-secondary btn-sm"" id="createPlaylistBtn" style="background-color: #f50;">CREATE PLAYLISTS</button>
			</div>
			<div id="playlists" class="mt-3">
				<!-- 플레이리스트가 동적으로 생성됩니다. -->
			</div>
		</div>
		
      <div id="music_list_container">
         <c:set var="list" value="${musicList }" />
         <c:if test="${!empty list }">
            <c:forEach items="${list }" var="vo">

               <div class="music_content">
                  <div class="music_cover">
                     <img
                        src="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }"
                        data-mp3="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_mp3() }"
                        data-album-title="${vo.getMusic_title() }"
                        data-image="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }"
                        width="60" height="60" class="album-image rounded-circle"
                        onclick="pauseContentAudioPlayer();">
                  </div>
                  <div class="music_author">
                     <a href="<%=request.getContextPath() %>/user_main.do?user_id=${vo.getUser_id() }">${vo.getUser_nickname() }</a>
                  </div>
                  &nbsp;
                  <div>-</div>
                  &nbsp;
                  <div class="music_title">
                     <a href="#" class="goToContentBtn"
                        data-album-id="${vo.getMusic_id() }" onclick="loadIframe(this);">${vo.getMusic_title() }</a>
                  </div>
                  <div class="music_count">
                     <img src="img/105220.png"><span>&nbsp;${vo.getMusic_likecnt() }</span>
                  </div>
                  <div>
                     <font size=5> &nbsp; </font> <button class="btn btn-secondary btn-sm""
                        data-album-id="${vo.getMusic_id()}" style="background-color: #f50;">PLUS</button>
                  </div>
               </div>

            </c:forEach>
         </c:if>

         <c:if test="${empty list }">
            Seems a little quiet over here
      </c:if>

      </div>
   </div>
	<div align="center">
	<br>
	
	<input class="btn btn-info" type="button" value="MAIN" id="closeIframeBtn" style="background-color: white;" >
	</div>
   <div class="music-player-container">
      <jsp:include page="../mp3Player.jsp" />
   </div>

   <iframe id="contentIframe" frameborder="0" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;"></iframe>
   <script>
      
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

function createPlaylist(playlistName) {
      $.ajax({
         type: "POST",
         url: "create_playlist.do",
         data: {
            user_id: '${sessionScope.sessionId}',
            playlist_name: playlistName
         },
         success: function (response) {
   
           alert('플레이리스트 생성 성공!!!');
         },
         error: function (xhr, status, error) {
            console.error("플레이리스트 생성 실패: " + error);
         }
      });
   }
   
   // 플레이리스트 불러오기
   function loadPlaylists() {
      $.ajax({
         type: "GET",
         url: "get_playlists.do",
         data: {
            user_id: '${sessionScope.sessionId}'
         },
         success: function (response) {
            // 받은 데이터로 플레이리스트 출력
            displayPlaylists(response);
         },
         error: function (xhr, status, error) {
            console.error("플레이리스트 불러오기 실패: " + error);
         }
      });
   }
   
   // 음악 추가하기
   function addMusicToPlaylist(playlistId, musicId) {
      $.ajax({
         type: "POST",
         url: "add_music_to_playlist.do",
         data: {
            playlist_id: playlistId,
            music_id: musicId
         },
         success: function (response) {
            // 음악 추가 성공 후 새로고침
            /* loadPlaylists(); */
            alert('플레이리스트 추가 성공!!!');
         },
         error: function (xhr, status, error) {
            console.error("음악 추가 실패: " + error);
         }
      });
   }
   // 음악 삭제하기
   function removeMusicFromPlaylist(playlistId, musicId) {
      $.ajax({
         type: "POST",
         url: "remove_music_from_playlist.do",
         data: {
            playlist_id: playlistId,
            music_id: musicId
         },
         success: function (response) {
            // 음악 삭제 성공 후 새로고침
            loadPlaylists();
         },
         error: function (xhr, status, error) {
            console.error("음악 삭제 실패: " + error);
         }
      });
   }
   
   $(document).ready(function () {
	    document.getElementById("createPlaylistBtn").addEventListener("click", function () {
	        var playlistName = document.getElementById("newPlaylistName").value.trim();

	        if (playlistName.length === 0) {
	            alert("플레이리스트 이름을 입력해주세요.");
	            return;
	        }

	        createPlaylist(playlistName);
	    });

	    document.querySelectorAll(".addToPlaylistBtn").forEach((btn) => {
	        btn.addEventListener("click", (event) => {
	            const musicId = event.target.dataset.albumId;
	            const playlistId = prompt("플레이리스트 ID를 입력해주세요.");

	            if (playlistId) {
	                addMusicToPlaylist(playlistId, musicId);
	            }
	        });
	    });
	});
</script>
</html>