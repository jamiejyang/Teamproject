package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

//import javax.servlet.RequestDispatscher;
import javax.servlet.ServletContext;

import common.DBConnPool;
import dto.LibDTO;

public class LibDAO extends DBConnPool {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521/xe";
	String user = "c##green";
	String password = "green1234";
	Statement stmt = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	Connection conn = null;

	public LibDAO(ServletContext applicattion) {
		super();
	}

	public LibDAO() {
		super();
	}

	public int selectCount(Map<String, Object> map, String[] name) { // 게시물 수 넣어주기
		int totalCount = 0;

		String sql = "SELECT count(*) FROM booklist ";
		if(name==null && map.get("searchWord")==null) {
			System.out.println("여기 4");
		}
		else if (name == null && map.get("searchWord") != null) {
			sql += "WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%'";
			System.out.println("여기 1");
		} else if (name != null) {
			sql += "  Where " + " (LIBNAME ='";
			for (int i = 0; i < name.length; i++) {
				sql += name[i];
				if (i != (name.length - 1)) {
					sql += "' OR LIBNAME ='";
				} else {
					sql += "') AND ";
				}
			}
			if (map.get("searchWord") != null) {
				sql += " " + map.get("searchField") + " LiKE '%" + map.get("searchWord") + "%' ";
				System.out.println("여기 2");
			} else {
				sql += " title LIKE '%%' ";
				System.out.println("여기 3");
			}
		}
		System.out.println(sql+"카운트 sql");
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			totalCount = rs.getInt(1); // 0으로바꿨을때 0부터 뜸
		} catch (Exception e) {
			System.out.println("게시물 수 를 구하는 중 예외 발생");
			e.printStackTrace();
		}

		return totalCount;
	}

	public List<LibDTO> libList() {
		List<LibDTO> list = new ArrayList<>();
		String sql = "SELECT DISTINCT  LIBNAME  FROM BOOKLIST b ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				LibDTO dto = new LibDTO();

				dto.setLibName(rs.getString("libname"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("도서관 가져오는 중오류발생");
		}

		return list;
	}

	public List<LibDTO> Select(Map<String, Object> map, String[] name) {
		List<LibDTO> list = new ArrayList<>();

		String sql = "SELECT * FROM booklist ";
		if(name==null && map.get("searchWord")==null) {
			System.out.println("셀렉트1");
		}
		else if (name == null && map.get("searchWord") != null) {
			sql += "WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%'";
			System.out.println("셀렉2");
		} else if (name != null) {
			sql += "  Where " + " (LIBNAME ='";
			for (int i = 0; i < name.length; i++) {
				sql += name[i];
				if (i != (name.length - 1)) {
					sql += "' OR LIBNAME ='";
				} else {
					sql += "') AND ";
				}
			}
			if (map.get("searchWord") != null) {
				sql += " " + map.get("searchField") + " LiKE '%" + map.get("searchWord") + "%' ";
				System.out.println("셀렑3");
			} else {
				sql += " title LIKE '%%' ";
				System.out.println("셀렉 4");
			}
		}
		System.out.println(sql+" 셀렉트 sql");
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				LibDTO dto = new LibDTO();
				dto.setBookNum(rs.getString("book_num"));
				dto.setBookKey(rs.getString("bookkey"));
				dto.setSpeciesKey(rs.getString("specieskey"));
				dto.setLibName(rs.getString("libname"));
				dto.setManageCode(rs.getString("managecode"));
				dto.setRegNo(rs.getString("regno"));
				dto.setControlNo(rs.getString("controlno"));
				dto.setCallNo(rs.getString("callno"));
				dto.setShelfLocName(rs.getString("shelflocname"));
				dto.setTitle(rs.getString("title"));
				dto.setAuthor(rs.getString("author"));
				dto.setPublisher(rs.getString("publisher"));
				dto.setPubYear(rs.getString("pubyear"));
				dto.setIsbn(rs.getString("isbn"));
				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("테스트 검색 중 오류 발생");
			e.printStackTrace();
		}

		return list;
	}

	public List<LibDTO> selectBook(Map<String, Object> map) { // 단일 권 찾기
		List<LibDTO> list = new ArrayList<LibDTO>();
		String sql = "SELECT * FROM BOOKLIST b ";
		if (map.get("searchWord") != null) {
			sql += "Where " + map.get("searchField") + " " + " Like '%" + map.get("searchWord") + "%'";
		}
		sql += " ORDER BY libname asc ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				LibDTO dto = new LibDTO();
				dto.setBookNum(rs.getString("book_num"));
				dto.setBookKey(rs.getString("bookkey"));
				dto.setSpeciesKey(rs.getString("specieskey"));
				dto.setLibName(rs.getString("libname"));
				dto.setManageCode(rs.getString("managecode"));
				dto.setRegNo(rs.getString("regno"));
				dto.setControlNo(rs.getString("controlno"));
				dto.setCallNo(rs.getString("callno"));
				dto.setShelfLocName(rs.getString("shelflocname"));
				dto.setTitle(rs.getString("title"));
				dto.setAuthor(rs.getString("author"));
				dto.setPublisher(rs.getString("publisher"));
				dto.setPubYear(rs.getString("pubyear"));
				dto.setIsbn(rs.getString("isbn"));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("검색 중 오류 발생");
			e.printStackTrace();
		}

		return list;
	}

	public boolean insertLib(LibDTO lvo) { // db에 책 삽입할떄
		connDB();
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String sql = "insert into booklist(bookKey,speciesKey,libName,manageCode,regNo,controlNo,callNo,shelfLocName,title,author,publisher,pubyear,isbn,book_num) "
					+ "values('" + lvo.getBookKey() + "','" + lvo.getSpeciesKey() + "','" + lvo.getLibName() + "','"
					+ lvo.getManageCode() + "','" + lvo.getRegNo() + "','" + lvo.getControlNo() + "','"
					+ lvo.getCallNo() + "','" + lvo.getShelfLocName() + "','" + lvo.getTitle() + "','" + lvo.getAuthor()
					+ "','" + lvo.getPublisher() + "','" + lvo.getPubYear() + "','" + lvo.getIsbn() + "',"
					+ "book_num.nextval" + ")";

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

		return false;
	}

	public void connDB() { // API Insert 시

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

}
