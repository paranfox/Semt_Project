package actionMyPlayList;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import java.util.*;
import model.*;
import persistence.*;
public class UserPlayListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 String user_id = request.getParameter("id");

	        PlaylistDAO dao = PlaylistDAO.getInstance();
	        List<PlaylistVO> playlists = dao.getMyPlayList(user_id);

	        // 각 플레이리스트에 대해 음악 목록을 가져옵니다.
	        Map<Integer, List<MusicVO>> playlistMusicMap = new HashMap<>();
	        for (PlaylistVO playlist : playlists) {
	            List<Integer> musicIds = dao.getMusicIdsByPlaylistId(playlist.getPlaylist_id());
	            List<MusicVO> musicList = dao.getMusicInfoByMusicIds(musicIds);
	            playlistMusicMap.put(playlist.getPlaylist_id(), musicList);
	        }

	        request.setAttribute("playlists", playlists);
	        request.setAttribute("playlistMusicMap", playlistMusicMap);

	        ActionForward forward = new ActionForward();
	        forward.setRedirect(false);
	        forward.setPath("/myPlayList/myPlayList.jsp");

	        return forward;
	    }
	
	

}
