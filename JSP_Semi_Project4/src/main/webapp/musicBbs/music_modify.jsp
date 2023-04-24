   <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정ALBUM상세페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/upload_modifyOk.do">

		
		<div align="center">
			<c:set var="vo" value="${modifyCont }" />
			<input type="hidden" name="music_id" value="${vo.getMusic_id() }">
			<hr width="50%" color="tomato">
			<h3>${vo.getMusic_title() }ALBUM상세페이지</h3>
			<hr width="50%" color="tomato">
			<br>
	
			<table border="1" cellspacing="0" width="500">
				<tr>
					<th>ALBUM TITLE</th>
					<td><input type="text" name="music_title" value="${vo.getMusic_title() }"></td>
				</tr>

				<tr>
					<th>ALBUM COVER IMG</th>
					<td>	
						<label for="music_pic">	앨범사진
						<input id="music_pic" type="file" name="music_pic"></label> 
					</td>
				</tr>
				
				<tr>
					<th>ABOUT ALBUM</th>
					<td><textarea cols="20" rows="4" name="music_album">${vo.getMusic_contents() }</textarea></td>
				</tr>
				
				<tr>
					<th>조회수</th>
					<td><input name="music_cnt" value="${vo.getMusic_playcnt() }" readonly> </td>
				</tr>
	
				<tr>
					<th>좋아요수</th>
					<td><input name="music_like" value="${vo.getMusic_likecnt() }" readonly></td>
				</tr>
	
				<tr>
					<th>첨부파일</th>
					<c:if test="${!empty vo.getMusic_mp3() }">
						<td><a
							href="<%=request.getContextPath()%>/fileUpload/${vo.getMusic_mp3() }"
							download="${vo.getMusic_mp3() }">다운로드</a></td>
					</c:if>
				</tr>
	
				<c:if test="${empty vo }">
					<tr>
						<td colspan="2" align="center">
							<h3>게시물 번호에 해당하는 게시물이 없습니다.....</h3>
						</td>
					</tr>
				</c:if>
			</table>
			<br> 
			 <input type="submit" value="글수정">
			&nbsp;&nbsp; 
			 <input type="reset" value="다시작성">
			
	</div>
</form>
</body>
</html>