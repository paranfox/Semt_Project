package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringJoiner;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.MusicVO;

public class LikeDAO {

	private DataSource ds;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	private static LikeDAO dao;

	private LikeDAO() {
		
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

	public static LikeDAO getInstance() {
		if (dao == null) {
			dao = new LikeDAO();
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

	public List<MusicVO> contentLike(String id) {
	    List<MusicVO> list = new ArrayList<MusicVO>();
	    List<Integer> list2 = new ArrayList<Integer>();

	    MusicVO vo = new MusicVO();

	    try {
	        connect();

	        sql = "select album_id from likes where user_id = ? and likes = 1";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();

	        while(rs.next()) {
	            list2.add(rs.getInt(1));
	            System.out.println(list2);
	        }

	        // IN 절에 사용할 배열값을 동적으로 생성합니다.
	        StringJoiner joiner = new StringJoiner(",", "(", ")");
	        for (int music_id : list2) {
	            joiner.add("?");
	        }

	        // SQL 쿼리에 매개변수를 지정합니다.
	        String sql = "select * from MUSIC_INFO where music_id in  " + joiner.toString();
	        pstmt = con.prepareStatement(sql);

	        // 배열값으로 대체할 매개변수의 인덱스를 지정합니다.
	        int parameterIndex = 1;

	        // 배열값으로 대체할 매개변수를 설정합니다.
	        for (int music_id : list2) {
	            pstmt.setInt(parameterIndex++, music_id);
	        }

	        // 쿼리 실행
	        rs = pstmt.executeQuery();

	        // 결과를 리스트로 저장
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

	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    } finally {
	        disconnect(rs, pstmt, con);
	    }

	    return list;
	}

	
	public MusicVO Music_pic(int id) {
		
		
		 MusicVO vo = new MusicVO();
		
		try {
			connect();
			
			sql = "select music_pic from music_info where music_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new MusicVO();
				
				
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		
		return vo;
	} // contentLike() 메서드 end
	
	
	
	public int likecheckprocess(String id, int album) {
		int result = -1;
		
		try {
			connect();
			
			sql = "select likes from likes where user_id = ? and album_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, album);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {

				int likes = rs.getInt("likes"); // "likes" 열의 값을 가져옴
				
				if(likes == 0) {
					sql = "UPDATE likes SET likes = 1 WHERE user_id = ? AND album_id = ?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setInt(2, album);
					pstmt.executeUpdate();
					result = 1;
				}else if(likes == 1) {
					// 만약 id랑 음악id가 같을 때 likes가 0이라면
					sql = "UPDATE likes SET likes = 0 WHERE user_id = ? AND album_id = ?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setInt(2, album);
					pstmt.executeUpdate();
					result = 0;
			
				}else {
					
				}
			}else {
				// 만약 처음 넣는 곡일 경우 좋와요를 1 넣어 준다.
				sql = "insert into likes values(null, ?, ?, 1, CURRENT_TIMESTAMP)";  // where id = ?
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, album);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				result = 2;
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return result;
		
	}  // likecheckprocess() 메서드 end
	

}