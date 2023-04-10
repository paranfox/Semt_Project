package actionMusic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.*;
import persistence.*;

public class MusicContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int album_id = Integer.parseInt(request.getParameter("id"));

		MusicDAO dao = MusicDAO.getInstance();

		MusicVO vo = dao.contentMusic(album_id);

		request.setAttribute("musicCont", vo);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("../musicBbs/music_content.jsp");

		return forward;
	}

}
