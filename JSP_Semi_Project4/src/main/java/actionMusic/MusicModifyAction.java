package actionMusic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.*;
import model.*;
import java.util.*;

public class MusicModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int album_id = Integer.parseInt(request.getParameter("uno"));

		MusicDAO dao = MusicDAO.getInstance();

		MusicVO vo = dao.contentMusic(album_id);

		request.setAttribute("modifyCont", vo);
		
		System.out.println("album_id = " + vo.getMusic_id());

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("musicBbs/music_modify.jsp");

		return forward;
	}

}
