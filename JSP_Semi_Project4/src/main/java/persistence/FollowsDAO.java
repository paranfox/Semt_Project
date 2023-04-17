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

import com.mysql.cj.x.protobuf.MysqlxCursor.Open;

import model.FollowersProfileVO;
import model.FollowsVO;
import model.UserVO;

public class FollowsDAO {

	private DataSource ds;

	Connection con = null;

	PreparedStatement pstmt = null;

	ResultSet rs = null;

	String sql = null;

	private static FollowsDAO dao;

	public FollowsDAO() {

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

	public static FollowsDAO getInstance() {

		if (dao == null) {
			dao = new FollowsDAO();
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

	// 팔로우 상태 체크 메서드
	public int checkFollowStatus(String session_id, String bbs_id) {

		int result = 0;

		connect();

		try {
			sql = "SELECT * FROM FOLLOWS WHERE FOLLOWER_ID = ? AND FOLLOWED_ID = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, session_id);
			pstmt.setString(2, bbs_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 로그인 유저만 팔로잉 중이다.
				// 버튼 팔로잉!
				result = 1;

				/*
				 * // 이 사람도 혹시 날 팔로우하고 있을지도..? 쿼리문에 아이디를 반대로 넣어본다 sql =
				 * "SELECT * FROM FOLLOWS WHERE FOLLOWER_ID = ? AND FOLLOWED_ID = ?";
				 * 
				 * pstmt = con.prepareStatement(sql);
				 * 
				 * pstmt.setString(1, bbs_id); pstmt.setString(2, session_id);
				 * 
				 * rs = pstmt.executeQuery();
				 * 
				 * if (rs.next()) { // 게시판 유저가 날 팔로우하고 있다! 맞팔 result = 2; }
				 */

			}
			// 서로 팔로우하지 않는 상태
			// result = 0;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return result;
	} // checkFollowStatus end

	public int followUpDown(int status, String session_id, String bbs_id) {
		// status 1 = 나만 팔로우 2 = 서로 팔로우 0 = 팔로우 안하는 중
		int result = 0, check = 0;

		connect();

		try {
			if (status == 0) {
				// 팔로우하고 있지 않으니까 팔로우 인서트 쿼리
				sql = "INSERT INTO FOLLOWS(follower_id, followed_id) VALUES(?, ?)";
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, session_id);
				pstmt.setString(2, bbs_id);

				result = pstmt.executeUpdate();
				if (result == 1) {
					check = 1;
				}

			} else if (status == 1) {
				// 팔로우하고 있는 상태니까 팔로우 딜리트 쿼리
				sql = "DELETE FROM follows WHERE follower_id = ? AND followed_id = ?";
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, session_id);
				pstmt.setString(2, bbs_id);

				result = pstmt.executeUpdate();

				if (result == 1) {
					check = 0;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return check;
	} // followUpDown end

	public int getFollowersCount(String bbs_id) {
		int count = 0;

		connect();

		try {
			sql = "SELECT COUNT(follower_id) FROM follows WHERE followed_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bbs_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return count;
	}

	public int getFollowingCount(String bbs_id) {
		int count = 0;

		connect();

		try {
			sql = "SELECT COUNT(followed_id) FROM follows WHERE follower_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bbs_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return count;
	}

	public List<FollowersProfileVO> getFollowerList(String bbs_id) {

		List<FollowersProfileVO> list = new ArrayList<FollowersProfileVO>();
		
		connect();

		try {
			sql = "SELECT * FROM followerlist WHERE followed_id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bbs_id);
			
			rs = pstmt.executeQuery();
			
			FollowersProfileVO vo = new FollowersProfileVO();
			
			if(rs.next()) {
				
				vo.setFollower_id(rs.getString("follower_id"));
				//vo.setFollowed_id(rs.getString("followed_id"));
				
				String followers_id = rs.getString("follower_id");
				sql = "SELECT * FROM user WHERE user_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, followers_id);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo.setUser_nickname(rs.getString("user_nickname"));
					vo.setUser_pic(rs.getString("user_pic"));
					
					sql = "SELECT COUNT(followed_id) FROM followerlist WHERE followed_id = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, followers_id);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						vo.setFollowers_count(rs.getInt(1));
					}
					
				}
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return list;
	}
}

/*
 * connect();
 * 
 * try { sql = ""; } catch (Exception e) { e.printStackTrace(); } finally {
 * disconnect(rs, pstmt, con); }
 */
