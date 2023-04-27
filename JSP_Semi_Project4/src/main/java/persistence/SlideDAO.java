package persistence;
import model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SlideDAO {
	private DataSource ds;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	private static SlideDAO dao;

	private SlideDAO() {

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

	public static SlideDAO getInstance() {
		if (dao == null) {
			dao = new SlideDAO();
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

	public List<MusicVO> getAllMusic() {
		List<MusicVO> musicList = new ArrayList<>();
		connect();

		try {
			sql = "SELECT * FROM music_info";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MusicVO music = new MusicVO();
				music.setMusic_id(rs.getInt("music_id"));
				music.setMusic_pic(rs.getString("music_pic"));
				music.setMusic_mp3(rs.getString("music_mp3"));
				music.setMusic_title(rs.getString("music_title"));
				music.setMusic_contents(rs.getString("music_contents"));
				music.setMusic_likecnt(rs.getInt("music_likecnt"));
				music.setMusic_playcnt(rs.getInt("music_playcnt"));
				music.setUser_id(rs.getString("user_id"));
				music.setUser_nickname(rs.getString("user_nickname"));
				musicList.add(music);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return musicList;
	}
}
