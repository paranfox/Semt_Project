<%@page import="model.MusicVO"%>
<%@page import="persistence.MusicDAO"%>
<%@page import="java.util.List"%>
<%@page import="persistence.SlideDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>4undCLOUD</title>
<link rel="stylesheet" href="css/main.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<jsp:include page="test_main_top.jsp" />

	<br>
	<br>
	<br>
	<br>
	<br>


	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div class="music-player-container">
		<jsp:include page="mp3Player.jsp" />
	</div>

	<script type="module"
		src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule
		src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

<script type="text/javascript">

      function loadIframe(link) {
          const iframe = document.getElementById("contentIframe");
          if (iframe.style.visibility === "hidden") {
              iframe.style.visibility = "visible";
          } else {
              iframe.src = "<%=request.getContextPath()%>/user_music_list.do";
            iframe.style.display = "block";
         }
      }
      
      function loadMframe(link) {
         const iframe = document.getElementById("contentIframe");
         if (iframe.style.visibility === "hidden") {
             iframe.style.visibility = "visible";
         } else {
             const sessionId = '<%=session.getId()%>'; // 세션 아이디를 받아옵니다.
             iframe.src = "<%=request.getContextPath()%>/show_played_music.do?sessionId="
               + sessionId;
         iframe.style.display = "block";
      }
   }
</script>
</html>