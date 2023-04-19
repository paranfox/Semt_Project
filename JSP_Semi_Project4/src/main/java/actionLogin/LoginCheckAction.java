package actionLogin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
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

		if (check == 1) {
			UserVO vo = dao.userContent(id);
			String profile_pic = vo.getUser_pic();
			System.out.println("유저 사진  >>>>  " + profile_pic);

			HttpSession session = request.getSession();
			session.setAttribute("sessionId", id);
			session.setAttribute("sessionUserVO", vo);
			session.setAttribute("sessionUserNickname", vo.getUser_nickname());
			session.setAttribute("profile_pic", profile_pic);

			session.setMaxInactiveInterval(60*300) ;
			/*
			 * out.println("<script>"); out.println("alert('로그인 성공')");
			 * out.println("location.href='../main.jsp'"); out.println("</script>");
			 */

	    	forward.setRedirect(true);
	        forward.setPath("main.do");
		} else if (check == 0) {
			out.println("<script>");
			out.println("alert('비밀번호를 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");

		} else {
			out.println("<script>");
			out.println("alert('등록되지 않은 회원입니다.')");
			out.println("history.back()");
			out.println("</script>");

		}

		return forward;
	}

}
