package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import common.DBConnPool;
import dto.LibDTO;
import dto.LikesDTO;

public class LikesDAO extends DBConnPool {

	public LikesDAO() {
		super();
	}

	public LikesDAO(ServletContext applicattion) {
		super();
	}
	public int selectCount(Map<String,Object> map) {
		int totalCount =0;
		String sql="Select count(*) from likes";
		if(map.get("searchWord")!=null) {
			sql+="where "+map.get("searchField")+" Like '%"+map.get("searchWord")+"%'";
		}
		try {
			stmt= con.createStatement();
			rs=stmt.executeQuery(sql);
			rs.next();
			totalCount= rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("관심도서 수 구하는 중 오류 발생");
		}
		return totalCount;
	}
	public int LikeSearch(String id, String book_num) {
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
	public List<LibDTO> selectLike(Map<String, Object> map ,String id) {
		List<LibDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM (  SELECT TB.*, ROWNUM rNum FROM (  SELECT  l.id, l.book_num, b.BOOKKEY ,b.SPECIESKEY , b.LIBNAME ,b.MANAGECODE ,b.REGNO ,b.CONTROLNO ,b.CALLNO ,b.SHELFLOCNAME ,b.TITLE ,b.AUTHOR ,b.PUBLISHER ,b.PUBYEAR ,b.ISBN FROM LIKES l , BOOKLIST b  WHERE b.BOOK_NUM =l.BOOK_NUM  AND l.id= ? ";
		if(map.get("searchWord")!=null) {
			sql+= "and "+map.get("searchField")+" Like '%"+map.get("searchWord")+"%' ";
		}
		sql+= "ORDER BY l.book_num desc  ) TB  )  WHERE rNum BETWEEN ? AND ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, map.get("start").toString());
			psmt.setString(3, map.get("end").toString());
			rs=psmt.executeQuery();
			
			while(rs.next()) {
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
			e.printStackTrace();
			System.out.println("관심도서 조회 중 오류 발생");
		}
		return list;
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

	public int AdmindeleteLike(String id[]) {
		int result = 0;
		String sql = "delete from likes ";
		if (id.length != 0) {
			sql += "where id ='";
			for (int i = 0; i < id.length; i++) {
				sql += id[i];
				if (i != (id.length - 1)) {
					sql += "' and id ='";
				} else {
					sql += "'";
				}
			}
		}
		try {
			psmt = con.prepareStatement(sql);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원 탈퇴를 위한 찜목록 삭제 중 오류 발생");
		}
		return result;
	}
}
