package actionLikeList;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.LikeVO;
import model.MusicLikesVO;
import model.MusicVO;
import persistence.BestLikeDAO;
import persistence.LikeDAO;

public class BestLikeListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	
		BestLikeDAO dao = BestLikeDAO.getInstance();
		
		List<MusicVO> list = dao.getlikeList();
		
		request.setAttribute("likeList", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("likeList/bestLikeList.jsp");
		
		return forward;
	}

}
