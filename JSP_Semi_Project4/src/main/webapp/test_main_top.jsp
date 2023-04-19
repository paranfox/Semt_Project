<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/main_top.css">


<header id="top">
	<div class="top">
		<ul>
			<li class="home"><a href="<%=request.getContextPath() %>/main.do">4운드 클라우드</a></li>
			<li class="feed"><a href="http://www._____.com/About">feed</a></li>

			<li class="search"><a href="http://www._____.com/Project"> <input
					class="search-txt" type="text" placeholder=" 검색어를 입력해 주세요">&nbsp;
					<button class="search-btn" type="submit">검색</button>
			</a></li>
			<!-- <li class="pay"><a href="http://www._____.com/Travel">이용권</a></li> -->
			<li class="profile_top">
				<ul class="profile_inner">

					<%-- 로그인되었을 때 --%>
					<c:set value="${user }" var="list" />
					<c:set value="${sessionUserVO }" var="vo" />

					<c:if test="${!empty vo }">
						<img
							src="<%=request.getContextPath() %>/fileUpload/${vo.getUser_pic() }?ver=1"
							width="60" height="60">
						<a>${vo.getUser_nickname() }</a>
						<li><a href="<%=request.getContextPath()%>/logout_check.do">로그아웃</a></li>
						<li><a
							href="<%=request.getContextPath()%>/my_page.do?num=${vo.getUser_id() }">마이페이지</a></li>
						<li><a href="<%=request.getContextPath() %>/upload_music.do">앨범 등록</a></li>
						<li><a
							href="<%=request.getContextPath()%>/user_music_list.do">앨범리스트</a></li>
						<li><a
							href="<%=request.getContextPath()%>/my_music_list.do?id=${vo.getUser_id() }">내가
								업로드한 파일</a></li>
						<li><a href="<%=request.getContextPath()%>/like_list.do">좋아요<br>플레이리스트
						</a></li>
					</c:if>

					<c:if test="${empty vo }">
						<%-- 로그인되지 않았을 때 --%>
						<a>프로필</a>
						<li><a href="<%=request.getContextPath() %>/login.do">로그인</a></li>
						<li><a href="<%=request.getContextPath() %>/register.do">회원가입</a></li>
						<li><a
							href="<%=request.getContextPath()%>/user_music_list.do">앨범리스트</a></li>
					</c:if>
				</ul>
			</li>
		</ul>
	</div>
</header>