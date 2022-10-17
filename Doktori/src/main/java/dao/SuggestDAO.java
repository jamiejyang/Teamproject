package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

//import comment.ArrayList;
//import comment.Comment;
//import comment.Exception;
//import comment.PreparedStatement;
//import comment.String;
import common.DBConnPool;
import dto.Comment2DTO;
import dto.SuggestDTO;

public class SuggestDAO extends DBConnPool {
	
	public SuggestDAO(ServletContext application) {
		
	}
	public SuggestDAO() {
		super();
	}

	// 검색 조건에 맞는 게시물의 개수를 반환
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0; // 결과(게시물 수)를 담을 변수

		String query = "select count(*) from suggestboard";
		if (map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " " + " like '%" + map.get("searchWord") + "%'";
		}

		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next(); // 커서를 첫번째 행으로 이동
			totalCount = rs.getInt(1); // 첫번째 컬럼 값을 가져옴
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}

		return totalCount;
	}

	// 검색 조건에 맞는 게시물 목록을 반환
	public List<SuggestDTO> selectList(Map<String, Object> map) {
		List<SuggestDTO> bbs = new Vector<SuggestDTO>(); // 결과(게시물 목록)를 담을 변수

		String query = "select * from suggestboard";
		if (map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " " + " like '%" + map.get("searchWord") + "%' "; // searchWord에
			// 있는 글자를
			// 포함하고 있는
			// 모든 문자를
			// 반환함
		}
		query += " order by num desc ";
		System.out.println(query);
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				SuggestDTO dto = new SuggestDTO();

				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setProcessing(rs.getString("processing"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setWritedate(rs.getDate("writedate"));
				dto.setReadcount(rs.getString("readcount"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));

				bbs.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}

		return bbs;
	}

	// 검색 조건에 맞는 게시물 목록을 반환합니다(페이징 가능 지원).
	public List<SuggestDTO> selectListPage(Map<String, Object> map) {
		List<SuggestDTO> bbs = new Vector<SuggestDTO>(); // 결과(게시물 목록)를 담을 변수

		// 쿼리문 템플릿
		String query = " SELECT * FROM ( " + "   SELECT Tb.*, ROWNUM rNUM FROM ( "
				+ "      SELECT * FROM suggestboard ";
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
				SuggestDTO dto = new SuggestDTO();
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setProcessing(rs.getString("processing"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setWritedate(rs.getDate("writedate"));
				dto.setReadcount(rs.getString("readcount"));
//				dto.setFiles(rs.getString("files"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				// 반환할 결과 목록에 게시물 추가
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		// 목록 반환
		return bbs;
	}

	// 게시글 데이터를 받아 DB에 추가.
	public int insertWrite(SuggestDTO dto) {
		int result = 0;

		try {

			// insert 쿼리문 작성
			String sql = "insert into suggestboard (num, title, content, id, pass,ofile, sfile, readcount) "
					+ "values (seq_board_num.nextval, ?,?,?,?,?,?,0)";
			System.out.println(sql);
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getPass());
			psmt.setString(5, dto.getOfile());
			psmt.setString(6, dto.getSfile());
//			psmt.setString(5, dto.getFiles());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	// 지정한 게시물을 찾아 내용을 반환
	public SuggestDTO selectView(String num) {
		SuggestDTO dto = new SuggestDTO();

		String sql = "select * " + " from suggestboard s, dmember d " + " where s.id= d.id and num=?";
		System.out.println(sql);
		try {

			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setWritedate(rs.getDate("writedate"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setReadcount(rs.getString(8));
//				dto.setFiles(rs.getString(9));
				dto.setOfile(rs.getString(9));
				dto.setSfile(rs.getString(10));
				System.out.println(rs.getString("id"));
			}
		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}

	// 지정한 게시물의 조회수즐 1 증가
	public void updateReadCount(String num) {
		String sql = "update suggestboard set " + " readcount = readcount+1 " + " where num=?";
		System.out.println(sql);
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			psmt.executeQuery();
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}

	// 지정한 게시물을 수정
	public int updateEdit(SuggestDTO dto) {
		int result = 0;

		try {
			String sql = "update suggestboard set title=?, content=?, ofile=?, sfile=? where num=?";

			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
//			psmt.setString(3, dto.getFiles());
			psmt.setString(5, dto.getNum());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}

		return result;
	}

	public int deletePost(SuggestDTO dto) {
		int result = 0;
		try {

			String query = "DELETE FROM suggestboard WHERE num=?";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}

		return result;
	}
	
	public int checkPass(SuggestDTO dto) {
		int result = 1;
		try {
			
			String query = "SELECT * FROM SUGGESTBOARD WHERE NUM =?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
			}
			
		} catch(Exception e) {
			System.out.println("비밀번호 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
			
		}
	
	// 댓글 쓰기 기능
	public int insertComment(Comment2DTO dto) {
		int result = 0;
		
		try {

			// insert 쿼리문 작성
			String sql = "insert into suggestcomment (cmtnum, bbsnum, cmtid, cmtcontent) "
					+ "values (seq_commentboard_num.nextval, ?, ?, ?)";
			System.out.println(sql);
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getBbsNum());
			psmt.setString(2, dto.getCmtID());
			psmt.setString(3, dto.getCmtContent());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("댓글 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 댓글 목록
	public ArrayList<Comment2DTO> getList(String bbsnum){
		String SQL = "SELECT * FROM suggestcomment WHERE bbsnum= ?"; 
		ArrayList<Comment2DTO> list = new ArrayList<Comment2DTO>();
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, bbsnum);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Comment2DTO cmt = new Comment2DTO();
				cmt.setCmtNum(rs.getString(1));
				cmt.setBbsNum(rs.getString(2));
				cmt.setCmtID(rs.getString(3));
				cmt.setCmtDate(rs.getDate(4));
				cmt.setCmtContent(rs.getString(5));
				list.add(cmt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 댓글 삭제
	public int deleteComment(Comment2DTO dto) {
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
	
	// 댓글 카운트
	public int countComment(int bbsnum) {
		int result = 0;
		try {
			
			String query = "SELECT count(cmtnum) AS cmtcount FROM suggestcomment s WHERE bbsnum=?";
			
			psmt = con.prepareStatement(query);
			psmt.setInt(1, bbsnum);
			
			rs = psmt.executeQuery();
			
			if(rs.next())
				result = rs.getInt("cmtcount");
		} catch (Exception e) {
			System.out.println("댓글 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
}