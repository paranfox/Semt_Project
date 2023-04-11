<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td {
	text-aling: "center";
}
</style>
</head>
<body>
	<div align="center">
		<hr width="85%" color="red">
		<h3>Music List</h3>
		<hr width="85%" color="red">
		<br>

		<table border="1" cellspacing="0" width="85%">
			<tr bgcolor="#ffcc00">
				<th>앨범 제목</th>
				<th>앨범 이미지</th>
				<th>music_mp3(파일명)</th>
				<th>앨범 설명(contents)</th>
				<th>좋아요</th>
				<th>재생수</th>
				<th>상제 정보 들어가기</th>
				<th>수정 / 삭제</th>
			</tr>

			<c:set var="list" value="${musicList }" />
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="vo">
					<tr>
						<td align="center">${vo.getMusic_title() }</td>
						<td align="center"><img
							src="<%=request.getContextPath() %>/fileupload/${vo.getMusic_pic() }"
							width="60" height="60"></td>
						<td align="center">${vo.getMusic_mp3() }</td>
						<td align="center">${vo.getMusic_contents() }</td>
						<td align="center">${vo.getMusic_likecnt() }</td>
						<td align="center">${vo.getMusic_playcnt() }</td>
						<td align="center"><a
							href="<%=request.getContextPath() %>/user_music_content.do?id=${vo.getMusic_id() }">들어가기</a></td>
						<td align="center"><a
							href="<%=request.getContextPath() %>/admin_product_modify.do?pnum=${dto.getPnum() }">수
								정</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; <a
							href="<%=request.getContextPath() %>/admin_product_delete.do?pnum=${dto.getPnum() }">삭
								제</a></td>
					</tr>
				</c:forEach>

			</c:if>

			<c:if test="${empty list }">
				<tr>
					<td colspan="9" align="center">
						<h3>앨범 리스트가 없습니다.</h3>
					</td>
				</tr>
			</c:if>
		</table>

	</div>

</body>
</html>