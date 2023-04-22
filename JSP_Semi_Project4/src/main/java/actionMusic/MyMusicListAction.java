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
		// 리스트값을 가져오고 아이디도 가져와서 music_id로 DB에서
		// 자료를 가져와서 보여주는 비지니스 로직
		
		
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
