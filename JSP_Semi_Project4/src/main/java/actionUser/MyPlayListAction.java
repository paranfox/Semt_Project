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

public class MyPlayListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 사용자의 좋와요 리스트를 뽑아서 보내주는 비지니스 로직
		// contentLike(user_id);
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("sessionId");
		PrintWriter out = response.getWriter();

		UserDAO dao = UserDAO.getInstance();

		int rowsize = 10; 
		int block = 3;
		int totalRecord = 0;
		int allPage = 0;
		int page = 0;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		} else {
			page = 1;
		}
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		int startBlock = (((page - 1) / block) * block) + 1;
		int endBlock = (((page - 1) / block) * block) + block;
		totalRecord = dao.getPageingCount(user_id);
		allPage = (int) Math.ceil(totalRecord / (double) rowsize);
		if (endBlock > allPage) { 
			endBlock = allPage;
		}
		
		List<MusicVO> pageList = dao.getPageingList(page, rowsize, user_id);
		dao.checkduplication(user_id);
		
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("my_playlist", pageList); 

		forward.setRedirect(false);

		forward.setPath("user/user_my_playlist.jsp");

		return forward;

	}

}
