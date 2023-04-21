package actionlike;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.LikeDAO;

public class LikeListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//  사용자의 좋와요 리스트를 뽑아서 보내주는 비지니스 로직
		// contentLike(user_id);
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("sessionId");
		
		LikeDAO dao = LikeDAO.getInstance();
		
		
		// 요청 : 게시물 전체 목록 보여달라는 요청
		// 응답 : DB의 board 테이블의 전체 게시물 목록을 조회하여
		//      view page로 이동시키는 비지니스 로직.
			// 비지니스 로직 진행 시 페이징 처리 작업까지 동시 진행.
			
			// BoardDAO dao = BoardDAO.getInstance();
			// List<BoardDTO> list = dao.getBoardList();
			// request.setAttribute("List", list);
			
			// 페이징 처리 작업 진행
			
			// 한 페이지당 보여질 게시물의 수
			int rowsize = 3;  // 나는 한페이지를 3개로 잡겠다.
			
			// 아레에 보여질 페이지 최대 믈럭 수
			int block = 3;
			// 예) [1][2][3] / [4][5][6]  / [7][8][9]  1 ~ 3 블럭까진 같이 보이고  4부턴 안보이는 작업을 아래 시작 번호가 작업하는 것
			
			// DB 상의 게시물의 전체 수
			int totalRecord = 0;
			
			// 전체 페이지 수
			int allPage = 0;
			
			// 현재 페이지 변수
			int page = 0;
			
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
			}else {
				// 처음으로 "전체 게시물 목록" a 태그를 클릭한 경우
				page = 1;
			}
			// 11개 페이지가 있다면 [1]안에 11~9 [2]안에 8~7...[4] 2,1하고 끝나는 것. 반대로 1부터 올라 갈 때로 [1]안에 1~3...[4]10,11이 된다.
			
			// 해당 페이지에서 시작 번호
			int startNo = (page * rowsize) - (rowsize - 1);
			
			// 해당 페이지에서 끝 번호
			int endNo = (page * rowsize);
			
			// 해당 페이지에서 시작 블럭   예) 1,2,3은 전부 0으로 1,2,3나오지만 4페이지부터 달라짐(int라 소숫점은 무시)
			int startBlock = (((page -1) / block) * block) + 1;
			
			// 해당 페이지에서 마지막 블럭
			int endBlock = (((page -1) / block) * block) + block;
			
			// 젠체 게시물의 수를 확인하는 메서드 호출
			totalRecord = dao.getPageingCount(user_id);
			
			// 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 주어야 함.
			// 이 과정을 거치면 전체 페이지 수가 나오게 됨.
			// 이 때 전체 페이지 수가 나올 때 나머지가 있으면
			// 무조건 전체 페이지 수를 하나 올려 주어야 함.  cail은 나머지가 생기면 무조건 올려주는 함수 것보다 배웠다.
			allPage = (int)Math.ceil(totalRecord / (double)rowsize);
			
			if(endBlock > allPage) {  // 마지막에 5페이지로 끝날경우 보여지는 것은 6페이지 까지 보여지는 데 6페이지에는 데이터가 없으니 5페이지에서 끝날 수 있게 해주는 방법.
				endBlock = allPage;
			}
			
			// 현재 페이지에 해당하는 게시물을 가져오는 메서드 호출
			List<MusicVO> pageList =
					dao.getPageingList(page, rowsize, user_id);
			
			// 지금까지 페이징 처리 시 작업했던 모든 데이터들을
			// view page로 이동을 시키자.
			request.setAttribute("page", page);
			request.setAttribute("rowsize", rowsize);
			request.setAttribute("block", block);
			request.setAttribute("totalRecord", totalRecord);
			request.setAttribute("allPage", allPage);
			request.setAttribute("startNo", startNo);
			request.setAttribute("endNo", endNo);
			request.setAttribute("startBlock", startBlock);
			request.setAttribute("endBlock", endBlock);
			request.setAttribute("user_likelist", pageList);  // 이녀석이 페이지를 넘겨 받는 값 이녀석이 jsp에서 문자가 똑같아야 함.
			
			forward.setRedirect(false);
			
			forward.setPath("user/user_like.jsp");
			
			return forward;
	}
}
