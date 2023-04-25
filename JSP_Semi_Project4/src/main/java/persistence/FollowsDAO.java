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

		try {
			connect();

			String sql1 = null;
			String sql2 = null;

			PreparedStatement pstmt1 = null;
			PreparedStatement pstmt2 = null;

			ResultSet rs1 = null;
			ResultSet rs2 = null;

			// 게시판 아이디를 팔로우하는 유저 조회
			sql = "SELECT follower_id FROM follows WHERE followed_id = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bbs_id);

			rs = pstmt.executeQuery();

			// 유저가 있는 동안에,
			while (rs.next()) {

				// 팔로워 프로필 vo 생성
				FollowersProfileVO vo = new FollowersProfileVO();

				String followers_id = rs.getString("follower_id");

				vo.setFollower_id(followers_id);

				sql1 = "SELECT COUNT(followed_id) FROM follows WHERE followed_id = ?";

				pstmt1 = con.prepareStatement(sql1);
				pstmt1.setString(1, followers_id);

				rs1 = pstmt1.executeQuery();

				if (rs1.next()) {
					vo.setFollowers_count(rs1.getInt(1));

					sql2 = "SELECT * FROM user WHERE user_id = ?";
					pstmt2 = con.prepareStatement(sql2);
					pstmt2.setString(1, followers_id);

					rs2 = pstmt2.executeQuery();

					if (rs2.next()) {
						vo.setUser_nickname(rs2.getString("user_nickname"));
						vo.setUser_pic(rs2.getString("user_pic"));
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
	
	
	public List<FollowersProfileVO> getFollowingList(String bbs_id) {

		List<FollowersProfileVO> list = new ArrayList<FollowersProfileVO>();

		try {
			connect();

			String sql1 = null;
			String sql2 = null;

			PreparedStatement pstmt1 = null;
			PreparedStatement pstmt2 = null;

			ResultSet rs1 = null;
			ResultSet rs2 = null;

			// 게시판 아이디를 팔로우하는 유저 조회
			sql = "SELECT followed_id FROM follows WHERE follower_id = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bbs_id);

			rs = pstmt.executeQuery();

			// 유저가 있는 동안에,
			while (rs.next()) {

				// 팔로워 프로필 vo 생성
				FollowersProfileVO vo = new FollowersProfileVO();

				String following_id = rs.getString("followed_id");

				vo.setFollower_id(following_id);

				sql1 = "SELECT COUNT(followed_id) FROM follows WHERE followed_id = ?";

				pstmt1 = con.prepareStatement(sql1);
				pstmt1.setString(1, following_id);

				rs1 = pstmt1.executeQuery();

				if (rs1.next()) {
					vo.setFollowers_count(rs1.getInt(1));

					sql2 = "SELECT * FROM user WHERE user_id = ?";
					pstmt2 = con.prepareStatement(sql2);
					pstmt2.setString(1, following_id);

					rs2 = pstmt2.executeQuery();

					if (rs2.next()) {
						vo.setUser_nickname(rs2.getString("user_nickname"));
						vo.setUser_pic(rs2.getString("user_pic"));
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
