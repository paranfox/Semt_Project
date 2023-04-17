package actionUserMain;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import model.UserVO;
import persistence.FollowsDAO;
import persistence.MusicDAO;
import persistence.UserDAO;

public class UserMainAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 음악 리스트에서 사용자 닉네임을 누르면 사용자별 음악 게시판, 팔로우 등 모든 정보를 확인하도록 한다. => 개인 메인 페이지

		String bbs_id = request.getParameter("user_id").trim();

		HttpSession session = request.getSession();
		String session_id = ((String) session.getAttribute("sessionId")).trim();

		MusicDAO musicdao = MusicDAO.getInstance();
		UserDAO userdao = UserDAO.getInstance();
		FollowsDAO followsdao = FollowsDAO.getInstance();

		// 유저별 음악 리스트 가져오기
		List<MusicVO> list = musicdao.getUserMusicList(bbs_id);
		UserVO uservo = userdao.userContent(bbs_id);
		int followersCount = followsdao.getFollowersCount(bbs_id);
		int followingCount = followsdao.getFollowingCount(bbs_id);
		

		ActionForward forward = new ActionForward();

		request.setAttribute("userMusicList", list);
		request.setAttribute("userVO", uservo);
		request.setAttribute("followersCount", followersCount);
		request.setAttribute("followingCount", followingCount);

		System.out.println("게시판 id >>> " + bbs_id);
		System.out.println("세션 id >>> " + session_id);

		if (bbs_id.equals(session_id)) {
			forward.setRedirect(false);
			forward.setPath("/user/user_my_main.jsp");
		} else if (!(bbs_id.equals(session_id))) {
			forward.setRedirect(false);
			forward.setPath("/user/user_other_main.jsp");
		}

		return forward;
	}
}
