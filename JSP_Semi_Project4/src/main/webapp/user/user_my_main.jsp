<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<div class="container mt-5">
		<div class="text-center">
			<hr class="w-75 bg-danger" align="center">
			<h3>My List</h3>
			<hr class="w-75 bg-danger" align="center">
			<br>


			<c:set var="uservo" value="${userVO }" />
			<table align="center" border="1">
				<tr>
					<th>pic</th>
					<td><img
						src="<%=request.getContextPath() %>/fileupload/${uservo.getUser_pic() }"
						width="60" height="60"></td>
				</tr>
				<tr>
					<th>nickname</th>
					<td>${uservo.getUser_nickname() }</td>
				</tr>
				<tr>
					<th>followers count</th>
					<td>444</td>
				</tr>
				<tr>
					<th>following count</th>
					<td>123</td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" id="follow_btn"
						onclick="" value="정보 수정"></td>
				</tr>
			</table>

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
					</tr>
				</thead>
				<tbody>
					<c:set var="list" value="${userMusicList }" />
					<c:if test="${!empty list }">
						<c:forEach items="${list }" var="vo">
							<tr>
								<td>${vo.getMusic_title() }</td>
								<td><img
									src="<%=request.getContextPath() %>/fileupload/${vo.getMusic_pic() }"
									width="60" height="60"></td>
								<td>${vo.getMusic_mp3() }</td>
								<td>${vo.getMusic_contents() }</td>
								<td><a
									href="<%=request.getContextPath() %>/user_main.do?user_id=${vo.getUser_id() }">${vo.getUser_nickname() }</a></td>
								<td>${vo.getMusic_likecnt() }</td>
								<td>${vo.getMusic_playcnt() }</td>
								<td><a
									href="<%=request.getContextPath() %>/user_music_content.do?id=${vo.getMusic_id() }">들어가기</a></td>
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

	<!-- Add Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		
	</script>
</body>
</html>