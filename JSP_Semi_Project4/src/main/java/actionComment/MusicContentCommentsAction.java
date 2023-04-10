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

		// 클라이언트에서 전달받은 album_id와 content 값을 가져옵니다.
		int album_id = Integer.parseInt(request.getParameter("album_id"));
		String content = request.getParameter("content");

		// user_id는 현재 로그인한 사용자의 ID를 가져와야 합니다.
		// 세션에서 사용자 정보를 가져와 user_id를 설정합니다.
		HttpSession session = request.getSession();
//		User user = (User) session.getAttribute("user");
		String user_id = "rbgks2222";

		// Comment 객체를 생성하고 값을 설정합니다.
		CommentVO comment = new CommentVO();
		comment.setAlbum_id(album_id);
		comment.setUser_id(user_id);
		comment.setContent(content);

		// CommentDAO 객체를 생성하고 댓글을 데이터베이스에 저장합니다.
		CommentDAO dao = CommentDAO.getInstance();

		dao.insertComment(comment);

		// 댓글 작성이 완료되면 알맞은 페이지로 리다이렉트하거나 JSON 응답을 반환합니다.
		// 이 예에서는 JSON 응답을 반환합니다.
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print("{\"result\":\"success\"}");
		out.flush();

		return null; // JSON 응답을 반환하는 경우 ActionForward 객체는 필요하지 않습니다.
	}

}
