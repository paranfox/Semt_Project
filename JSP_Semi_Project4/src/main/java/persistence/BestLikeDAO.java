package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.MusicLikesVO;
import model.MusicVO;

public class BestLikeDAO {
	
	private DataSource ds;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	private static BestLikeDAO dao;

	private BestLikeDAO() {
		
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

	public static BestLikeDAO getInstance() {
		if (dao == null) {
			dao = new BestLikeDAO();
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
	
		// 좋아요 순서 리스트
		public List<MusicVO> getlikeList() {
			
			connect();
			
			List<MusicVO> list = new ArrayList<MusicVO>();
			
			try {
				
				sql = "SELECT * FROM music_info ORDER BY music_likecnt DESC";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					MusicVO vo = new MusicVO();
					
					vo.setMusic_likecnt(rs.getInt("music_likecnt"));
					vo.setMusic_title(rs.getString("music_title"));
					vo.setMusic_pic(rs.getString("music_pic"));
					vo.setMusic_mp3(rs.getString("music_mp3"));
					vo.setMusic_contents(rs.getString("music_contents"));
					vo.setMusic_playcnt(rs.getInt("music_playcnt"));

					list.add(vo);
				}
			} catch (SQLException e) {
				e.printStackTrace(); 
			} finally {
				disconnect(rs, pstmt, con);
			}
			return list;
		}	// getlikeList() 메서드 end	
	

}
