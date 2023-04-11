package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserVO;
import persistence.UserDAO;

public class DeleteDoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 유저 탈퇴 Action

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String user_id = request.getParameter("num");

		UserVO vo = new UserVO();

		UserDAO dao = UserDAO.getInstance();

		int check = dao.deleteUser(user_id);

		PrintWriter out = response.getWriter();

		if (check > 0) {
			HttpSession session = request.getSession(); 
			session.invalidate();
			out.println("<script>");
			out.println("alert('상품 삭제 성공!!!')");
			out.println("location.href='main.jsp'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('상품 삭제 실패~')");
			out.println("history.back()");
			out.println("</script>");
		}

		return null;

	}

}
