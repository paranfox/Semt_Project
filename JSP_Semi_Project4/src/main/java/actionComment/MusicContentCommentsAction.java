package actionComment;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import persistence.*;
import model.*;
import java.util.*;

public class MusicContentCommentsAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {


		int album_id = Integer.parseInt(request.getParameter("album_id"));
		String content = request.getParameter("content");

		
		HttpSession session = request.getSession();

		String user_id = (String) session.getAttribute("sessionId");
		String user_nickname = (String) session.getAttribute("sessionUserNickName");
		String profile_pic = (String) session.getAttribute("profile_pic");
	
		
		CommentVO comment = new CommentVO();
		comment.setAlbum_id(album_id);
		comment.setUser_id(user_id);
		comment.setUser_nickname(user_nickname);
		comment.setContent(content);
		comment.setUser_pic(profile_pic);


		CommentDAO dao = CommentDAO.getInstance();

		dao.insertComment(comment);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print("{\"result\":\"success\"}");
		out.flush();

		return null; 
	}

}
