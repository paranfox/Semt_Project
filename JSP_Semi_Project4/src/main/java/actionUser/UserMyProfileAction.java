package actionUser;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

import java.util.*;
import model.*;
import persistence.*;

public class UserMyProfileAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		
	String user_nick = request.getParameter(
			"nick");
		UserDAO dao = UserDAO.getInstance();
		
		return null;
	}

}
