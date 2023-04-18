package actionMusic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.MusicDAO;

public class MusicContAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 앨범 수정 
		int music_id = Integer.parseInt(request.getParameter("uno"));
		
		MusicDAO dao = MusicDAO.getInstance();
		
		// 조회수를 증가시켜 주는 메서드 호출.
		dao.musicPlayCnt(music_id);
		
		MusicVO vo = dao.musicModify(music_id);
		
		request.setAttribute("musicCont", vo);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("musicBbs/music_content.jsp");
		
		return forward;
	}

}
