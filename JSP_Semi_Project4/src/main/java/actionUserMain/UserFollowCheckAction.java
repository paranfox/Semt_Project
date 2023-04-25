package actionUserMain;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import persistence.FollowsDAO;

public class UserFollowCheckAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 팔로우 팔로워 아이디 비교 후 서로 관계 파악해서 보내주기
		// 3가지로 하면 될 거 같은데 팔로우 하는 중인지 팔로잉 되고 있는지 아무 관계도 아닌지

		String session_id = request.getParameter("session_id"); // 팔로우 받는 유저 (게시판)
		String bbs_id = request.getParameter("bbs_id"); // 팔로우 하는 유저 (현재 세션)

		System.out.println(session_id);
		System.out.println(bbs_id);

		FollowsDAO dao = FollowsDAO.getInstance();

		// 팔로우 상태 체크
		int check = dao.checkFollowStatus(session_id, bbs_id);
		
		System.out.println(check);
		request.setAttribute("check", check);

		PrintWriter out = response.getWriter();

		out.println(check);

		return null;
	}
}
