package actionUser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.UserDAO;

public class UserEmailCheckAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String register_email = request.getParameter("userEmail").trim();
		System.out.println(register_email);

		UserDAO dao = UserDAO.getInstance();

		int check = dao.checkEmailExist(register_email);

		System.out.println(check);
		
		request.setAttribute("check", check);

		PrintWriter out = response.getWriter();

		out.println(check);
		
		return null;
	}
}
