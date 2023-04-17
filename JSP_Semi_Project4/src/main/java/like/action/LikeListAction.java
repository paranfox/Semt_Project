package like.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.LikeVO;
import model.MusicVO;
import persistence.LikeDAO;

public class LikeListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//  사용자의 좋와요 리스트를 뽑아서 보내주는 비지니스 로직
		// contentLike(user_id);
		
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("sessionId");
		
		
		
		LikeDAO dao = LikeDAO.getInstance();
		
		List<MusicVO> list = dao.contentLike(user_id);
		
		
		request.setAttribute("user_likelist", list);
		
		
		forward.setRedirect(false);
		forward.setPath("user/user_like.jsp");
		
		return forward;

	}
}
