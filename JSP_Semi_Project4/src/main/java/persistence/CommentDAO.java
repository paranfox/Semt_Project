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
import model.*;

public class CommentDAO {

	private DataSource ds;

	Connection con = null;

	PreparedStatement pstmt = null;

	ResultSet rs = null;

	String sql = null;

	private static CommentDAO dao;

	public CommentDAO() {

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

	public static CommentDAO getInstance() {

		if (dao == null) {
			dao = new CommentDAO();
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

	public void insertComment(CommentVO comment) {
		connect();
		try {
			String sql = "INSERT INTO comments (album_id, user_id, content) VALUES (?, ?, ?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, comment.getAlbum_id());
			pstmt.setString(2, comment.getUser_id());
			pstmt.setString(3, comment.getContent());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
	}

	public List<CommentVO> getCommentsByAlbumId(int album_id) {
		List<CommentVO> comments = new ArrayList<>();
		connect();
		try {
			String sql = "SELECT * FROM comments WHERE album_id = ? ORDER BY created_at DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, album_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				CommentVO comment = new CommentVO();
				comment.setComment_id(rs.getInt("comment_id"));
				comment.setAlbum_id(rs.getInt("album_id"));
				comment.setUser_id(rs.getString("user_id"));
				comment.setContent(rs.getString("content"));
				comment.setCreated_at(rs.getTimestamp("created_at"));

				comments.add(comment);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return comments;
	}

}