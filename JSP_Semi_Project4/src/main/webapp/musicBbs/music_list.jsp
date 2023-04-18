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
</style>
</head>
<body>
	<div class="container mt-5">
		<div class="text-center">
			<hr width="100%" color="tomato" align="center">
			<h3>Album List</h3>
			<hr width="100%" color="tomato" align="center">
			<br>

			<!-- Add Bootstrap table classes -->
			<table class="table table-bordered table-striped w-75 mx-auto">
				<thead class="bg-warning">
					<tr>
						<th>앨범 제목</th>
						<th>앨범 이미지</th>
						<th>music_mp3(파일명)</th>
						<th>앨범 설명(contents)</th>
						<th>좋아요</th>
						<th>재생수</th>
						<th>상제 정보 들어가기</th>
						<th>수정 / 삭제</th>
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
									width="60" height="60" class="album-image rounded-circle"></td>
								<td>${vo.getMusic_mp3() }</td>
								<td>${vo.getMusic_contents() }</td>
								<td>${vo.getMusic_likecnt() }</td>
								<td>${vo.getMusic_playcnt() }</td>
								<td><a
									href="<%=request.getContextPath() %>/user_music_content.do?id=${vo.getMusic_id() }">들어가기</a></td>
								<td><a
									href="<%=request.getContextPath() %>/admin_product_modify.do?uno=${vo.getMusic_id()}">수
										정</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; <a href="#"
									class="goToContentBtn" data-album-id="${vo.getMusic_id()}">들어가기</a></td>
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
        });
    });
    

    document.querySelectorAll(".goToContentBtn").forEach((btn) => {
      btn.addEventListener("click", function (event) {
        event.preventDefault();

      
        const selectedAlbumId = event.target.dataset.albumId;


        $.ajax({
          url: "<%=request.getContextPath()%>/user_music_content.do",
          type: "GET",
          data: { id: selectedAlbumId },
          success: function (data) {

            document.querySelector(".container").innerHTML = data;
          },
          error: function (error) {
            console.error("Error fetching music content:", error);
          },
        });
      });
    });
    </script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>