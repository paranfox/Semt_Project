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


	<jsp:include page="../test_main_top.jsp" />

	<c:if test="${empty sessionId }">
		<script type="text/javascript">
				window.location.replace("<%=request.getContextPath()%>/login.do?loginType=feed");
		</script>
	</c:if>


	<c:if test="${!empty sessionId }">

		<div class="main_con"></div>

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
							<th>음악커버</th>
							<th>작성자</th>
							<th>음악타이틀</th>
							<th>좋아요 수</th>
							<th>재생수</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="feedList" value="${feedList }" />
						<c:if test="${!empty feedList }">
							<c:forEach items="${feedList }" var="vo">
								<tr>
									<td><img src="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }" width="60" height="60"></td>
									<td><a href="<%=request.getContextPath() %>/user_main.do?user_id=${vo.getUser_id() }">${vo.getUser_nickname() }</a></td>
									<td><a href="<%=request.getContextPath() %>/user_music_content.do?id=${vo.getMusic_id() }">${vo.getMusic_title() }</a></td>
									<td>${vo.getMusic_likecnt() }</td>
									<td>${vo.getMusic_playcnt() }</td>
							</c:forEach>
						</c:if>
						<c:if test="${empty feedList }">
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
	</c:if>

	<!-- Add Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>