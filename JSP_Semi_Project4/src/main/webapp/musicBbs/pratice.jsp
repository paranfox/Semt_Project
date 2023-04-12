<!DOCTYPE html>
<html>
<!-- 생략 -->
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!-- 생략 -->
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
    </style>
</head>
<body>
    <!-- 생략 -->
    <div id="commentList">
        <h3>댓글 목록</h3>
        <ul id="commentListContainer" class="list-unstyled">
        </ul>
    </div>
</body>

<script>
    $(document).ready(function () {
        // 생략
        $.ajax({
            // 생략
            success: function (data) {
                $.each(data, function (index, comment) {
                    let commentListItem = $('<li></li>');
                    // 생략
                    
                    let userNickNameSpan = $('<span class="user-nickname"></span>').text(comment.user_nickname + ': ');
                    // 생략

                    commentListItem.append(commentHeader).append(commentContent);
                    
                    // 생략
                    
                    commentListContainer.append(commentListItem);
                });
            }
        });
        // 생략
    });
</script>