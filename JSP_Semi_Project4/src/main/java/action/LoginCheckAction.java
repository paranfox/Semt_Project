package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserVO;
import persistence.UserDAO;

public class LoginCheckAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		if (id.equals("admin") && pwd.equals("admin")) {
			UserDAO dao = UserDAO.getInstance();
			int check = dao.logincheck(id, pwd);
			ActionForward forward = new ActionForward();
			PrintWriter out = response.getWriter();
			if (check == 1) {
				String user_nickname = dao.getUserNickname(id);
				HttpSession session = request.getSession();
				out.println("<script>");
				out.println("alert('[[관리자로 로그인]]')");
				out.println("</script>");
				forward.setRedirect(false);
				forward.setPath("/admin/AdminLoginOk.jsp");
				session.setAttribute("sessionId", id);
				session.setAttribute("user_nickname", user_nickname);
			}
		}

		UserDAO dao = UserDAO.getInstance();
		int check = dao.logincheck(id, pwd);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();

		if (check == 1) {
			String user_nickname = dao.getUserNickname(id);
			HttpSession session = request.getSession();
			out.println("<script>");
			out.println("alert('로그인 성공')");
			out.println("</script>");
//	    	out.println("location.href('LoginOk.jsp')");
			forward.setRedirect(false);
			forward.setPath("LoginOk.jsp");
			session.setAttribute("sessionId", id);
			session.setAttribute("user_nickname", user_nickname);
		} else if (check == 0) {
			out.println("<script>");
			out.println("alert('비밀번호를 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
//	    	forward.setRedirect(false);
//	    	forward.setPath("LoginMain.jsp");

		} else {
			out.println("<script>");
			out.println("alert('없는 아이디 입니다.')");
			out.println("history.back()");
			out.println("</script>");
//	    	forward.setRedirect(false);
//	    	forward.setPath("LoginMain.jsp");

		}

		return forward;
	}

}
