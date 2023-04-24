<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap JS 파일 및 종속성 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>검색 리스트</title>
<!-- Add Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
td {
	text-align: "center";
}
</style>
</head>
<body>

	

	<div class="main_con"></div>

	<div class="container mt-5">
		<div class="text-center">
			<hr width="100%" color="tomato" align="center">
			<h3>검색 리스트</h3>
			<hr width="100%" color="tomato" align="center">
			<br>

			<!-- Add Bootstrap table classes -->
			<table class="table table-bordered table-striped w-75 mx-auto">
				<thead class="bg-warning">
					<tr >
						<th>앨범 제목</th>
						<th>앨범 이미지</th>
						<th>music_mp3(파일명)</th>
						<th>앨범 설명(contents)</th>
						<th>작성자</th>
						<th>좋아요</th>
						<th>재생수</th>
					</tr>
				</thead>
				<tbody>

					<c:set var="list" value="${searchList }" />
					<c:if test="${!empty list }">
						<c:forEach items="${list }" var="vo">
							<tr>
								<td>${vo.getMusic_title() }</td>
								<td>${vo.getMusic_pic() }</td>
								<td>${vo.getMusic_mp3() }</td>
								<td>${vo.getMusic_contents() }</td>
								<td>${vo.getUser_nickname() }</td>
								<td>${vo.getMusic_likecnt() }</td>
								<td>${vo.getMusic_playcnt() }</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty list }">
						<tr>
							<td colspan="10" class="text-center">
								<h3>앨범 리스트가 없습니다.</h3>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="../mp3Player.jsp" />

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
    </script>
	<!-- Add Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>