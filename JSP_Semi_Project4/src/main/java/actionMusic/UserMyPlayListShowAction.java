package actionMusic;

import java.io.IOException;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.LikelistVO;
import persistence.MusicDAO;

public class UserMyPlayListShowAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// MY플레이 리스트를 찾아서 보여주는 비지니스 로직
		HttpSession session = request.getSession();
		ActionForward forward = new ActionForward();
		String user_id = (String) session.getAttribute("sessionId");

		MusicDAO dao = MusicDAO.getInstance();
		List<LikelistVO> list = dao.getMyPlayListshow(user_id);
		System.out.println("list >>>> " + list);
		request.setAttribute("myPlayList", list);

		forward.setRedirect(false);

		forward.setPath("/mypage/MyMusic_Listpage.jsp");

		return forward;

	}

}
