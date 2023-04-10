package persistence;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.MusicVO;

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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public int insertFile(MusicVO vo) {
		connect();
		int result = 0;
		int count = 0;

		try {

			sql = "insert into music_info values(default,?,?,?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, vo.getMusic_pic());
			pstmt.setString(2, vo.getMusic_mp3());
			pstmt.setString(3, vo.getMusic_title());
			pstmt.setString(4, vo.getMusic_contents());
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			pstmt.setString(7, vo.getUser_id());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		} finally {

			disconnect(rs, pstmt, con);

		}

		return result;

	} // insertUpload() 메서드 end

	public List<MusicVO> getMusicList() {

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

}
