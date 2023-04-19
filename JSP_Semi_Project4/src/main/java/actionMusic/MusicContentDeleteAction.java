package actionMusic;

import java.io.IOException;
import java.io.PrintWriter;

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

		// 앨범 상세 페이지에 음악을 삭제하는 Action
		
		int music_id = Integer.parseInt(request.getParameter("id"));
		
		MusicDAO dao = MusicDAO.getInstance();
		
		int check = dao.deleteMusic(music_id);
		
		PrintWriter out = response.getWriter();

		if (check > 0) {
			dao.updateSequence(music_id);
			
			
			out.println("<script>");
			out.println("alert('앨범 삭제 성공!!!')");
			out.println("location.href='user_music_list.do'");
			// 리스트에 남은 앨범 목록이 전부 나오게 하기.
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('앨범 삭제 실패~')");
			out.println("history.back()");
			out.println("</script>");
		}

		return null;
	}

}
