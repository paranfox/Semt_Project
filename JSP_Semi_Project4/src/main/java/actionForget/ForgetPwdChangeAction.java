package actionForget;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.UserDAO;

public class ForgetPwdChangeAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String user_id = request.getParameter("id").trim();
		String user_pwd = request.getParameter("user_pwd").trim();
		
		UserDAO dao = UserDAO.getInstance();
		int check = dao.modifyPwd(user_id, user_pwd);
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('비밀번호가 변경되었습니다. 변경된 비밀번호로 로그인 하세요.')");
			out.println("location.href='main.jsp'");
			out.println("</script>");
			
		} else {
			out.println("<script>");
			out.println("alert('비밀번호 변경이 실패했습니다. 다시 시도해 주세요.')");
			out.println("location.href='forget/forgetPwd.jsp'");
			out.println("</script>");
		}
			
		//forward.setRedirect(false);
		//forward.setPath("login.jsp");
		
		return null;
	}
}
