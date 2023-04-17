package actionUser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.UserDAO;

public class UserSocialEmailCheckAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//RegisterSocial.jsp
		ActionForward forward = new ActionForward();
		String social_id = request.getParameter("social_id").trim();
		String social_pwd = request.getParameter("social_pwd").trim();
		String social_nickname = request.getParameter("social_nickname").trim();
		String social_email = request.getParameter("social_email").trim();
		
		UserDAO dao = UserDAO.getInstance();
		int check = dao.checkEmailExist(social_email);
		System.out.println(check);
		PrintWriter out = response.getWriter();
		
		if(check == 0) {
			request.setAttribute("social_id", social_id);
			request.setAttribute("social_pwd", social_pwd);
			request.setAttribute("social_nickname", social_nickname);
			request.setAttribute("social_email", social_email);
			
			forward.setRedirect(false);
			forward.setPath("RegisterSocial.jsp");
			
		} else if(check == 1) {
			out.println("<script>");
			out.println("alert('등록된 이메일 입니다. 로그인 하세요.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('회원 가입 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
				
		
		
		return forward;
	}
}
