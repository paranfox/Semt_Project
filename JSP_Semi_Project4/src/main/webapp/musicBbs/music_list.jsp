<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<h3>Music List</h3>
			<hr class="w-75 bg-danger" align="center">
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
									src="<%=request.getContextPath() %>/fileupload/${vo.getMusic_pic() }"
									width="60" height="60"></td>
								<td>${vo.getMusic_mp3() }</td>
								<td>${vo.getMusic_contents() }</td>
								<td>${vo.getMusic_likecnt() }</td>
								<td>${vo.getMusic_playcnt() }</td>
								<td><a
									href="<%=request.getContextPath() %>/user_music_content.do?id=${vo.getMusic_id() }">들어가기</a></td>
								<td><a
									href="<%=request.getContextPath() %>/admin_product_modify.do?pnum=${dto.getPnum() }">수
										정</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; <a
									href="<%=request.getContextPath() %>/admin_product_delete.do?pnum=${dto.getPnum() }">삭
										제</a></td>
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

	<!-- Add Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>