package actionUserMain;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.FollowsDAO;

public class UserFollowerCountAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String bbs_id = request.getParameter("bbs_id").trim();
		System.out.println("팔로우 카운트 id : " +bbs_id);
		
		FollowsDAO dao = FollowsDAO.getInstance();
		
		int count = dao.getFollowersCount(bbs_id);
		
		request.setAttribute("count", count);
		
		PrintWriter out = response.getWriter();
		
		out.println(count);
		
		return null;
	}
}
