package action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UserVO;
import persistence.UserDAO;

public class MyPageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String user_id = request.getParameter("num");

		UserDAO dao = UserDAO.getInstance();
		
		UserVO vo = new UserVO();

		vo = dao.modify(user_id);

		request.setAttribute("vo", vo);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("mypage/MyPage.jsp");

		return forward;
	}

}
