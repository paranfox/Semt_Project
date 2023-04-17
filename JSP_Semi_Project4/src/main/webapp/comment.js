// comment.js

$(document).ready(function() {
	function loadComments() {

		let commentListContainer = $('#commentListContainer');
		commentListContainer.empty();

		$.ajax({
			url: 'musicContentCommentsList.do',
			type: 'GET',
			dataType: 'json',
			data: { album_id: '${vo.getMusic_id()}' },
			success: function(data) {
				$.each(data, function(index, comment) {
					let commentListItem = $('<li></li>');

					let commentHeader = $('<div class="comment-header"></div>');


					let userPicImg = $('<img>').attr('src', '<%=request.getContextPath()%>/fileUpload/' + comment.user_pic).css({
						'width': '30px',
						'height': '30px',
						'border-radius': '70%',
						'margin-right': '5px'
					});
					let userNickNameSpan = $('<span class="user-nickname"></span>').text(comment.user_nickname);

					let userCreatedAtSpan = $('<span></span>').text(comment.created_at);

					commentHeader.append(userPicImg).append(userNickNameSpan).append(userCreatedAtSpan);

					let commentContent = $('<div class="comment-content"></div>');
					let contentSpan = $('<span></span>').text(comment.content);
					let editBtn = $('<button class = "editBtn"></button>').text('수정');
					if (comment.user_id !== '${sessionScope.sessionId}') {
						editBtn.hide();
					}
					let deleteBtn = $('<button = class="deleteBtn"></button>').text('삭제');

					if (comment.user_id !== '${sessionScope.sessionId}') {
						deleteBtn.hide();
					}
					editBtn.click(function() {

						let originalContent = contentSpan.text();

						contentSpan.hide();

						let contentInput = $('<input>').attr('type', 'text').val(originalContent);
						contentSpan.after(contentInput);

						editBtn.text('수정 완료').off('click').on('click', function() {
							let newContent = contentInput.val();
							if (newContent) {
								$.ajax({
									url: 'musicContentCommentsUpdate.do',
									type: 'POST',
									dataType: 'json',
									data: { comment_id: comment.comment_id, content: newContent },
									success: function(response) {
										if (response.result === "success") {
											contentSpan.text(newContent).show();
											contentInput.remove();
											editBtn.text('수정').off('click').on('click', updateComment);
											loadComments();
										} else {
											alert('댓글 수정에 실패했습니다.');
										}
									}
								});
							}
						});
					});

					function updateComment() {
						let newContent = $('#commentContent').val();
						let commentId = $('#commentId').val();

						if (newContent) {
							$.ajax({
								url: 'musicContentCommentsUpdate.do',
								type: 'POST',
								dataType: 'json',
								data: { comment_id: commentId, content: newContent },
								success: function(response) {
									if (response.result === "success") {
										loadComments();
										$('#formTitle').text('댓글 작성');
										$('#commentContent').val('');
										$('#commentId').val('');
										$('#submitComment').text('댓글 작성');
										$('#submitComment').off('click').on('click', submitComment);
									} else {
										alert('댓글 수정에 실패했습니다.');
									}
								}
							});
						}
					}
					deleteBtn.click(function() {
						if (confirm('댓글을 정말 삭제하시겠습니까?')) {
							$.ajax({
								url: 'musicContentCommentsDelete.do',
								type: 'POST',
								dataType: 'json',
								data: { comment_id: comment.comment_id },
								success: function(response) {
									if (response.result === "success") {
										loadComments();
									} else {
										alert('댓글 삭제에 실패했습니다.');
									}
								}
							});
						}
					});
					commentContent.append(contentSpan).append(editBtn).append(deleteBtn);

					commentListItem.append(commentHeader).append(commentContent);

					if (index < data.length - 1) {
						let commentDivider = $('<div class="comment-divider"></div>');
						commentListItem.append(commentDivider);
					}
					commentListContainer.append(commentListItem);
				});
			}
		});
	}
	loadComments();
	function submitComment() {
		let content = $('#commentContent').val();
		$.ajax({
			url: 'musicContentComments.do',
			type: 'POST',
			dataType: 'json',
			data: { album_id: '${vo.getMusic_id()}', content: content },
			success: function(response) {
				if (response.result === "success") {
					loadComments();
					$('#commentContent').val('');
				} else {
					alert('댓글 작성에 실패했습니다.');
				}
			}
		});
	}
	$('#submitComment').click(submitComment);
});