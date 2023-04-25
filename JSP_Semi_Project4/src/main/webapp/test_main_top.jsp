<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/main_top.css">


<header id="top">
	<div class="top">
		<ul>
				<li class="home"><a
				href="<%=request.getContextPath()%>/main.do">4운드 클라우드</a></li>
			<li class="feed"><a href="music_feed.do">FEED</a></li>
			<li class="library"><a href="http://www._____.com/About">LIBRARY</a></li>

			<li class="search"><a href="http://www._____.com/Project"> <input
					class="search-txt" type="text" placeholder=" 검색어를 입력해 주세요">&nbsp;
					<button class="search-btn" type="submit">검색</button>
			</a></li>

			<c:if test="${empty sessionId }">
				<li class="sign_in"><a href="<%=request.getContextPath() %>/login.do?loginType=normal">LOG IN</a></li>
				<li class="create_account"><a href="<%=request.getContextPath() %>/register.do">CREATE ACCOUNT</a></li>
				<li class="upload"><a href="<%=request.getContextPath() %>/upload_music.do">UPLOAD</a></li>
			</c:if>

					<%-- 로그인되었을 때 --%>
			<c:if test="${!empty sessionId }">
			<li class="upload"><a href="<%=request.getContextPath() %>/upload_music.do">UPLOAD</a></li>
			<li class="profile_top">
				<ul class="profile_inner">
						<img src="<%=request.getContextPath() %>/fileUpload/${sessionProfilePic }?ver=1" width="60" height="60">
						<a>${sessionNickname }</a>
						<li><a href="<%=request.getContextPath()%>/logout_check.do">로그아웃</a></li>
						<li><a href="<%=request.getContextPath()%>/my_page.do?num=${sessionId }">마이페이지</a></li>
						<li><a href="<%=request.getContextPath()%>/upload_music.do">앨범 등록</a></li>
						<li><a href="<%=request.getContextPath()%>/user_music_list.do" class="user_music_list">앨범리스트</a></li>
						<li><a href="<%=request.getContextPath()%>/my_music_list.do?id=${sessionId }">내가업로드한 파일</a></li>
						<li><a href="<%=request.getContextPath()%>/like_list.do">좋아요<br>플레이리스트</a></li>

				</ul>
			</li>
			</c:if>
		</ul>
	</div>
</header>