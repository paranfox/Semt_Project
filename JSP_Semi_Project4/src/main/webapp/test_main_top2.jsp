<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/main_top.css">

	<header id="top">
		<div class="top">
			<ul>
				<li class="home"><a href="main.do">4undCLOUD</a></li>
				<li class="feed"><a href="music_feed.do">FEED</a></li>
				<li class="library"><a href="best_like_list.do">LIBRARY</a></li>

				<!-- 원래 검색창이 있던 부분 -->
			
				<c:set value="${user }" var="list" />
				<c:set value="${sessionUserVO }" var="vo" />

				<%-- 로그인되지 않았을 때 --%>
				<c:if test="${empty vo }">
					<li class="sign_in"><a href="<%=request.getContextPath() %>/login.do?loginType=normal">LOG IN</a></li>
					<li class="account"><a href="register/RegisterChoice.jsp">CREATE ACCOUNT</a></li>
					<li class="upload"><a href="musicBbs/uploadsample.jsp">UPLOAD</a></li>
				</c:if>

				<%-- 로그인되었을 때 --%>
				<c:if test="${!empty vo }">
				
					<li class="upload"><a href="musicBbs/uploadsample.jsp">UPLOAD</a></li>
					
					<iframe id="contentIframe" frameborder="0" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;"></iframe>
					<iframe id="contentIframe" frameborder="0" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;"></iframe>
					<li class="nickname">
						
						 <a class="nick_cont"><img src="<%=request.getContextPath() %>/fileUpload/${profile_pic }">WELCOME ${vo.getUser_nickname() }</a>
						<ul class="profile_inner_1">
							<li><a href="musicBbs/uploadsample.jsp">PROFILE</a></li>
							
							<%-- <li><a href="<%=request.getContextPath()%>/my_music_list.do?id=${vo.getUser_id() }">FOLLOWING</a></li> --%>
							<li><a href="<%=request.getContextPath()%>/my_music_list.do?id=${vo.getUser_id() }">MY UPLOADED ALBUM</a></li>
							<li><a href="#" class="goToContentBtn" onclick="loadIframe(this);">SHOW ALL ALBUM</a></li>
							<li><a href="<%=request.getContextPath()%>/user_music_list.do" class="user_music_list">앨범리스트</a></li>
							<%-- <li><a href="<%=request.getContextPath()%>/user_myplaylist_show.do">MY<br>플레이리스트</a></li> --%>
							<li><a href="<%=request.getContextPath()%>/my_play_list.do?id=${vo.getUser_id() }">MY PLAYLIST</a></li> 
							<!-- <li><a href="#" class="goToContentBtn" onclick="loadMframe(this);">PLAYED ALBUM HISTORY</a></li> -->
							<li><a href="<%=request.getContextPath()%>/show_played_music.do?id=${vo.getUser_id() }">PLAYED HISTORY</a></li>						
						</ul>
					</li>
					<li class="settings">
					  <a class="settings-link" href="#"><ion-icon class="settings-outline" name="settings-outline"></ion-icon></a>
					  <ul class="profile_inner_2">
					    <li><a href="<%=request.getContextPath()%>/my_page.do?num=${vo.getUser_id() }">MYPAGE</a></li>
					    <li><a href="<%=request.getContextPath()%>/logout_check.do">LOGOUT</a></li>
					  </ul>
					</li> 
				</c:if>
			</ul>
		</div>
	</header>

