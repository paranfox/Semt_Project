package actionForget;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.UserDAO;

public class ForgetEmailCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//	<input type="hidden" name="true_code" value="${param.code }">
		//<input type="hidden" name="email" value="${param.email }">
		
		String true_code = request.getParameter("true_code").trim();
		String input_code = request.getParameter("input_code").trim();
		String user_email = request.getParameter("user_email").trim();
		String type = request.getParameter("type").trim();
		String user_id = "";
		
		
		UserDAO dao = UserDAO.getInstance();
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(true_code != null) {
			System.out.println("true_code >>> "+ true_code);
			System.out.println("user_email >>> "+ user_email);
			
			if (true_code.equals(input_code)) {
				
				if(type.equals("아이디찾기")) {
					user_id = dao.findUserId(user_email);
					request.setAttribute("userId", user_id);
					
					System.out.println("user_id >>> "+user_id);
					
					forward.setRedirect(false);
					forward.setPath("forget/forgetIdResult.jsp");
				}else {
					// 비밀번호 찾기
					user_id = request.getParameter("id").trim();
					request.setAttribute("id", user_id);
					
					forward.setRedirect(false);
					forward.setPath("forget/forgetPwdChangeResult.jsp");
					
				}
				

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
