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
a {
	text-decoration: none;
	color: black;
}

#music_list_container {
	align-content: center;
	width: 60%;
	margin: 0 auto;
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
</head>
<body>


	<jsp:include page="../test_main_top.jsp" />

	
	
	<div id="music_list_container">
	
		<c:if test="${empty sessionId }">
			<script type="text/javascript">
					window.location.replace("<%=request.getContextPath()%>/login.do?loginType=feed");
			</script>
		</c:if>
		
		<c:set var="list" value="${feedList }" />
		<c:if test="${!empty list }">
			<c:forEach items="${list }" var="vo">

				<div class="music_content">
					<div class="music_cover">
						<img
							src="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }"
							data-mp3="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_mp3() }"
							data-album-title="${vo.getMusic_title() }"
							data-image="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }"
							width="60" height="60" class="album-image rounded-circle">
					</div>
					<div class="music_author">
						<a
							href="<%=request.getContextPath() %>/user_main.do?user_id=${vo.getUser_id() }">${vo.getUser_nickname() }</a>
					</div>
					&nbsp;
					<div>-</div>
					&nbsp;
					<div class="music_title">
						<a href="<%=request.getContextPath() %>/user_music_content.do?id=${vo.getMusic_id() }" class="goToContentBtn" data-album-id="${vo.getMusic_id()}">${vo.getMusic_title() }</a>
					</div>
					<div class="music_count">
						<img src="img/105220.png"><span>&nbsp;${vo.getMusic_likecnt() }</span>
					</div>
				</div>

			</c:forEach>
		</c:if>
		
		<c:if test="${empty list }">
				Seems a little quiet over here
		</c:if>
		
	</div>

</body>
</html>