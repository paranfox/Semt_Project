package actionUserMain;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import action.Action;
import action.ActionForward;
import model.FollowersProfileVO;
import model.UserVO;
import persistence.FollowsDAO;
import persistence.UserDAO;

public class UserFollowerListAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// bbs유저가 팔로우하고 있는 유저들의 목록 + 프로필 사진, 닉네임, 팔로우 수
		
		// bbs 유저 id
		String bbs_id = request.getParameter("user_id").trim();
		UserDAO dao = UserDAO.getInstance();
		UserVO vo = dao.userContent(bbs_id);
		
		FollowsDAO followsdao = FollowsDAO.getInstance();
		
		List<FollowersProfileVO> list = followsdao.getFollowerList(bbs_id);
		
		//String profile_pic = userdao.getProfile_pic_file(user_id);
		
		request.setAttribute("followerList", list);
		request.setAttribute("userVO", vo);
		
		System.out.println(list.size());
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("user/user_follower_list.jsp");
		
		
		return forward;
	}
}
