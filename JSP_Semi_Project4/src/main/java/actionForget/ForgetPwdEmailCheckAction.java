package actionForget;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.UserDAO;

public class ForgetPwdEmailCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//	<input type="hidden" name="true_code" value="${param.code }">
		//<input type="hidden" name="email" value="${param.email }">
		
		String true_code = request.getParameter("true_code").trim();
		String input_code = request.getParameter("input_code").trim();
		String user_email = request.getParameter("user_email").trim();
		
		
		
		UserDAO dao = UserDAO.getInstance();
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(true_code != null) {
			
			if (true_code.equals(input_code)) {
				String user_id = dao.findUserId(user_email);
				request.setAttribute("userId", user_id);
				
				System.out.println("true_code >>> "+ true_code);
				System.out.println("user_email >>> "+ user_email);
				System.out.println("user_id >>> "+user_id);

				forward.setRedirect(false);
				forward.setPath("forget/forgetIdResult.jsp");
			} else {
				out.println("<script>");
				out.println("alert('인증코드를 다시 확인해주세요.')");
				out.println("history.back()");
				out.println("</script>");
			}
		}else {
			out.println("<script>");
			out.println("alert('인증코드가 없습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		
		return forward;
	}

}
