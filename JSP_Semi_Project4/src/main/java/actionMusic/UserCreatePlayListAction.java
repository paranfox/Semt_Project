package actionMusic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.PlaylistVO;
import persistence.PlaylistDAO;

public class UserCreatePlayListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String playlistName = request.getParameter("playlist_name");
		String userId = request.getParameter("user_id");

		PlaylistVO newPlaylist = new PlaylistVO(userId, playlistName);
		PlaylistDAO dao = PlaylistDAO.getInstance();

		int result = dao.createPlaylist(newPlaylist);

		// 결과를 JSON 형식으로 반환합니다.
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print("{\"success\": " + result + "}");

		return null;
	}

}