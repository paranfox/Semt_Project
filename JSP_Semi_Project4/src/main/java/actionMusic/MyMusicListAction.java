package actionMusic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import java.util.*;
import persistence.*;
import model.*;

public class MyMusicListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String user_id = request.getParameter("id");
		MusicDAO dao = MusicDAO.getInstance();
		List<MusicVO> list = dao.getMyMusicList(user_id);

		request.setAttribute("myMusicList", list);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("/mypage/myMusic_List.jsp");

		return forward;

	}

}
