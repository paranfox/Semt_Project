package actionForget;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.EmailHelper;
import persistence.UserDAO;

public class ForgetPwdCheckAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// id, name 확인 후 이메일 인증 페이지로 이동
		
		String user_name = request.getParameter("name").trim();
		String user_email = request.getParameter("email").trim();
		String user_id = request.getParameter("id").trim();
		
		UserDAO dao = UserDAO.getInstance();
		int check = dao.checkIdToEmail(user_id, user_email);;
		
	
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			EmailHelper emailHelper = EmailHelper.getInstance();
			String AuthenticationKey = emailHelper.sendAndGetCode(user_email);
					
			System.out.println(user_email);
			System.out.println(user_name);
			System.out.println(user_id);
			System.out.println(AuthenticationKey);
			
			request.setAttribute("code", AuthenticationKey);
			request.setAttribute("email", user_email);
			request.setAttribute("id", user_id);
			
			forward.setRedirect(false);
			forward.setPath("forget/forgetInputCode.jsp");
		}else if(check == -1) {
			out.println("<script>");
			out.println("alert('이름과 아이디를 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('가입되지않은 회원 입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}
}
