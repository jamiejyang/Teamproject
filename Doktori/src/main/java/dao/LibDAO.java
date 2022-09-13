package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;
import vo.LibVO;

public class LibDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521/xe";
	String user = "c##green";
	String password = "green1234";
	Statement stmt = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	Connection conn = null;
	public LibDAO() {

	}

	private static LibDAO instance = new LibDAO();

	public static LibDAO getInstance() {
		return instance;
	}

	public List<LibVO> selectAllLibs() {
		String sql = "select * from Lib order by num desc";

		List<LibVO> list = new ArrayList<LibVO>();

		try {
			conn = DBManager.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				LibVO lvo = new LibVO();

				lvo.setBookKey("bookKey");
				lvo.setSpeciesKey("speciesKey");
				lvo.setLibName("libName");
				lvo.setManageCode("manageCode");
				lvo.setRegNo("regNo");
				lvo.setControlNo("controlNo");
				lvo.setCallNo("callNo");
				lvo.setShelfLocName("shelfLocName");
				lvo.setTitle("title");
				lvo.setAuthor("author");
				lvo.setPublisher("publisher");
				lvo.setPubYear("pubYear");
				lvo.setIsbn("isbn");

				list.add(lvo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, stmt, rs);
		}

		return list;
	}

	public boolean insertLib(LibVO lvo) {
//		Statement stmt = null;
//		ResultSet rs = null;
//		PreparedStatement pstmt = null;
//		Connection conn = null;
		connDB();
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String sql = "insert into booklist(bookKey,speciesKey,libName,manageCode,regNo,controlNo,callNo,shelfLocName,title,author,publisher,pubyear,isbn) "
					+ "values('" 
					+lvo.getBookKey()+"','"
					+lvo.getSpeciesKey()+"','"
					+lvo.getLibName()+"','"
					+lvo.getManageCode()+"','"
					+lvo.getRegNo()+"','"
					+lvo.getControlNo()+"','"
					+lvo.getCallNo()+"','"
					+lvo.getShelfLocName()+"','"
					+lvo.getTitle()+"','"
					+lvo.getAuthor()+"','"
					+lvo.getPublisher()+"','"
					+lvo.getPubYear()+"','"
					+lvo.getIsbn()+"')";
					
					
			rs = stmt.executeQuery(sql);

			if (rs.getRow() == 0) {
				System.out.println("0 row selected...");
			} else {
				return true;

			}

		} catch (Exception e) {
			System.out.println("삽입 중 오류 발생");
			e.printStackTrace();
		}
//		finally {
//			DBManager.close(conn, pstmt);
//		}

		return false;
	}
	public void connDB() {
	
		try {
			Class.forName(driver);
			System.out.println("jdbc driver loading success.");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("oracle connection success.");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			System.out.println("statement create success.\n");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//	public void insertLib(LibVO lvo) {
//		String sql = "insert into Lib(" + "num, name, email, pass, title, content) "
//				+ "values(BLib_SEQ.nextval, ?, ?, ?, ?, ?)";
//
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = DBManager.getConnection();
//			pstmt = conn.prepareStatement(sql);
//
//			pstmt.setString(1, lvo.getBookKey());
//	pstmt.setString(2, lvo.getSpeciesKey());
//	pstmt.setString(3, lvo.getLibName());
//	pstmt.setString(4, lvo.getManageCode());
//	pstmt.setString(5, lvo.getRegNo());
//	pstmt.setString(6, lvo.getControlNo());
//	pstmt.setString(7, lvo.getCallNo());
//	pstmt.setString(8, lvo.getShelfLocName());
//	pstmt.setString(9, lvo.getTitle());
//	pstmt.setString(10, lvo.getAuthor());
//	pstmt.setString(11, lvo.getPublisher());
//	pstmt.setString(12, lvo.getPubYear());
//	pstmt.setString(13, lvo.getIsbn());

//
//			pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBManager.close(conn, pstmt);
//		}
//	}

//	public void updateReadCount(String num) {
//		String sql = "update Lib set readcount=readcount+1 where num=?";
//
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = DBManager.getConnection();
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, num);
//
//			pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBManager.close(conn, pstmt);
//		}
//	}

//	public LibVO selectOneLibByNum(String num) {
//		String sql = "select * from Lib where num = ?";
//
//		LibVO lvo = null;
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			conn = DBManager.getConnection();
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, num);
//
//			rs = pstmt.executeQuery();
//
//			if (rs.next()) {
//				lvo = new LibVO();
//
//				lvo.setNum(rs.getInt("num"));
//				lvo.setName(rs.getString("name"));
//				lvo.setPass(rs.getString("pass"));
//				lvo.setEmail(rs.getString("email"));
//				lvo.setTitle(rs.getString("title"));
//				lvo.setContent(rs.getString("content"));
//				lvo.setWritedate(rs.getTimestamp("writedate"));
//				lvo.setReadcount(rs.getInt("readcount"));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			DBManager.close(conn, pstmt, rs);
//		}
//		return lvo;
//	}

//	public void updateLib(LibVO lvo) {
//		String sql = "update Lib set name=?, email=?, pass=?, " + "title=?, content=? where num=?";
//
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = DBManager.getConnection();
//			pstmt = conn.prepareStatement(sql);
//
//			pstmt.setString(1, lvo.getName());
//			pstmt.setString(2, lvo.getEmail());
//			pstmt.setString(3, lvo.getPass());
//			pstmt.setString(4, lvo.getTitle());
//			pstmt.setString(5, lvo.getContent());
//			pstmt.setInt(6, lvo.getNum());
//
//			pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBManager.close(conn, pstmt);
//		}
//	}

//	public LibVO checkPassWord(String pass, String num) {
//		String sql = "select * from Lib where pass=? and num=?";
//
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		LibVO lvo = null;
//
//		try {
//			conn = DBManager.getConnection();
//			pstmt = conn.prepareStatement(sql);
//
//			pstmt.setString(1, pass);
//			pstmt.setString(2, num);
//			rs = pstmt.executeQuery();
//
//			if (rs.next()) {
//				lvo = new LibVO();
//
//				lvo.setNum(rs.getInt("num"));
//				lvo.setName(rs.getString("name"));
//				lvo.setEmail(rs.getString("email"));
//				lvo.setPass(rs.getString("pass"));
//				lvo.setTitle(rs.getString("title"));
//				lvo.setContent(rs.getString("content"));
//				lvo.setReadcount(rs.getInt("readcount"));
//				lvo.setWritedate(rs.getTimestamp("writedate"));
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return lvo;
//	}
//
//	public void deleteLib(String num) {
//		String sql = "delete Lib where num=?";
//
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = DBManager.getConnection();
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, num);
//			pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}
}
