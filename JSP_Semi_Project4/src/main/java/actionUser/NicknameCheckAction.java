package actionUser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.registerDAO;

public class NicknameCheckAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String userNickname = request.getParameter("userNickname");

		PrintWriter out = response.getWriter();

		registerDAO dao = registerDAO.getInstance();

		int nickCheck = dao.checkNickname(userNickname);

		if (nickCheck == 0) {
			System.out.println("이미 존재하는 닉네임입니다.");
		} else if (nickCheck == 1) {
			System.out.println("아이디 생성이 가능합니다.");
		}
		out.write(nickCheck + "");

		return null;
	}
}
