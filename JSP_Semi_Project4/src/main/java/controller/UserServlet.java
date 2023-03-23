package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
import persistence.*;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UserServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String cmdReq = "";
		String message = "";

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String cmdReq = "";
		String message = "";

		cmdReq = request.getParameter("cmd");
		if (cmdReq.equals("join")) {

			UserVO userVO = new UserVO();

			userVO.setUser_id(request.getParameter("user_id"));
			userVO.setUser_pwd(request.getParameter("user_pwd"));
			userVO.setUser_name(request.getParameter("user_name"));
			userVO.setUser_nickname(request.getParameter("user_nickname"));
			userVO.setUser_email(request.getParameter("user_email"));
			userVO.setUser_phone(request.getParameter("user_phone"));
			userVO.setUser_pic(request.getParameter("user_pic"));
			
			
			
			UserDAO dao = UserDAO.getInstance();
			dao.registerUser(userVO);

			request.setAttribute("user", userVO);

			RequestDispatcher view = request.getRequestDispatcher("result.jsp");
			view.forward(request, response);

		}

	}

}
