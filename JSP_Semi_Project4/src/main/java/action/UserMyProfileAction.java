package action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import model.*;
import persistence.*;

public class UserMyProfileAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		
	String user_nick = request.getParameter(
			"nick");
		UserDAO dao = UserDAO.getInstance();
	  User	= dao.getMyProfile(user_nick);
		
		return null;
	}

}
