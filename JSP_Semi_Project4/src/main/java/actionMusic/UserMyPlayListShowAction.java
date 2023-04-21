package actionMusic;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.MusicDAO;

public class UserMyPlayListShowAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// MY플레이 리스트를 찾아서 보여주는 비지니스 로직
		
		String user_id = request.getParameter("id");
		MusicDAO dao = MusicDAO.getInstance();
		List<LikelistVO> list = dao.getMyPlayListshow(user_id);

		request.setAttribute("myMusicList", list);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("/user/");

		return forward;

	}

}
