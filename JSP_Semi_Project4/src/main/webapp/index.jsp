<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Music Portal</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
#mp3PlayerContainer {
	position: fixed;
	bottom: 10px;
	right: 10px;
	z-index: 999;
}
</style>
</head>
<body>
	<header>
		<!-- Add your header content here -->
	</header>

	<div class="container">
		<div id="content">
			<!-- Content will be loaded here dynamically -->
		</div>
	</div>

	<div id="mp3PlayerContainer">
		<!-- Include your mp3Player.jsp here -->
		<%@ include file="mp3Player.jsp"%>
	</div>

	<footer>
		<!-- Add your footer content here -->
	</footer>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
	<script>
    function loadPage(url) {
      $.ajax({
        url: url,
        type: "GET",
        success: function (data) {
          $("#content").html(data);
        },
        error: function (xhr, status, error) {
          console.error("Error loading page:", error);
        },
      });
    }

    // Load the initial content
    loadPage('<%=request.getContextPath()%>
		/music_list.jsp');
	</script>
</body>
</html>