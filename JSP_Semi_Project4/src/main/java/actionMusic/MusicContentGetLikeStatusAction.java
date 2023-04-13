package actionMusic;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import action.Action;
import action.ActionForward;
import persistence.MusicDAO;
import model.*;

public class MusicContentGetLikeStatusAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		MusicDAO musicDAO = MusicDAO.getInstance();
		String user_id = request.getParameter("user_id");
		int music_id = Integer.parseInt(request.getParameter("music_id"));

		Map<String, Object> likeStatus = musicDAO.getLikeStatus(user_id, music_id);

		MusicVO music = (MusicVO) likeStatus.get("music");
        MusicLikesVO musicLikes = (MusicLikesVO) likeStatus.get("musicLikes");
		
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("like_count", music.getMusic_likecnt());
     

        if (musicLikes != null) {
            responseMap.put("is_liked", musicLikes.getIs_liked());
           
        } else {
            responseMap.put("is_liked", false);
         
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(responseMap));

        return null;
	}
}