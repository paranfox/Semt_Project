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

		CommentDAO dao = CommentDAO.getInstance();

		// 현재 댓글의 작성자 ID를 가져옵니다.
		CommentVO originalComment = dao.getCommentById(comment_id);

		// 현재 로그인한 사용자의 ID와 댓글 작성자의 ID가 일치하는지 확인합니다.
		if (user_id.equals(originalComment.getUser_id())) {
			CommentVO comment = new CommentVO();
			comment.setComment_id(comment_id);
			comment.setUser_id(user_id);
			comment.setContent(content);
			comment.setUser_pic(profile_pic);

			dao.updateComment(comment);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print("{\"result\":\"success\"}");
			out.flush();
		} else {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print("{\"result\":\"fail\", \"message\":\"본인이 작성한 댓글만 수정할 수 있습니다.\"}");
			out.flush();
		}

		return null;

	}

}
