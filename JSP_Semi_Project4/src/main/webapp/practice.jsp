<div class="album-image-container">
  <img
    src="<%=request.getContextPath() %>/fileUpload/<%= music.getMusic_pic() %>"
    class="album-image d-block mx-auto my-3" style="max-width: 20%;"
    alt="<%=music.getMusic_title()%>"
    data-mp3="<%=request.getContextPath() %>/fileUpload/<%=music.getMusic_mp3() %>"
    data-album-title="<%=music.getMusic_title() %>"
    width="250" height="250"
    data-image="<%=request.getContextPath() %>/fileUpload/<%=music.getMusic_pic() %>">
  <div class="play-icon">
   <i class="fas fa-play"></i>
  </div>
</div>