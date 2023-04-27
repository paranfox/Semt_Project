package actionUser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.UserDAO;

public class UserEmailCheckAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String register_email = request.getParameter("userEmail").trim();
		System.out.println("입력 받은 이메일 : " + register_email);

		PrintWriter out = response.getWriter();

		UserDAO dao = UserDAO.getInstance();

		int check = dao.checkEmailExist(register_email);

		if (check == 0) {
			System.out.println("회원가입이 가능합니다.");
		} else if (check == 1) {
			System.out.println("이미 존재하는 이메일입니다.");
		}
		out.write(check + "");

		return null;
	}
}
