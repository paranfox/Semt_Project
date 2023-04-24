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

import model.MusicVO;
import model.UserVO;

public class UserDAO {
	private DataSource ds;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	private static UserDAO dao;

	private UserDAO() {

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

	public static UserDAO getInstance() {
		if (dao == null) {
			dao = new UserDAO();
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

	public int getListCount() {
		connect();
		int count = 0;
		try {

			sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return count;
	}

	public boolean registerUser(UserVO vo) {
		connect();

		try {

			String sql = "insert into user values(?,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, vo.getUser_id());
			pstmt.setString(2, vo.getUser_pwd());
			pstmt.setString(3, vo.getUser_name());
			pstmt.setString(4, vo.getUser_nickname());
			pstmt.setString(5, vo.getUser_email());
			pstmt.setString(6, vo.getUser_phone());
			pstmt.setString(7, vo.getUser_pic());

			pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();


			disconnect(rs, pstmt, con);

		}

		return true;

	}

	public int logincheck(String id, String pwd) {
		connect();
		String dbPwd = "";
		int check = -1;
		sql = "SELECT USER_PWD FROM USER WHERE USER_ID = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbPwd = rs.getString("user_pwd");
				if (dbPwd.equals(pwd)) {
					check = 1;
				} else {
					check = 0;
				}
			} else {
				check = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return check;
	}

	public UserVO userContent(String id) {
		UserVO vo = null;

		connect();

		sql = "SELECT * FROM USER WHERE USER_ID = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				vo = new UserVO();

				vo.setUser_id(rs.getString("user_id"));
				vo.setUser_pwd(rs.getString("user_pwd"));
				vo.setUser_name(rs.getString("user_name"));
				vo.setUser_nickname(rs.getString("user_nickname"));
				vo.setUser_email(rs.getString("user_email"));
				vo.setUser_phone(rs.getString("user_phone"));
				vo.setUser_pic(rs.getString("user_pic"));

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return vo;
	}

	public String getUserNickname(String id) {
		connect();

		String user_nickname = "";

		UserVO vo = new UserVO();

		try {

			sql = "SELECT USER_NICKNAME FROM USER WHERE USER_ID = ?";

			this.pstmt = this.con.prepareStatement(this.sql);

			this.pstmt.setString(1, id);

			this.rs = this.pstmt.executeQuery();

			if (this.rs.next()) {

				user_nickname = this.rs.getString("user_nickname");

				vo.setUser_nickname(user_nickname);

			}

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			disconnect(rs, pstmt, con);

		}
		return user_nickname;
	}

	// 마이페이지 view페이지로 보여주기
	public List<UserVO> myPage(String user_id) {

		List<UserVO> list = new ArrayList<UserVO>();

		try {
			connect();

			sql = "select * from user where user_id = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				UserVO vo = new UserVO();

				vo.setUser_id(rs.getString("user_id"));
				vo.setUser_pwd(rs.getString("user_pwd"));
				vo.setUser_name(rs.getString("user_name"));
				vo.setUser_nickname(rs.getString("user_nickname"));
				vo.setUser_email(rs.getString("user_email"));
				vo.setUser_phone(rs.getString("user_phone"));
				vo.setUser_pic(rs.getString("user_pic"));

				list.add(vo);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return list;
	}
	public void getMyProfile(String user_nick) {
		// TODO Auto-generated method stub

	}

	public UserVO getProfile_pic(String id) {
		UserVO vo = null;
		connect();
		try {
			sql = "select user_pic from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new UserVO();
				vo.setUser_pic(rs.getString("user_pic"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return vo;
	}
	
	

	public int checkNameToEmail(String name, String email) {

		int result = 0;
		String db_name = "";

		connect();

		sql = "SELECT USER_NAME FROM USER WHERE USER_EMAIL = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				db_name = rs.getString(1);
			}

			if (name.equals(db_name)) {
				result = 1;
			} else if (!name.equals(db_name) && !db_name.equals("")) {
				// 이름이 다른 경우
				result = -1;
			} else if (db_name.equals("")) {
				result = 0;// 이메일이 다른 경우 result = 0;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	} // checkNameAndId end

	public String findUserId(String email) {
		String user_id = "";
		
		connect();
		
		sql = "SELECT USER_ID FROM USER WHERE USER_EMAIL = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user_id = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user_id;
	} // findUserId end
	
	
	public int checkIdToEmail(String id, String email) {
		int result = 0;
		String db_id = "";

		connect();

		sql = "SELECT USER_ID FROM USER WHERE USER_EMAIL = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				db_id = rs.getString(1);
			}

			if (id.equals(db_id)) {
				result = 1;
			} else if (!id.equals(db_id) && !db_id.equals("")) {
				// 아이디가 다른 경우
				result = -1;
			} else if (db_id.equals("")) {
				result = 0;// 이메일이 다른 경우 result = 0;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}	// checkIdToEmail end

	public int modifyPwd(String user_id, String user_pwd) {
		
		int result = 0;
		
		connect();
		
		try {
			
			sql = "UPDATE USER SET USER_PWD = ? WHERE USER_ID = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, user_pwd);
			pstmt.setString(2, user_id);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		
		return result;
		
	}	// modifyPwd end
	
	// 유저 정보 수정 메서드
	public UserVO modify(String user_id) {

		UserVO vo = new UserVO();

		try {
			connect();

			String sql = "select * from user where user_id = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery(); // 쿼리 실행

			if (rs.next()) {
				vo.setUser_id(rs.getString("user_id"));
				vo.setUser_pwd(rs.getString("user_pwd"));
				vo.setUser_name(rs.getString("user_name"));
				vo.setUser_nickname(rs.getString("user_nickname"));
				vo.setUser_phone(rs.getString("user_phone"));
				vo.setUser_pic(rs.getString("user_pic"));
				vo.setUser_email(rs.getString("user_email"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return vo;
	}		// 유저 정보 수정 메서드 end

	// 유저 업데이트 메서드 시작
	public int updateUser(UserVO vo) {
		connect();

		int result = 0;

		try {

			sql = "update user set user_name = ?, user_nickname = ?, user_phone = ?, user_email = ?, user_pic = ? where user_id = ?";

			pstmt = con.prepareStatement(sql);
		
			pstmt.setString(1, vo.getUser_name());
			pstmt.setString(2, vo.getUser_nickname());
			pstmt.setString(3, vo.getUser_phone());
			pstmt.setString(4, vo.getUser_email());
			pstmt.setString(5, vo.getUser_pic());
			pstmt.setString(6, vo.getUser_id());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return result;
	} // 유저 업데이트 메서드 end
	
	
	// 유저 탈퇴 메서드 시작
	public int deleteUser(String user_id) {
		
		connect();
		
		int result = 0;
		
		try {
			
			sql = "DELETE FROM user WHERE user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return result;
		
	}	// 유저 탈퇴 메서드 종료
	
	
}
