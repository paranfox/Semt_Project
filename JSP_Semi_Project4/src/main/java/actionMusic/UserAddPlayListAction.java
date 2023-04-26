package actionMusic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.MusicPlaylist;
import persistence.PlaylistDAO;

public class UserAddPlayListAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int playlistId = Integer.parseInt(request.getParameter("playlist_id"));
        int musicId = Integer.parseInt(request.getParameter("music_id"));

        MusicPlaylist musicPlaylist = new MusicPlaylist(playlistId, musicId);
        PlaylistDAO dao = PlaylistDAO.getInstance();

        int result = dao.addMusicToPlaylist(musicPlaylist);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print("{\"success\": " + result + "}");

        return null;
    }
}