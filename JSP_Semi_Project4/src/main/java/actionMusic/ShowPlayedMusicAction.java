package actionMusic;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.*;
import persistence.*;

public class ShowPlayedMusicAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		MusicDAO dao = MusicDAO.getInstance();
		
		PlayedMusicVO vo = new PlayedMusicVO();
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("sessionId");
		
		List<PlayedMusicVO> list = dao.getPlayedMusicList(sessionId);
		
		request.setAttribute("musicList", list);
		
		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("/mypage/played_music_list.jsp");

		return forward;
	}

}
