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

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		UserVO userVO = new UserVO();

		// 파일 업로드 할 때 설정해야할 내용.
		// 여기는 워크스페이스의 서버 mapping.properties 경로가 필요
		//	request.getServletContext().getRealPath(); 경로를 확인해 체크해 볼 것!
		Properties prop = new Properties();
		FileInputStream fis = new FileInputStream(
				request.getServletContext().getRealPath("\\WEB-INF\\classes\\controller\\mapping.properties"));
		prop.load(fis);
		fis.close();
		// System.out.println(System.getenv("USERPROFILE")); //자기 컴터 이름 궁금하면 주석풀고 해보세요.
		// 시스템안에있는 환경변수중에서 USERPROFILE를 따옵니다. 그게 보통 C:\Users\KangChan 이렇게 나오는데 앞에 3개를 없애요.
		// 그러면 Users\Kangchan이 나오겠죠.(미리 프로퍼티스에 저장해둬요 절대경로를) 거기에 폴더 경로(현재는 join)를 붙여줍니다.
		// 프로퍼티스의 절대경로는 실제 프로젝트의 경로를 넣어줍니다.
		// String saveFolder = prop.getProperty(System.getenv("USERPROFILE").substring(3));
		String saveFolder = "C:\\Users\\user\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\JSP_Semi_Project4\\fileUpload";
		// 2.첨부 파일 크기 지정.

		// 파일 업로드 시에는 설정해야 할 내용이 있음.
		// 1. 첨부 파일 저장 경로 지정.
		/*
		 * String saveFolder =
		 * "D:\\work\\workspace\\semi_prj\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\JSP_Semi_Project4\\fileUpload";
		 */
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

		String user_id = multi.getParameter("user_id");
		String user_pwd = multi.getParameter("user_pwd");
		String user_name = multi.getParameter("user_name");
		String user_nickname = multi.getParameter("user_nickname");
		String user_email = multi.getParameter("user_email");
		String user_phone = multi.getParameter("user_phone");
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

		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		forward.setRedirect(false);
		forward.setPath("main.jsp");

		return forward;

	}

}