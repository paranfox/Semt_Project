package persistence;

import java.sql.*;

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

	public MusicDAO() {	}

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
	
	public boolean insertFile(MusicVO vo) {

		try {
			connect();
			
			
			
				sql = "insert into music_info values(?,?,?,?,?,?,?,?) ";

				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, vo.getUser_id());
				pstmt.setString(2, vo.getMusic_pic());
				pstmt.setString(3, vo.getMusic_mp3());
				pstmt.setString(4, vo.getMusic_title());
				pstmt.setString(5, vo.getMusic_contents());
				pstmt.setInt(6, 0);
				pstmt.setInt(7, 0);
				pstmt.setString(8, vo.getUser_id());

				pstmt.executeUpdate();

			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			return false;
			
		} finally {
			disconnect(rs, pstmt, con);
		}

		return true;
	} // insertUpload() 메서드 end
	
	
	
	
	
	
}
