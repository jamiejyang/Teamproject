package dao;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

import dto.Comment2DTO;

public class Comment2DAO extends DBConnPool{
	public Comment2DAO() {
		super();
	}
	
	public int insertComment(Comment2DTO dto) {
		int result = 0;
		
		try {

			// insert 쿼리문 작성
			String sql = "insert into suggestcomment (cmtnum, bbsnum, cmtid, cmtdate, cmtcontent) "
					+ "values (seq_commentboard_num.nextval, ?, ?,?,  ?)";
			System.out.println(sql);
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getBbsNum());
			psmt.setString(2, dto.getCmtID());
			psmt.setDate(3, dto.getCmtDate());
			psmt.setString(4, dto.getCmtContent());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("댓글 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 검색 조건에 맞는 게시물 목록을 반환합니다(페이징 가능 지원).
	public List<Comment2DTO> selectCommentListPage(Map<String, Object> map) {
		List<Comment2DTO> bbs = new Vector<Comment2DTO>(); // 결과(게시물 목록)를 담을 변수

		// 쿼리문 템플릿
		String query = " SELECT * FROM ( " + "   SELECT Tb.*, ROWNUM rNUM FROM ( "
				+ "      SELECT * FROM suggestcomment ";
		// 검색 조건 추가
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}

		query += "      ORDER BY num DESC " + "     ) Tb " + " ) " + " WHERE rNUM BETWEEN ? AND ?";

		try {
			// 쿼리문 완성
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());

			// 쿼리문 실행
			rs = psmt.executeQuery();

			while (rs.next()) {
				// 한 행(게시물 하나)의 데이터를 DTO에 저장
				Comment2DTO dto = new Comment2DTO();
				dto.setCmtNum(rs.getString("cmtnum"));
				dto.setBbsNum(rs.getString("bbsnum"));
				dto.setCmtID(rs.getString("cmtid"));
				dto.setCmtDate(rs.getDate("cmtdate"));
				dto.setCmtContent(rs.getString("cmtcontent"));
				// 반환할 결과 목록에 게시물 추가
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("댓글 조회 중 예외 발생");
			e.printStackTrace();
		}
		// 목록 반환
		return bbs;
	}
	
	public int deletePost(Comment2DTO dto) {
		int result = 0;
		try {

			String query = "DELETE FROM suggestcomment WHERE cmtnum=?";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getCmtNum());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("댓글 삭제 중 예외 발생");
			e.printStackTrace();
		}

		return result;
	}
}
