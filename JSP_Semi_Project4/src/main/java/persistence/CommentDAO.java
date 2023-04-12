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
			// 사용자 프로필 사진 정보를 가져오도록 SQL 쿼리를 수정합니다.
			String sql = "SELECT c.*, u.user_pic , u.user_nickname FROM comments c INNER JOIN user u ON c.user_id = u.user_id WHERE album_id = ? ORDER BY created_at DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, album_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CommentVO comment = new CommentVO();
				comment.setComment_id(rs.getInt("comment_id"));
				comment.setAlbum_id(rs.getInt("album_id"));
				comment.setUser_id(rs.getString("user_id"));
				comment.setContent(rs.getString("content"));
				comment.setCreated_at(rs.getTimestamp("created_at")); // 댓글 작성 날짜를 나타냅니다.
				comment.setUser_pic(rs.getString("user_pic")); // 프로필 사진 정보를 CommentVO에 설정합니다.
				comment.setUser_nickname(rs.getString("user_nickname")); // 유저 닉네임 정보를 받을수 있게 CommentVO에 설정합니다.

				comments.add(comment);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return comments;
	}

	public void updateComment(CommentVO comment) {

		connect();

		try {

			String sql = "UPDATE comments set content = ? where comment_id = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(2, comment.getComment_id());

			pstmt.setString(1, comment.getContent());

			pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			disconnect(rs, pstmt, con);

		}
	}

	public CommentVO getCommentById(int comment_id) {
		CommentVO comment = null;
		connect();
		try {
			String sql = "SELECT c.*, u.user_pic FROM comments c INNER JOIN user u ON c.user_id = u.user_id WHERE comment_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comment_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				comment = new CommentVO();
				comment.setComment_id(rs.getInt("comment_id"));
				comment.setAlbum_id(rs.getInt("album_id"));
				comment.setUser_id(rs.getString("user_id"));
				comment.setContent(rs.getString("content"));
				comment.setCreated_at(rs.getTimestamp("created_at"));
				comment.setUser_pic(rs.getString("user_pic"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}

		return comment;
	}

	public boolean deleteComment(int commentId) {
		connect();
		try {
			sql = "DELETE FROM comments WHERE comment_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentId);
			int result = pstmt.executeUpdate();
			if (result > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect(rs, pstmt, con);
		}
		return false;
	}

}