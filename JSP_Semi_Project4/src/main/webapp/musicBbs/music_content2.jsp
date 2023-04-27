<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    
<style>
#container {
	align-content: center;
	width: 70%;
	margin: 0 auto;
	position: relative;
}

#music_container {
	background-color: rgb(226, 226, 226);
	padding: 10px 5px 0px 5px;
	height: 230px;
}

#music_part1 {
	padding: 0 10px;
	width: 300px;
}

#music_title {
	font-size: 1.5em;
	white-space: nowrap;
}

#user_name {
	font-size: 1.1em;
	color: rgb(77, 76, 76);
	white-space: nowrap;
}

#music_part1_icons {
	position: relative;
	font-size: 28px;
}

#play_icon {
	font-size: 60px;
}

#music_cont {
	display: flex;
}

#music_items {
	width: 50%;
}

#music_content {
	width: 100%;
	white-space: nowrap;
	padding-left: 30px;
}

#icon_cont {
	padding-top: 100px;
	display: flex;
}

#like_icon {
	font-size: 30px;
	padding-top: 25px;
	padding-left: 15px;
}

#like_count {
	font-size: .86em;
	padding: 4px 0 0 0;
	padding-top: 32px;
}

#music_con_container {
	display: flex;
	top: 170px;
	padding: 10px;
}

#music_cover {
	height: 200px;
}

#music_cover img {
	width: 200px;
	height: 200px;
}

#play_icon img {
	width: 50px;
	height: 50x;
}

#bbs_container {
	display: flex;
	padding: 30px 0 0 0;
}

#user_container {
	width: 150px;
	text-align: center;
	padding-right: 15px;
}

#user_pic img {
	object-fit: cover;
	border-radius: 50%;
	width: 140px;
	height: 140px;
}

.fol_count {
	margin: 0px;
	padding: 0px;
	display: flex;
	/* border: 1px solid; */
	font-size: .8em;
}

.fol_count img {
	width: 12px;
	height: 13px;
	padding-left: 35px;
	/* border: 1px solid; */
	opacity: .5;
}

#comment_container {
	width: 100%;
	padding-left: 30px;
}

/* search 검색창~ */
#write_wrap {
	display: flex;
	width: 100%;
	height: 50px;
}

#write_con_wrap {
	height: 29px;
	width: 100%;
	/* border: #000000 1px solid; */
	background-color: rgb(219, 219, 219);
	display: flex;
}

#comment_write {
	font-size: 1em;
	width: 100%;
	height: 27px;
	border: 0px;
	outline: invert;
	outline-offset: -3px;
	background-color: rgb(219, 219, 219);
	padding-left: 10px;
}

#comment_write p {
	background-color: transparent;
	right: 1;
}

#enter {
	font-size: 1.1em;
	cursor: pointer;
	padding: 5px;
	background-color: transparent;
}

.visitor_pic img {
	object-fit: cover;
	border-radius: 50%;
	width: 40px;
	height: 40px;
}

.comment_list {
	display: inline-block;
	width: 100%;
	border-bottom: 1px solid rgb(214, 214, 214);
}

.comment_list:hover {
	background-color: rgb(235, 235, 235);
}

.visitor_pic {
	float: left;
}

.visit_1 {
	float: left;
}

.visitor_nick {
	color: rgb(137, 137, 137);;
}

.visit_2 {
	float: right;
	color: rgb(137, 137, 137);;
}

.comment_btn {
	display: flex;
}
</style>
<head>
<meta charset="UTF-8">
<title>ALBUM 상세페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
const audioPlayer = document.querySelector("#audioPlayer");

function handleClickPlayButton(event) {
     const mp3Path = event.target.dataset.mp3;
     const albumTitle = event.target.dataset.albumTitle;
     const albumImage = event.target.dataset.image;
     const audioPlayer = document.getElementById("audioPlayer");
     
     audioPlayer.querySelector("source").src = mp3Path;
     audioPlayer.load();
     audioPlayer.play();

     document.getElementById("albumTitle").textContent = albumTitle;
     document.getElementById("albumImage").src = albumImage;
   }
   
document.addEventListener("DOMContentLoaded", function () {
     const playButtons = document.getElementsByClassName("playMusicBtn");
     for (let i = 0; i < playButtons.length; i++) {
       playButtons[i].addEventListener("click", handleClickPlayButton);
     }
   });
</script>
</head>
<body>
	<div id="container">

        <div id="music_container">
            <div id="music_con_container">
                <div id="music_cover"><img
                    src="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }"></div>
                <div id="music_part">
                    <div id="contents">
                        <div id="music_cont">
                            <div id="music_items">
                                <div id="music_title">${vo.getMusic_title() }</div>
                                <div id="user_name">${vo.getUser_nickname() }</div>
                            </div>
                            <div id="music_content">${vo.getMusic_contents() }</div>
                        </div>
                        <div id="icon_cont">
                            
                            <div id="play_icon" 
                                data-mp3="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_mp3() }"
								data-album-title="${vo.getMusic_title() }"
								data-image="<%=request.getContextPath() %>/fileUpload/${vo.getMusic_pic() }">
                                <ion-icon name="play-circle-outline"></ion-icon>
                            </div>
                            <div id="like_icon"><ion-icon name="heart-circle-outline"></ion-icon></div>

                            <c:if test="${!empty sessionId && sessionId == vo.getUser_id() }">
                                    <input type="button" value="글수정" onclick="location.href='upload_modify.do?uno=${vo.getMusic_id() }'">
                                    <input type="button" value="글삭제" onclick="if(confirm('게시글을 정말 삭제하시겠습니까?')) { location.href='upload_delete.do?id=${vo.getMusic_id() }' }else { return; }">
                                    <input type="button" value="전체목록" id="closeContentBtn">
                                </div>
                            </c:if>

                            <div id="likeButton">${vo.getMusic_likecnt() }</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        

        <div id="bbs_container">
            <div id="user_container">
                <div id="user_pic"><img src="images.jpg" alt=""></div>
                <div id="user_nickname">user nickname</div>
                <div id="user_info">
                    <div id="user_info_top">
                        <div class="fol_count"><img src="followers-icon-png-1.jpg"> <span>122 follower</span></div>
                        <div id="followBtn"><button>FOLLOW</button></div>
                    </div>
                </div>
            </div>
            
            <div id="comment_container">
                <div id="write_wrap">
                    <div id="write_con_wrap">
                        <input id="commentContent" type="text" placeholder="write a comment">
                        <div id="submitComment">
                            <ion-icon name="return-down-back-sharp"></ion-icon></p>
                        </div>
                    </div>
                </div>
    
                <div class="comment_list">
                    <ul id="commentListContainer"></ul>
                </div>
            </div>
        </div>
</body>
<script>
$(document).ready(function() {
   
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
   
function getLikeStatus() {
    $.ajax({
        url: 'getLikeStatus.do',
        type: 'GET',
        dataType: 'json',
        data: {
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
                $('#dislikeButton').addClass('btn-success');
            } else {
                $('#dislikeButton').removeClass('btn-success');
            }

            $('#likeCount').text(response.like_count); // 좋아요 수 업데이트
            $('#dislikeCount').text(response.dislike_count);
        }
    });
}

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
        
        $("#closeContentBtn").on("click", function() {
            $("#contentContainer").hide();
        });
        
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
</script>
</html>