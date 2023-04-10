package actionComment;

import java.io.IOException;
import com.google.gson.Gson;

import action.Action;
import action.ActionForward;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;
import persistence.*;
import java.util.*;
import model.*;
import persistence.*;

public class MusicContentCommentsListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int album_id = Integer.parseInt(request.getParameter("album_id"));

		CommentDAO commentDAO = CommentDAO.getInstance();
		List<CommentVO> comments = commentDAO.getCommentsByAlbumId(album_id);
		

		// 댓글 목록을 JSON 형태로 변환하여 응답합니다.
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		Gson gson = new Gson();
		String json = gson.toJson(comments);
		out.print(json);
		out.flush();

		return null;

	}

}
