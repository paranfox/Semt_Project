package actionUser;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

public class UserRegisterCheckEmailCode implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String emailCode = request.getParameter("emailCode").trim();
		String code = request.getParameter("code");

		// 쓰레기
		
		
		return null;
	}
}
