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

		PrintWriter out = response.getWriter();

		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		String type = request.getParameter("loginType").trim();
		
		UserDAO dao = UserDAO.getInstance();

		int check = dao.logincheck(id, pwd);
		UserVO vo = dao.userContent(id);
		UserVO vo1 = dao.getProfile_pic(id);
		String profile_pic = vo1.getUser_pic();
		System.out.println("유저 사진  >>>>  " + profile_pic);
		
		if (check == 1) {
			String user_nickname = vo.getUser_nickname();
			HttpSession session = request.getSession();
			session.setAttribute("sessionId", id);
			session.setAttribute("sessionUserVO", vo);
			session.setAttribute("sessionUserNickName", user_nickname);
			session.setAttribute("profile_pic", profile_pic);
			session.setMaxInactiveInterval(600*3000) ;
			
			if(type.equals("normal")) {
				out.println("<script>");
				out.println("alert('로그인 성공')");
				out.println("location.href='main.do'");
				out.println("</script>");
			} else if(type.equals("upload")) {
				out.println("<script>");
				out.println("location.href='upload_music.do'");
				out.println("</script>");
			} else if(type.equals("feed")) {
				out.println("<script>");
				out.println("location.href='music_feed.do'");
				out.println("</script>");
			}

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

		return null;
	}

}
