<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UPLOAD MUSIC</title>
<link rel="stylesheet" href="../css/main_top.css">
<style type="text/css">

		#top {
			top:0;
		}
		
		body {
			margin-top: 15%;
		}

        .total {
            margin-left: 35%;
        }

        h3{
            width: 500px;
            padding: 5px;
            border: 2px solid #424242;
            background-color: #424242;
            color: white;
            text-align: center;
        }

        .file{
            display: flex;
            flex-direction: column;
        }

		.music_file,  .music_name, .music_pic, .music_title, .music_contents {
            display: flex;
            margin-bottom: 3%;
            width: 530px;
            margin-left: 13%;
        }

        .music_name imput, .music_title, .music_contents {
            width: 520px;

        }

        .music_contents {
            align-items: center;
        }
        .music_submit {
            width: 200px;
        }

        .btn-primary {
            width: 500px;
            padding: 5px;
            border: 2px solid #424242;
            background-color: #424242;
            color: white;
            font-size: medium;
            font-weight: bolder;
        }

       .btn-primary:hover {
            color: #FA0F97;
        }

</style>

</head>
<body>

	<jsp:include page="../test_main_top.jsp" />
 
    <div class="total">
		<form action="<%=request.getContextPath()%>/user_file.do" method="post"
			enctype="multipart/form-data">
			<c:set value="${sessionUserVO }" var="vo" />
			<input type="hidden" value="${vo.getUser_id() }">
          
            <div class="content">
                <h3>Insert Music File</h3>
                <div class="file">

                    <div class="music_name">
                        <input type="text" name="music_id" placeholder="음원 이름" class="form-control_1">
                    </div>

                    <div class="music_title">
                        <input type="text" name="music_title" placeholder="음원 제목" class="form-control_1">
                    </div>

                    <div class="music_contents">
                        <textarea class="form-control" rows="7" cols="25" name="music_contents" placeholder="음원 설명"></textarea>
                    </div>
                         

                    <div class="music_pic">
                        <div>앨범 사진</div>&nbsp;&nbsp;
                        <div><input
                                id="music_pic" type="file" class="form-control-file"
                                name="music_pic"></div>
                    </div>
                    
                    <div class="music_file">
                        <div>앨범 음원</div>&nbsp;&nbsp;
                        <div><input 
                            id="file" type="file" name="music_mp3"></div>
                    </div>

                    <div colspan="2" align="center" class="music_submit">
                        <input type="submit" value="음원 등록" class="btn btn-primary">
                    </div>
                </div>
            </div>
		</form>
	</div>	
 </body>
</html>