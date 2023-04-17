// like.js
$(document).ready(function() {
	function getLikeStatus() {
		$.ajax({
			url: 'getLikeStatus.do',
			type: 'GET',
			dataType: 'json',
			data: {
				user_id: '${sessionScope.sessionId}',
				music_id: '${vo.getMusic_id()}'
			},
			success: function(response) {
				if (response.is_liked) {
					$('#likeButton').addClass('btn-success');
				} else {
					$('#likeButton').removeClass('btn-success');
				}

				if (response.is_disliked) {
					$('#dislikeButton').addClass('btn-success');
				} else {
					$('#dislikeButton').removeClass('btn-success');
				}

				$('#likeCount').text(response.like_count); // 좋아요 수 업데이트
				$('#dislikeCount').text(response.dislike_count);
			}
		});
	}

	$('#likeButton').click(function() {
		$.ajax({
			url: 'toggleLike.do',
			type: 'POST',
			dataType: 'json',
			data: {
				user_id: '${sessionScope.sessionId}',
				music_id: '${vo.getMusic_id()}'
			},
			success: function(response) {
				if (response.result === 'success') {
					getLikeStatus();
				} else {
					alert('좋아요를 누르지 못했습니다.');
				}
			}
		});
	});

	$('#dislikeButton').click(function() {
		$.ajax({
			url: 'toggleDislike.do',
			type: 'POST',
			dataType: 'json',
			data: {
				user_id: '${sessionScope.sessionId}',
				music_id: '${vo.getMusic_id()}'
			},
			success: function(response) {
				if (response.result === 'success') {
					getLikeStatus();
				} else {
					alert('싫어요를 누르지 못했습니다.');
				}
			}
		});
	});

	getLikeStatus();
});