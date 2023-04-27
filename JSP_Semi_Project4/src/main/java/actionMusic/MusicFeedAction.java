package actionMusic;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.MusicDAO;

public class MusicFeedAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("sessionId");
		System.out.println(sessionId);

		MusicDAO dao = MusicDAO.getInstance();
		
		List<MusicVO> list = dao.getFeedList(sessionId);

		ActionForward forward = new ActionForward();

		request.setAttribute("feedList", list);
		forward.setRedirect(false);
		forward.setPath("view_music_feed.do");

		return forward;
	}
}
