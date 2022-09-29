package dao;

import javax.servlet.ServletContext;

import common.DBConnPool;
import dto.LikesDTO;

public class LikesDAO extends DBConnPool {

	public LikesDAO() {
		super();
	}

	public LikesDAO(ServletContext applicattion) {
		super();
	}

	public int selectLikes(String id, String book_num) {
		int result = 0;
		String sql = "select * from likes where id= ? and book_num= ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, book_num);

			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("관심도서 조회 중 오류 발생");
		}
		return result;
	}

	public int insertLike(LikesDTO dto) {
		int result = 0;
		try {
			String sql = "INSERT INTO LIKES (id,book_num) " + "values(?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getBooknum());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("관심도서 등록 중 오류 발생");
		}
		return result;
	}

	public int deleteLike(String id, String booknum) {
		int result = 0;
		try {
			String sql = "delete from likes where id= ? and book_num = ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, booknum);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("관심도서 삭제 중 오류 발생");
		}
		return result;

	}
}
