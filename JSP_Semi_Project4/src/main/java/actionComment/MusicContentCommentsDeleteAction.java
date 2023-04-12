package actionComment;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import action.Action;
import action.ActionForward;
import persistence.*;
import model.*;

public class MusicContentCommentsDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// Get comment_id from request
		int commentId = Integer.parseInt(request.getParameter("comment_id"));

		// Create DAO instance and call deleteComment method
		CommentDAO dao = CommentDAO.getInstance();
		boolean result = dao.deleteComment(commentId);

		// Set response content type and character encoding
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Create JSON object for response
		JSONObject jsonObject = new JSONObject();
		if (result) {
			try {
				jsonObject.put("result", "success");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			try {
				jsonObject.put("result", "fail");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		// Write JSON object to response
		response.getWriter().write(jsonObject.toString());

		return null;
	}

}
