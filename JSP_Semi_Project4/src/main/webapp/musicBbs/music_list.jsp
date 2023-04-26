<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap JS 파일 및 종속성 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>앨범 List</title>
<!-- Add Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
td {
	text-align: "center";
}

.music-player-container {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
}

#contentContainer {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 100;
	background-color: rgba(255, 255, 255, 1);
	overflow-y: auto;
	display: none;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div class="container mt-5">
		<!-- 플레이리스트 생성 및 출력 영역 -->
		<div class="playlist-section mt-5">
			<h4 class="text-center">나만의 플레이리스트</h4>
			<div class="text-center">
				<input type="text" id="newPlaylistName" placeholder="플레이리스트 이름">
				<button class="btn btn-primary" id="createPlaylistBtn">플레이리스트
					생성</button>
			</div>
			<div id="playlists" class="mt-3">
				<!-- 플레이리스트가 동적으로 생성됩니다. -->
			</div>
		</div>
		<div class="text-center">
			<hr width="100%" color="tomato" align="center">
			<h3>Album List</h3>
			<hr width="100%" color="tomato" align="center">
			<br> <input class="btn btn-info" type="button" value="메인 메뉴"
				id="closeIframeBtn">
			<!-- Add Bootstrap table classes -->
			<table class="table table-bordered table-striped w-75 mx-auto">
				<thead class="bg-warning">
					<tr>
						<th>앨범 제목</th>
						<th>앨범 이미지</th>
						<th>music_mp3(파일명)</th>
						<th>앨범 설명(contents)</th>
						<th>작성자</th>
						<th>좋아요</th>
						<th>재생수</th>
						<th>상제 정보 들어가기</th>
						<th>플레이리스트에 추가</th> 
					</tr>
				</thead>
				<tbody>
					<c:set var="list" value="${musicList }" />
					<c:if test="${!empty list }">
						<c:forEach items="${list }" var="vo">
							<tr>
								<td>${vo.getMusic_title() }</td>
								<td><img
									src="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }"
									data-mp3="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_mp3() }"
									data-album-title="${vo.getMusic_title() }"
									data-image="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }"
									width="60" height="60" class="album-image rounded-circle"
									onclick="pauseContentAudioPlayer();"></td>
								<td>${vo.getMusic_mp3() }</td>
								<td>${vo.getMusic_contents() }</td>
								<td><a
									href="<%=request.getContextPath() %>/user_main.do?user_id=${vo.getUser_id() }">${vo.getUser_nickname() }</a></td>
								<td>${vo.getMusic_likecnt() }</td>
								<td>${vo.getMusic_playcnt() }</td>
								<td><a href="#" class="goToContentBtn"
									data-album-id="${vo.getMusic_id()}" onclick="loadIframe(this);">ABOUT</a></td>
								<td><button class="btn btn-success addToPlaylistBtn" data-album-id="${vo.getMusic_id()}">PLUS</button></td> <!-- 추가된 버튼 -->	
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty list }">
						<tr>
							<td colspan="9" class="text-center">
								<h3>앨범 리스트가 없습니다.</h3>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>

	<div class="music-player-container">

		<jsp:include page="../mp3Player.jsp" />

	</div>
	<iframe id="contentIframe" frameborder="0"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;"></iframe>
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
	         // 플레이리스트 생성 성공 후 새로고침
	         /* loadPlaylists(); */
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

</script>
</html>