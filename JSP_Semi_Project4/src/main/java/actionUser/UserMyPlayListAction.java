package actionUser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.MusicDAO;

public class UserMyPlayListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 재생목록을 만들면서 노래가 들어가도록 만드는 로직
		// 앞에서 노래가 없을 시 작동이 안되는 로직을 짜면 좋을 듯


		MusicVO vo = new MusicVO();

		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("sessionId");
		String my_play_list = request.getParameter("my_play_list");
		String my_play_mp3 = request.getParameter("my_play_mp3");
		
		vo.setMusic_mp3(my_play_list);
		vo.setMusic_pic(my_play_mp3);
		vo.setUser_id(user_id);

		MusicDAO dao = MusicDAO.getInstance();
		int check = dao.insertFile(vo);

		PrintWriter out = response.getWriter();

		if (check > 0) {
			out.println("<script>");
			out.println("alert('[앨범 등록 성공]')");
			out.println("location.href='user_music_list.do'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('[앨범 등록 실패]')");
			out.println("history.back()");
			out.println("</script>");
		}

		return null;

		
	}

}
