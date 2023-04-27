package actionUser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.EmailHelper;

public class UserRegisterSendEmail implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String register_email = request.getParameter("userEmail");

		EmailHelper emailHelper = EmailHelper.getInstance();
		String code = emailHelper.sendAndGetCode(register_email);

		request.setAttribute("code", code);

		PrintWriter out = response.getWriter();
		
		out.println(code);
		
		return null;
	}
}
