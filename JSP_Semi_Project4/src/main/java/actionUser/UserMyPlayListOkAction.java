package actionUser;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.LikelistVO;
import persistence.MusicDAO;

public class UserMyPlayListOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 플레이 리스트를 보여주는 비지니스 로직
		// 단 만들어진 플레이리스트만 보여주고 없으면 안보여 준다 
		
		String user_id = request.getParameter("id");
		String list_name = request.getParameter("my_play_listname");
		int music_id = Integer.getInteger(request.getParameter("music_id"));
		
		MusicDAO dao = MusicDAO.getInstance();
		int check = dao.getMyPlayList(user_id, list_name, music_id);


		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('MY 플레이리스트 작성 성공!!!')"); 
			out.println("location.href='user_myplaylist_show.do'");
			out.println("</script>");
		}else if(check == -1) {
			out.println("<script>");
			out.println("alert('MY 플레이리스트에 이름이 중복 됩니다.')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('MY 플레이리스트 작성안됨.')");
			out.println("history.back()");
			out.println("</script>");
		}	

		return null;
	}

}
