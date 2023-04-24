package actionMusic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.*;
import persistence.*;

public class PlayedMusicAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();

		String user_id = (String) session.getAttribute("sessionId");
		int music_id = Integer.parseInt(request.getParameter("music_id"));
		
		PlayedMusicVO vo = new PlayedMusicVO();
		vo.setUser_id(user_id);
		vo.setMusic_id(music_id);
		
		MusicDAO dao = MusicDAO.getInstance();
		
		
		boolean result = dao.savePlayedMusic(vo);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		if (result) {
			response.getWriter().write("{\"result\": \"success\"}");
		} else {
			response.getWriter().write("{\"result\": \"failure\"}");
		}
		
		return null;
	}
}