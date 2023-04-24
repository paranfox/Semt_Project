package actionMypage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.MusicDAO;

public class SearchDoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 검색어 입력
		String search = request.getParameter("find");
		String keyword = request.getParameter("keyword");
		
		System.out.println(search);
		System.out.println(keyword);
		
		MusicDAO dao = MusicDAO.getInstance();
		
		ArrayList<MusicVO> searchList = dao.searchMusicList(search, keyword);
		
		request.setAttribute("searchList", searchList);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("search/searchList.jsp");
		
		return forward;
	}

}
