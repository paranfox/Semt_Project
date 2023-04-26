package persistence;
import java.util.stream.Collectors;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import model.*;
import model.MusicPlaylist;
import model.PlaylistVO;

public class PlaylistDAO {
	private DataSource ds;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	private static PlaylistDAO dao;

	private PlaylistDAO() {

	}

	public void connect() {
		try {
			Context ct = new InitialContext();
			// "java:comp/env/jdbc/mysql" 현재 웹 어플리케이션의 루트 디렉토리이다.
			ds = (DataSource) ct.lookup("java:comp/env/jdbc/mysql");
			// 마지막으로 데이터 소스를 가져온다.
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static PlaylistDAO getInstance() {
		if (dao == null) {
			dao = new PlaylistDAO();
		}
		return dao;
	}

	public void disconnect(ResultSet rs, PreparedStatement pstmt, Connection con) {

		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public int createPlaylist(PlaylistVO newPlaylist) {
		int result = 0;

		try {
			connect();

			sql = "INSERT INTO playlist (user_id, playlist_name) VALUES (?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, newPlaylist.getUser_Id());
			pstmt.setString(2, newPlaylist.getPlaylist_name());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return result;
	}

	public int addMusicToPlaylist(MusicPlaylist musicPlaylist) {
		int result = 0;

		try {
			connect();

			sql = "INSERT INTO playlist_music (playlist_id, music_id) VALUES (?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, musicPlaylist.getPlaylistId());
			pstmt.setInt(2, musicPlaylist.getMusicId());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return result;
	}

	public List<PlaylistVO> getMyPlayList(String user_id) {
		List<PlaylistVO> playlists = new ArrayList<>();
		try {
			connect();

			sql = "SELECT * FROM playlist where user_id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int playlist_id = rs.getInt("playlist_id");
				String playlist_name = rs.getString("playlist_name");
				PlaylistVO playlist = new PlaylistVO(user_id, playlist_name);
				playlist.setPlaylist_id(playlist_id);
				playlists.add(playlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return playlists;
	}

	public List<MusicPlaylist> getAlbumsByPlaylistId(int playlistId) {
		List<MusicPlaylist> albums = new ArrayList<>();
		try {
			connect();

			sql = "SELECT * FROM playlist_music WHERE playlist_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, playlistId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int musicId = rs.getInt("music_id");
				MusicPlaylist album = new MusicPlaylist(playlistId, musicId);
				albums.add(album);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return albums;
	}
	
	public List<MusicVO> getMusicInfoByMusicIds(List<Integer> musicIds) {
	    List<MusicVO> musicInfoList = new ArrayList<>();

	    if (musicIds.isEmpty()) {
	        return musicInfoList;
	    }

	    try {
	        connect();

	        String joinedIds = musicIds.stream().map(String::valueOf).collect(Collectors.joining(","));
	        sql = "SELECT * FROM music_info WHERE music_id IN (" + joinedIds + ")";
	        pstmt = con.prepareStatement(sql);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            MusicVO music = new MusicVO();
	            music.setMusic_id(rs.getInt("music_id"));
	            music.setUser_id(rs.getString("user_id"));
	            music.setMusic_pic(rs.getString("music_pic"));
	            music.setMusic_mp3(rs.getString("music_mp3"));
	            music.setMusic_title(rs.getString("music_title"));
	            music.setMusic_contents(rs.getString("music_contents"));
	            music.setMusic_likecnt(rs.getInt("music_likecnt"));
	            music.setMusic_playcnt(rs.getInt("music_playcnt"));
	            music.setUser_nickname(rs.getString("user_nickname"));

	            musicInfoList.add(music);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        disconnect(rs, pstmt, con);
	    }

	    return musicInfoList;
	}

	public List<Integer> getMusicIdsByPlaylistId(int playlistId) {
	    List<Integer> musicIds = new ArrayList<>();

	    try {
	        connect();

	        sql = "SELECT music_id FROM playlist_music WHERE playlist_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, playlistId);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            musicIds.add(rs.getInt("music_id"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        disconnect(rs, pstmt, con);
	    }

	    return musicIds;
	}
}