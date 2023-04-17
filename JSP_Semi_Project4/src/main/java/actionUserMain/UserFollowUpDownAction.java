package actionUserMain;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.FollowsDAO;

public class UserFollowUpDownAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int status = Integer.parseInt(request.getParameter("status").trim());
		String session_id = request.getParameter("session_id").trim();
		String bbs_id = request.getParameter("bbs_id").trim();
		System.out.println(status);
		System.out.println(session_id);
		System.out.println(bbs_id);
		
		
		FollowsDAO dao = FollowsDAO.getInstance();

		int check = dao.followUpDown(status, session_id, bbs_id);

		request.setAttribute("check", check);

		PrintWriter out = response.getWriter();

		out.println(check);

		return null;
	}
}
