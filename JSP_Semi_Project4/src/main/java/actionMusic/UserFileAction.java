package actionMusic;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.MusicDAO;
import model.*;

public class UserFileAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 음악파일 첨부만을 위한 비지니스 로직
		MusicVO vo = new MusicVO();

		// 파일 업로드 시에는 설정해야 할 내용이 있음.
		// 1. 첨부 파일 저장 경로 지정.
		/*
		 * Properties prop = new Properties(); FileInputStream fis = new
		 * FileInputStream( request.getServletContext().getRealPath(
		 * "\\WEB-INF\\classes\\controller\\mapping.properties")); prop.load(fis);
		 * fis.close();
		 */
		// System.out.println(System.getenv("USERPROFILE")); //자기 컴터 이름 궁금하면 주석풀고 해보세요.
		// 시스템안에있는 환경변수중에서 USERPROFILE를 따옵니다. 그게 보통 C:\Users\KangChan 이렇게 나오는데 앞에 3개를 없애요.
		// 그러면 Users\Kangchan이 나오겠죠.(미리 프로퍼티스에 저장해둬요 절대경로를) 거기에 폴더 경로(현재는 join)를 붙여줍니다.
		// 프로퍼티스의 절대경로는 실제 프로젝트의 경로를 넣어줍니다.
		// String saveFolder = prop.getProperty(System.getenv("USERPROFILE").substring(3));
		String saveFolder = "D:\\work\\workspace\\semi_prj\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\JSP_Semi_Project4\\fileUpload";
		int fileSize = 100 * 1024 * 1024; // 100MB

		// 3. MultipartRequest 객체 생성
		// ==> 파일 업로드를 진행하기 위한 객체 생성.
		MultipartRequest multi = new MultipartRequest(request, // 일반적인 resuest 객체.
				saveFolder, // 첨부파일이 저장될 경로
				fileSize, // 업로드할 첨부파일의 최대 크기
				"UTF-8", // 문자 인코딩 방식
				new DefaultFileRenamePolicy()
		// 첨부 파일의 이름이 같은 경우 중복이 안되게 설정.
		);
		
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("sessionId");
		String user_nickname = (String)session.getAttribute("sessionUserNickname");
		
		String music_pic = multi.getFilesystemName("music_pic");
		String music_title = multi.getParameter("music_title");
		String music_contents = multi.getParameter("music_contents");
		String music_mp3 = multi.getFilesystemName("music_mp3");


		
		vo.setMusic_mp3(music_mp3);
		vo.setMusic_pic(music_pic);
		vo.setUser_nickname(user_nickname);
		vo.setUser_id(user_id);
		vo.setMusic_title(music_title);
		vo.setMusic_contents(music_contents);

		MusicDAO dao = MusicDAO.getInstance();
		int check = dao.insertFile(vo);

		PrintWriter out = response.getWriter();
                  
		if (check > 0) {
			out.println("<script>");
			out.println("alert('[앨범 등록 성공]')");
			out.println("location.href='user_music_list.do'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('[앨범 등록 실패]')");
			out.println("history.back()");
			out.println("</script>");
		}

		return null;

	}
}