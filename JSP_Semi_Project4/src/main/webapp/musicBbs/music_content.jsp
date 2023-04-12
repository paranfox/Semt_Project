<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
        .comment-header {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .comment-content {
            margin-left: 45px;
        }
        
        .comment-divider {
            margin: 15px 0;
            border-bottom: 1px solid #ccc;
        }
        
        .user-nickname {
           margin-right: 8px;
        }
        
        .editBtn {
           border: 0;
           outline: none;
           font-size: 5px;
           margin: 5px;
           background: black;
           color: white;
           padding: 5px;
           cursor: pointer;
           border-radius: 5px;
        }
       
       .deleteBtn {
          border: 0;
           outline: none;
           font-size: 5px;
           margin: 5px;
           background: black;
           color: white;
           padding: 5px;
           cursor: pointer;
           border-radius: 5px;
       }       
</style>
</head>
<body>

   <div class="container mt-5">
     <div class="text-center">
      <c:set var="vo" value="${musicCont }" />
      <hr width="100%" color="tomato" align="center">
      <h3>${vo.getMusic_title() } ALBUM 상세페이지</h3>
      <hr width="100%" color="tomato" align="center">
      <br>

      <table class="table table-bordered table-striped">
         <tr>
            <th>ALBUM TITLE</th>
            <td>${vo.getMusic_title() }</td>
         </tr>

         <tr>
            <th>ALBUM COVER IMG</th>
            <td align="center"><img
               src="<%=request.getContextPath() %>/fileupload/${vo.getMusic_pic() }"
               width="60" height="60"></td>
         </tr>

         <tr>
            <th>ABOUT ALBUM</th>
            <td>${vo.getMusic_contents() }</td>
         </tr>

         <tr>
            <th>조회수</th>
            <td>${vo.getMusic_playcnt() }</td>
         </tr>

         <tr>
            <th>좋아요수</th>
            <td>${vo.getMusic_likecnt() }</td>
         </tr>

         <tr>
            <th>첨부파일</th>
            <c:if test="${!empty vo.getMusic_mp3() }">
               <td><a
                  href="<%=request.getContextPath()%>/fileupload/${vo.getMusic_mp3() }"
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
    
         <div class="d-grid gap-2 d-md-flex justify-content-md-center">
            <input class="btn btn-primary" type="button" value="글수정" onclick="location.href='upload_modify.do?uno=${dto.getUpload_no() }'">
            <input class="btn btn-danger" type="button" value="글삭제" onclick="if(confirm('게시글을 정말 삭제하시겠습니까?')) { location.href='upload_delete.do?uno=${dto.getUpload_no() }' }else { return; }">
            <input class="btn btn-info" type="button" value="전체목록" onclick="location.href='upload_list.do'">
        </div>
   </div>
   </div>
   
   
   <div id="commentForm" class="my-4">
       <h3 id="formTitle">댓글 작성</h3>
       <textarea id="commentContent" class="form-control" rows="2" cols="10"></textarea>
       <input type="hidden" id="commentId" value="">
       <button id="submitComment" class="btn btn-success mt-2">댓글 작성</button>
   </div>

    <div id="commentList">
        <h3>댓글 목록</h3>
        <ul id="commentListContainer" class="list-unstyled">
        </ul>
    </div>
</body>


<script>
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
                  
                 
                  let userPicImg = $('<img>').attr('src', '<%=request.getContextPath()%>/fileupload/' + comment.user_pic).css({
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
</script>

</html>