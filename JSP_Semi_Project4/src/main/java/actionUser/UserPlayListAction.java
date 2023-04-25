package actionUser;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.UserDAO;

public class UserPlayListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 사용자의 좋와요 리스트를 뽑아서 보내주는 비지니스 로직
		// contentLike(user_id);
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("sessionId");
		String name = request.getParameter("name");
		//int lank = Integer.getInteger(request.getParameter("list"));
		//System.out.println("lank >>>"+lank);
		UserDAO dao = UserDAO.getInstance();
		
		List<MusicVO> pageList = dao.getMusicPlayList(user_id, name);
		
		request.setAttribute("my_playlist", pageList); 
		forward.setRedirect(false);
		forward.setPath("user/user_my_playlist.jsp");
		return forward;

	}

}
