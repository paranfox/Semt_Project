package actionMypage;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.UserVO;
import persistence.UserDAO;

public class ModifyDoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String user_id = request.getParameter("num");

		UserDAO dao = UserDAO.getInstance();

		UserVO vo = dao.modify(user_id);

		request.setAttribute("userCont", vo);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("mypage/MyPageModifyDo.jsp");

		return forward;
	}

}
