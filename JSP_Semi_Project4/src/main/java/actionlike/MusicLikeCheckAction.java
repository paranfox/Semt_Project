package actionlike;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import persistence.LikeDAO;

public class MusicLikeCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 좋와요를 눌럿을때 좋와요 페이지에 좋와요를 올려주는 비지니스 로직
		// 단, 값이 1이상이라면 0으로 바꿔주어야 한다.

		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("sessionId");
		
		int music_id = Integer.parseInt(request.getParameter("music_id"));
		
	
		
		LikeDAO dao = LikeDAO.getInstance();
		// likecheckprocess(user_id, music_id);
		int check = dao.likecheckprocess(user_id, music_id);
		
		
		PrintWriter out = response.getWriter();
		
		if(check == 0) {
			out.println("<script>");
			out.println("alert('좋와요 삭제')"); 
			out.println("location.href='main_page.do'"); 
			out.println("</script>");
		}else if(check == 1){
			out.println("<script>");
			out.println("alert('좋와요 추가')");
			out.println("location.href='main_page.do'"); 
			out.println("</script>");
		}else if(check == 2){
			out.println("<script>");
			out.println("alert('이곡에 처음으로 좋와요를 주었습	니다.')");
			out.println("location.href='main_page.do'"); 
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('애러가 발생 했습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		return null;
	}

}
