package actionMusic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import java.util.*;
import persistence.*;
import model.*;

public class MusicContentDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String user_id = request.getParameter("user_id");

		MusicDAO dao = MusicDAO.getInstance();

		return null;
	}

}
