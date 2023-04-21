package actionSample;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.LikeDAO;

public class SampleAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	ActionForward forward = new ActionForward();
	HttpSession session = request.getSession();
	String user_id = (String)session.getAttribute("sessionId");
	
	LikeDAO dao = LikeDAO.getInstance();
	
	List<MusicVO> likeList = dao.getmusiclist(user_id);
	
	request.setAttribute("user_likelist", likeList);
	
	forward.setRedirect(false);
	forward.setPath("sample2.jsp");
	
	return forward;
	}

}
