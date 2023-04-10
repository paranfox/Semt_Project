package actionMusic;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
import persistence.*;
import action.Action;
import action.ActionForward;
import persistence.MusicDAO;
import model.MusicVO;

public class MusicListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		MusicDAO dao = MusicDAO.getInstance();

		List<MusicVO> list = dao.getMusicList();

		request.setAttribute("musicList", list);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("../musicBbs/music_list.jsp");

		return forward;

	}

}
