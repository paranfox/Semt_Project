package actionUser;

import java.io.IOException;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import action.ActionForward;

import java.util.*;

import model.UserVO;
import persistence.UserDAO;

public class UserRegisterOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		UserVO userVO = new UserVO();

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		
		String saveFolder = "D:\\work\\workspace\\semi_prj\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\JSP_Semi_Project4\\fileUpload";

		// 2. 첨부 파일 크기 지정.
		int fileSize = 10 * 1024 * 1024; // 10MB

		// 3. MultipartRequest 객체 생성
		// ==> 파일 업로드를 진행하기 위한 객체 생성.
		MultipartRequest multi = new MultipartRequest(request, // 일반적인 resuest 객체.
				saveFolder, // 첨부파일이 저장될 경로
				fileSize, // 업로드할 첨부파일의 최대 크기
				"UTF-8", // 문자 인코딩 방식
				new DefaultFileRenamePolicy()
		// 첨부 파일의 이름이 같은 경우 중복이 안되게 설정.
		);

		int email_certification = Integer.parseInt(multi.getParameter("email_certification").trim());
		System.out.println(email_certification);
		if (email_certification == 1) {
			String user_id = multi.getParameter("user_id").trim();
			String user_pwd = multi.getParameter("user_pwd").trim();
			String user_name = multi.getParameter("user_name").trim();
			String user_nickname = multi.getParameter("user_nickname").trim();
			String user_email = multi.getParameter("user_email").trim();
			String user_phone = multi.getParameter("user_phone").trim();
			File user_pic = multi.getFile("user_pic");

			// 자료실 폼 페이지에서 type="file" 속성으로 되어 있으면
			// getFile() 메서드로 받아 주어야 함.

			if (user_pic != null) { // 첨부파일이 존재하는 경우

				// 우선은 첨부파일의 이름을 알아야 함.
				// getName() 메서드를 이용하면 이름을 알 수 있음.
				String fileName = user_pic.getName();
				System.out.println("첨부파일 이름 >>> " + fileName);

				// 날짜 객체 생성
				Calendar cal = Calendar.getInstance();

				int year = cal.get(Calendar.YEAR);

				int month = cal.get(Calendar.MONTH) + 1;

				int day = cal.get(Calendar.DAY_OF_MONTH);

				// ......../fileUpload/2023-03-28
				String homedir = saveFolder + "/" + year + "-" + month + "-" + day;

				// 날짜 폴더를 만들어 보자.
				File path1 = new File(homedir);

				if (!path1.exists()) { // 폴더가 존재하지 않는 경우
					path1.mkdir(); // 실제 폴더를 만들어 주는 메서드.
				}

				// 파일을 만들어 보자 ==> 예) 홍길동_파일명
				String reFileName = user_id + "_" + fileName;

				user_pic.renameTo(new File(homedir + "/" + reFileName));

				// 실제로 DB에 저장되는 파일 이름.
				// "/2023-03-28/홍길동_파일명" 으로 저장 예정.
				String fileDBName = "/" + year + "-" + month + "-" + day + "/" + reFileName;

				userVO.setUser_pic(fileDBName);

			}
			userVO.setUser_email(user_email);
			userVO.setUser_id(user_id);
			userVO.setUser_name(user_name);
			userVO.setUser_nickname(user_nickname);
			userVO.setUser_phone(user_phone);
			userVO.setUser_pwd(user_pwd);

			UserDAO dao = UserDAO.getInstance();
			dao.registerUser(userVO);

			HttpSession session = request.getSession();
			session.setAttribute("sessionNickName", userVO.getUser_nickname());

			request.setAttribute("user", userVO);
			session = request.getSession();
			session.setAttribute("sessionNickName", userVO.getUser_nickname());
			
			forward.setRedirect(false);
			forward.setPath("register/register_ok.jsp");

		} else if (email_certification == 0) {

			out.println("<script>");
			out.println("alert('이메일을 인증하세요')");
			out.println("history.back()");
			out.println("</script>");

		} else {

			out.println("<script>");
			out.println("alert('회원가입 실패')");
			out.println("history.back()");
			out.println("</script>");

		}

		return forward;

	}

}