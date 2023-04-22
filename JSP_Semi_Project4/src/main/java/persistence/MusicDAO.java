package persistence;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.MusicVO;
import model.*;

public class MusicDAO {

	private DataSource ds;

	Connection con = null;

	PreparedStatement pstmt = null;

	ResultSet rs = null;

	String sql = null;

	private static MusicDAO dao;

	public MusicDAO() {

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

	public static MusicDAO getInstance() {

		if (dao == null) {
			dao = new MusicDAO();
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

			e.printStackTrace();

		}

	}

	public int insertFile(MusicVO vo) {

		connect();

		int result = 0;

		int count = 0;

		try {

			sql = "insert into music_info values(default,?,?,?,?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, vo.getMusic_pic());

			pstmt.setString(2, vo.getMusic_mp3());

			pstmt.setString(3, vo.getMusic_title());

			pstmt.setString(4, vo.getMusic_contents());

			pstmt.setInt(5, 0);

			pstmt.setInt(6, 0);

			pstmt.setString(7, vo.getUser_id());

			pstmt.setString(8, vo.getMusic_genre());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		} finally {

			disconnect(rs, pstmt, con);

		}

		return result;

	} // insertUpload() 메서드 end

	public List<MusicVO> getMyMusicList(String id) {

		connect();

		List<MusicVO> list = new ArrayList<MusicVO>();

		try {

			sql = "select * from music_info";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				MusicVO vo = new MusicVO();

				vo.setMusic_id(rs.getInt("music_id"));
				vo.setMusic_pic(rs.getString("music_pic"));
				vo.setMusic_mp3(rs.getString("music_mp3"));
				vo.setMusic_title(rs.getString("music_title"));
				vo.setMusic_contents(rs.getString("music_contents"));
				vo.setMusic_likecnt(rs.getInt("music_likecnt"));
				vo.setMusic_playcnt(rs.getInt("music_playcnt"));
				vo.setUser_id(rs.getString("user_id"));

				list.add(vo);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return list;
	} // getMusicList() end

	public MusicVO contentMusic(int album_id) {
		connect();
		MusicVO vo = null;
		try {
			sql = "select * from music_info where music_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, album_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				vo = new MusicVO();
				vo.setMusic_id(rs.getInt("music_id"));
				vo.setMusic_contents(rs.getString("music_contents"));
				vo.setMusic_mp3(rs.getString("music_mp3"));
				vo.setMusic_pic(rs.getString("music_pic"));
				vo.setMusic_title(rs.getString("music_title"));
				vo.setMusic_likecnt(rs.getInt("music_likecnt"));
				vo.setMusic_playcnt(rs.getInt("music_playcnt"));
				vo.setUser_id(rs.getString("user_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return vo;
	}

	public MusicLikesVO getMusicLikesByUserIdAndMusicId(String user_id, int music_id) throws SQLException {
		connect();

		MusicLikesVO musicLikes = null;

		try {

			String sql = "SELECT * FROM music_likes WHERE user_id=? AND music_id=?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, user_id);

			pstmt.setInt(2, music_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				musicLikes = new MusicLikesVO();
				musicLikes.setId(rs.getInt("id"));
				musicLikes.setUser_id(rs.getString("user_id"));
				musicLikes.setMusic_id(rs.getInt("music_id"));
				musicLikes.setIs_liked(rs.getBoolean("is_liked"));
				musicLikes.setIs_disliked(rs.getBoolean("is_disliked"));
			}
		} finally {
			disconnect(rs, pstmt, con);
		}

		return musicLikes;
	}

	public boolean toggleLike(MusicLikesVO musicLikes) throws SQLException {
		connect();
		boolean result = false;

		try {
			if (musicLikes.getId() == 0) {
				String sql = "INSERT INTO music_likes (user_id, music_id, is_liked, is_disliked) VALUES (?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, musicLikes.getUser_id());
				pstmt.setInt(2, musicLikes.getMusic_id());
				pstmt.setBoolean(3, musicLikes.isIs_liked());
				pstmt.setBoolean(4, musicLikes.isIs_disliked());
			} else {
				String sql = "UPDATE music_likes SET is_liked=?, is_disliked=? WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setBoolean(1, musicLikes.isIs_liked());
				pstmt.setBoolean(2, musicLikes.isIs_disliked());
				pstmt.setInt(3, musicLikes.getId());
			}

			result = pstmt.executeUpdate() > 0;
		} finally {
			disconnect(rs, pstmt, con);
		}

		return result;
	}

	public boolean updateMusic(MusicVO vo) {

		connect();

		boolean isUpdated = false;

		try {

			sql = "UPDATE music_info SET music_pic = ?, music_mp3 = ?, music_title = ?, music_contents = ?, music_likecnt = ?, music_playcnt = ?, user_id = ? WHERE music_id = ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, vo.getMusic_pic());
			pstmt.setString(2, vo.getMusic_mp3());
			pstmt.setString(3, vo.getMusic_title());
			pstmt.setString(4, vo.getMusic_contents());
			pstmt.setInt(5, vo.getMusic_likecnt());
			pstmt.setInt(6, vo.getMusic_playcnt());
			pstmt.setString(7, vo.getUser_id());
			pstmt.setInt(8, vo.getMusic_id());

			int rowsAffected = pstmt.executeUpdate();

			if (rowsAffected > 0) {

				isUpdated = true;

			}

		} catch (SQLException e) {

			e.printStackTrace();

		} finally {

			disconnect(rs, pstmt, con);

		}

		return isUpdated;
	}

	public Map<String, Object> getLikeStatus(String user_id, int music_id) {
		connect();
		Map<String, Object> likeStatus = new HashMap<>();
		MusicVO music = null;
		MusicLikesVO musicLikes = null;

		try {

			sql = "SELECT * FROM music_info WHERE music_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, music_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				music = new MusicVO();
				music.setMusic_id(rs.getInt("music_id"));
				music.setMusic_likecnt(rs.getInt("music_likecnt"));
				music.setMusic_playcnt(rs.getInt("music_playcnt"));
			}

			sql = "SELECT * FROM music_likes WHERE user_id = ? AND music_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, music_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				musicLikes = new MusicLikesVO();
				musicLikes.setId(rs.getInt("id"));
				musicLikes.setUser_id(rs.getString("user_id"));
				musicLikes.setMusic_id(rs.getInt("music_id"));
				musicLikes.setIs_liked(rs.getBoolean("is_liked"));
				musicLikes.setIs_disliked(rs.getBoolean("is_disliked"));
			}

			likeStatus.put("music", music);
			likeStatus.put("musicLikes", musicLikes);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return likeStatus;
	}

	public int getPageingCount(String id) {

		int count = 0;

		try {
			connect();

			sql = "select count(music_id) from music_info where user_id = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return count;
	} // getPageingCount() 메서드 end

	// music_info 테이블에서 현재 페이지에 해당하는 게시물을 조회하는 메서드
	public List<MusicVO> getPageingList(int page, int rowsize, String id) {

		List<MusicVO> list = new ArrayList<MusicVO>();
		MusicVO vo = new MusicVO();
		connect();
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);

		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);

		try {
			sql = "SELECT *"
					+ " FROM (SELECT row_number() over(order by music_id desc) rnum, b.* FROM music_info b where user_id = ?) AS subquery"
					+ " WHERE rnum BETWEEN ? AND ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setInt(2, startNo);
			pstmt.setInt(3, endNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				vo = new MusicVO();
				vo.setMusic_id(rs.getInt("music_id"));
				vo.setMusic_pic(rs.getString("music_pic"));
				vo.setMusic_mp3(rs.getString("music_mp3"));
				vo.setMusic_title(rs.getString("music_title"));
				vo.setMusic_contents(rs.getString("music_contents"));
				vo.setMusic_likecnt(rs.getInt("music_likecnt"));
				vo.setMusic_playcnt(rs.getInt("music_playcnt"));
				vo.setUser_id(rs.getString("user_id"));

				list.add(vo);

			}

		} catch (

		SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return list;

	} // getPageingList() 메서드 end

	// playlist에서 만들어진 list조회하는 메서드
	public int getMyPlayList(String id, String name, int music_id) {

		int reseult = 0;
		int count = 0;
		int user_count = 0;
		connect();

		try {
			sql = "select * from myplaylist where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			count = rs.getInt(4) + 1;
			user_count = rs.getInt(6) + 1;
			
			if (rs.next()) {

				sql = "insert into myplaylist values(null, ?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, id);
				pstmt.setInt(2, music_id);
				pstmt.setInt(3, count);
				pstmt.setString(4, name);
				pstmt.setInt(5, user_count);
				reseult = pstmt.executeUpdate();
				
				if (rs.next()) {

				}
				reseult = -1;

			}

			reseult = -2;

		} catch (

		SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return reseult;

	} // getMyPlayList() 메서드 end
	
	// id에 맞는 플레이리스트를 가져오는 메서드
	public List<LikelistVO> getMyPlayListshow(String id) {
		List<LikelistVO> list = new ArrayList<LikelistVO>();
		LikelistVO vo = new LikelistVO();
		connect();
		

		try {
			sql = "select * from myplaylist where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				vo = new LikelistVO();
				
				vo.setPlaylist_id(rs.getInt("playlist_id"));
				vo.setUser_id(rs.getString("user_id"));
				vo.setMusic_id(rs.getInt("music_id"));
				vo.setPlaylist(rs.getInt("playlist"));
				vo.setPlaylist_name(rs.getString("playlist_name"));
				

				list.add(vo);

			}

		} catch (

		SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return list;

	} // getMyPlayListshow() 메서드 end
	
	
	// 삭제할때 playlist, user_id, user_count 를 비교

}
