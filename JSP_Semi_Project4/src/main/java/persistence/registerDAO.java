package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class registerDAO {

	private DataSource ds;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	private static registerDAO dao;

	private registerDAO() {
		
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

	public static registerDAO getInstance() {
		if (dao == null) {
			dao = new registerDAO();
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

	public int checkId(String user_id) {
		connect();
		String sql = "select * from user where user_id =?";
		int idCheck = 0;

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			if (rs.next() || user_id.equals("")) {
				idCheck = 0;
			} else {
				idCheck = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return idCheck;
	}

	public int checkNickname(String user_nickname) {
		connect();
		String sql = "select * from user where user_nickname= ?";
		int idCheck = 0;

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_nickname);

			rs = pstmt.executeQuery();

			if (rs.next() || user_nickname.equals("")) {
				idCheck = 0;
			} else {
				idCheck = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return idCheck;
	}

}
