package actionMusic;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import action.ActionForward;
import model.MusicVO;
import persistence.MusicDAO;

public class MusicModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	
		String saveFolder = "E:\\NCS\\workspace(jsp)\\15_Board_FileUpload\\WebContent\\fileUplaod";
		
		// 2. 첨부 파일 크기 지정.
		int fileSize = 10 * 1024 * 1024; 	// 10MB(메가 바이트)
		
		// 3. MultipartRequest 객체 생성
		//     ==> 파일 업로드를 진행하기 위한 객체 생성.
		MultipartRequest multi = new MultipartRequest(
					request,											// 일반적인 resuest 객체.	 
					saveFolder,										// 첨부파일이 저장될 경로
					fileSize,											// 업로드할 첨부 파일의 최대 크기 
					"UTF-8",											// 문자 인코딩 방식
					new DefaultFileRenamePolicy()			// 첨부 파일의 이름이 같은 경우 중복이 안되게 설정.
		);		
		
		int music_id = Integer.parseInt(multi.getParameter("music_id"));		
		String music_pic = multi.getFilesystemName("music_pic");
		String music_title = multi.getParameter("music_title").trim();
		String music_album = multi.getParameter("music_album").trim();
		int music_cnt = Integer.parseInt(multi.getParameter("music_cnt").trim());
		int music_like = Integer.parseInt(multi.getParameter("music_like").trim());
		
		MusicVO vo = new MusicVO();
		
		vo.setMusic_id(music_id);
		vo.setMusic_pic(music_pic);
		vo.setMusic_title(music_title);
		vo.setMusic_contents(music_album);
		vo.setMusic_likecnt(music_cnt);
		vo.setMusic_likecnt(music_like);
		
		MusicDAO dao = MusicDAO.getInstance();
		
		int updateMusic = dao.updateModifyMusic(vo);
		
		PrintWriter out = response.getWriter();
		
		if(updateMusic > 0) {
			out.println("<script>");
			out.println("alert('수정 성공!!!')");
			out.println("location.href='upload_content.do?uno=" + music_id + "'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('수정 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}
		return null;
	}
}
