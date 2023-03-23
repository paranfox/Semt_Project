package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import persistence.UserDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
				
		
		String cmdReq = "";
	

		cmdReq = request.getParameter("cmd");
		
		if (cmdReq.equals("login")) {
			
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
					
			UserDAO dao = UserDAO.getInstance();
			String user_name = dao.logincheck(id, pwd);
			
			if(user_name != null) {
				
				HttpSession httpSession = request.getSession(true);
				
				httpSession.setAttribute("member", "ok");
				System.out.println(user_name);
				
				RequestDispatcher rd = request.getRequestDispatcher("Main.jsp");
				rd.forward(request, response);
				
				
			}else {
				response.sendRedirect("LogInForm.jsp");
			}
		}
		
	}

}
	
