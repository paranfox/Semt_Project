package actionLogin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;

public class LogoutCheckAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		session.invalidate();
		PrintWriter out = response.getWriter();
		forward.setRedirect(false);
		forward.setPath("main.jsp");
		return forward;
	}
}
