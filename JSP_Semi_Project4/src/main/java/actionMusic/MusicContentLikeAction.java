package actionMusic;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import model.MusicLikesVO;
import persistence.MusicDAO;

public class MusicContentLikeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("sessionId");
		int music_id = Integer.parseInt(request.getParameter("music_id"));

		try {
			MusicDAO musicDAO = MusicDAO.getInstance();
			MusicLikesVO musicLikes = musicDAO.getMusicLikesByUserIdAndMusicId(user_id, music_id);

			if (musicLikes == null) {
				musicLikes = new MusicLikesVO();
				musicLikes.setUser_id(user_id);
				musicLikes.setMusic_id(music_id);
				musicLikes.setIs_liked(true);
				musicLikes.setIs_disliked(false);
			} else {
				musicLikes.setIs_liked(!musicLikes.isIs_liked());
				musicLikes.setIs_disliked(false);
			}

			boolean isUpdated = musicDAO.toggleLike(musicLikes);

			if (isUpdated) {
				MusicVO music = musicDAO.contentMusic(music_id);
				music.setMusic_likecnt(music.getMusic_likecnt() + (musicLikes.isIs_liked() ? 1 : -1));
				musicDAO.updateMusic(music);
			}

			// JSON 응답을 반환합니다.
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print("{\"result\":\"" + (isUpdated ? "success" : "failure") + "\"}");
			out.flush();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null; // JSON 응답을 반환하는 경우 ActionForward 객체는 필요하지 않습니다.
	}
}