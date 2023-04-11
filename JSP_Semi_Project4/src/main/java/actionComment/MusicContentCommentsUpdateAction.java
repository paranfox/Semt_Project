package actionComment;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import java.util.*;
import model.*;
import persistence.*;

public class MusicContentCommentsUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int comment_id = Integer.parseInt(request.getParameter("comment_id"));
		String content = request.getParameter("content");

		HttpSession session = request.getSession();

		String user_id = (String) session.getAttribute("sessionId");
		String profile_pic = (String) session.getAttribute("profile_pic");

		CommentVO comment = new CommentVO();
		comment.setComment_id(comment_id);
		comment.setUser_id(user_id);
		comment.setContent(content);
		comment.setUser_pic(profile_pic);

		CommentDAO dao = CommentDAO.getInstance();

		dao.updateComment(comment);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print("{\"result\":\"success\"}");
		out.flush();

		return null;

	}

}
