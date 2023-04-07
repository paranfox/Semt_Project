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

		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();

		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		UserDAO dao = UserDAO.getInstance();

		int check = dao.logincheck(id, pwd);
		UserVO vo = dao.userContent(id);
		
		
		if (check == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("sessionId", id);
			session.setAttribute("sessionUserVO", vo);
			out.println("<script>");
			out.println("alert('로그인 성공')");
			out.println("location.href='main.jsp'");
			out.println("</script>");
			
//	    	forward.setRedirect(false);
//	        forward.setPath("LoginOk.jsp");
		} else if (check == 0) {
			out.println("<script>");
			out.println("alert('비밀번호를 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");

		} else {
			out.println("<script>");
			out.println("alert('없는 아이디 입니다.')");
			out.println("history.back()");
			out.println("</script>");

		}

		return null;
	}

}
