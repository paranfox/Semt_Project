package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import persistence.registerDAO;

@WebServlet("/NicknameCheckService")
public class NicknameCheckService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public NicknameCheckService() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

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
	}

}
