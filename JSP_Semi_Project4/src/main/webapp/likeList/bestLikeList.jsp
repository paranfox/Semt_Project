<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>좋아요 LIST</title>
<style type="text/css">
	body {
		text-align: center;
	}
</style>
</head>
<body>

	<div>
		<hr width="85%" color="tomato" align="center">
			<h3>좋아요 LIST</h3>
		<hr width="85%" color="tomato" align="center">
		<br>
		
		<table align="center" border="2" cellspacing="0" width="85%">
			<thead>
				<tr>
					<th>좋아요</th>
					<th>앨범 제목</th>
					<th>앨범 이미지</th>
					<th>music_mp3(파일명)</th>
					<th>앨범 설명(contents)</th>
					<th>재생수</th>
				</tr>
			</thead>

			<tbody>
				<c:set var="likeList" value="${likeList}"/>
				<c:if test="${!empty likeList }">
					<c:forEach items="${likeList }" var="vo">
					<tr>
						<td>${vo.getMusic_likecnt() }</td>
						<td>${vo.getMusic_title() }</td>
						<td>${vo.getMusic_pic() }</td>
						<td>${vo.getMusic_mp3() }</td>
						<td>${vo.getMusic_contents() }</td>
						<td>${vo.getMusic_playcnt() }</td>
					</tr>
					</c:forEach>	
				</c:if>
			</tbody>
		</table>
	</div>

</body>
</html>