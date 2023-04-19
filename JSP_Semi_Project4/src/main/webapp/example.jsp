<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
<script type="text/javascript">
	function getLikeStatus() {
		$.ajax({
			url : 'getLikeStatus.do',
			type : 'GET',
			dataType : 'json',
			data : {
				user_id : '${sessionScope.sessionId}',
				music_id : '${vo.getMusic_id()}'
			},
			success : function(response) {
				if (response.is_liked) {
					$('#likeButton').addClass('btn-success');
				} else {
					$('#likeButton').removeClass('btn-success');
				}

				if (response.is_disliked) {
					$('#dislikeButton').addClass('btn-danger');
				} else {
					$('#dislikeButton').removeClass('btn-danger');
				}

				$('#likeCount').text(response.like_count);
				$('#dislikeCount').text(response.dislike_count);
			}
		});
	}

	getLikeStatus();
</script>
</html>
