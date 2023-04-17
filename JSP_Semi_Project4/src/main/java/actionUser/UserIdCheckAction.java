package actionUser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.registerDAO;

public class UserIdCheckAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String userId = request.getParameter("userId");

		PrintWriter out = response.getWriter();

		registerDAO dao = registerDAO.getInstance();

		int idCheck = dao.checkId(userId);

		if (idCheck == 0) {
			System.out.println("이미 존재하는 아이디입니다.");
		} else if (idCheck == 1) {
			System.out.println("사용 가능한 아이디입니다.");
		}

		out.write(idCheck + "");

		return null;
	}
}
