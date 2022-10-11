package dao;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.DBConnPool;
import dto.ReviewDTO;

public class ReviewDAO extends DBConnPool{
	
	public ReviewDAO() {
		super();
	}
	
	public ReviewDAO(ServletContext applicattion) {
		super();
	}

	// 검색 조건에 맞는 게시물의 개수를 반환
		public int selectCount(Map<String, Object> map) {
			int totalCount = 0; // 결과(게시물 수)를 담을 변수

			String query = "select count(*) from REVIEWBOARD";
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



//		// 검색 조건에 맞는 게시물 목록을 반환합니다(페이징 가능 지원).
//		public List<ReviewDTO> selectListPage(Map<String, Object> map) {
//			List<ReviewDTO> bbs = new Vector<ReviewDTO>(); // 결과(게시물 목록)를 담을 변수
//
//			// 쿼리문 템플릿
//			String query = " SELECT * FROM ( " + "   SELECT Tb.*, ROWNUM rNUM FROM ( "
//					+ "      SELECT * FROM REVIEWBOARD ";
//			// 검색 조건 추가
//			if (map.get("searchWord") != null) {
//				query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
//			}
//
//			query += "      ORDER BY num DESC " + "     ) Tb " + " ) " + " WHERE rNUM BETWEEN ? AND ?";
//
//			try {
//				// 쿼리문 완성
//				psmt = con.prepareStatement(query);
//				psmt.setString(1, map.get("start").toString());
//				psmt.setString(2, map.get("end").toString());
//
//				// 쿼리문 실행
//				rs = psmt.executeQuery();
//
//				while (rs.next()) {
//					// 한 행(게시물 하나)의 데이터를 DTO에 저장
//					ReviewDTO dto = new ReviewDTO();
//					dto.setNum(rs.getInt("num"));
//					dto.setTitle(rs.getString("title"));
//					dto.setContent(rs.getString("content"));
//					dto.setId(rs.getString("id"));
//					dto.setPass(rs.getString("pass"));
////					dto.setParent(rs.getInt("parent"));
//					dto.setWritedate(rs.getDate("writedate"));
//					dto.setReadcount(rs.getInt("readcount"));
//					dto.setFiles(rs.getString("files"));
//					// 반환할 결과 목록에 게시물 추가
//					bbs.add(dto);
//				}
//			} catch (Exception e) {
//				System.out.println("게시물 조회 중 예외 발생");
//				e.printStackTrace();
//			}
//			// 목록 반환
//			return bbs;
//		}
		
		
		// 검색 조건에 맞는 게시물 목록을 반환(페이징, 제목옆 댓글수 지원).
		public List<ReviewDTO> selectListPage(Map<String, Object> map) {
			List<ReviewDTO> bbs = new Vector<ReviewDTO>(); // 결과(게시물 목록)를 담을 변수

			// 쿼리문 템플릿
			String query = " SELECT * FROM ( " + "   SELECT Tb.*, ROWNUM rNUM FROM ( "
					+ "      SELECT * FROM REVIEW_VIEW  ";
			// 검색 조건 추가
			if (map.get("searchWord") != null) {
				query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
			}

			query += "      ORDER BY topfix asc, num DESC " + "     ) Tb " + " ) " + " WHERE rNUM BETWEEN ? AND ?";

			try {
				// 쿼리문 완성
				psmt = con.prepareStatement(query);
				psmt.setString(1, map.get("start").toString());
				psmt.setString(2, map.get("end").toString());

				// 쿼리문 실행
				rs = psmt.executeQuery();

				while (rs.next()) {
					// 한 행(게시물 하나)의 데이터를 DTO에 저장
					ReviewDTO dto = new ReviewDTO();
					dto.setNum(rs.getInt("num"));
					dto.setTitle(rs.getString("title"));
//					dto.setContent(rs.getString("content"));
					dto.setCmtcount(rs.getInt("cmtcount"));
					dto.setId(rs.getString("id"));
					dto.setWritedate(rs.getDate("writedate"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setTopfix(rs.getInt("topfix"));
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


		
		// 지정한 게시물을 찾아 내용을 반환
		public ReviewDTO selectView(int num) {
			ReviewDTO dto = new ReviewDTO();

			String sql = "select * from REVIEWBOARD where num= ? ";
			try {

				psmt = con.prepareStatement(sql);
				psmt.setInt(1, num);
				rs = psmt.executeQuery();

				if (rs.next()) {
					dto.setNum(rs.getInt("num"));
					dto.setTitle(rs.getString("title"));
					dto.setId(rs.getString("id"));
					dto.setWritedate(rs.getDate("writedate"));
					dto.setContent(rs.getString("content"));
					dto.setOfile(rs.getString("ofile"));
					dto.setSfile(rs.getString("sfile"));
					dto.setReadcount(rs.getInt("readcount"));
								
				}
			} catch (Exception e) {
				System.out.println("게시물 상세보기 중 예외 발생");
				e.printStackTrace();
			}
			return dto;
		}


		
		// 지정한 게시물의 조회수를 1 증가
		public void updateReadCount(int num) {
			String sql = "update REVIEWBOARD set " + " readcount = readcount+1 " + " where num=?";
			try {
				psmt = con.prepareStatement(sql);
				psmt.setInt(1, num);
				psmt.executeQuery();
			} catch (Exception e) {
				System.out.println("게시물 조회수 증가 중 예외 발생");
				e.printStackTrace();
			}
		}

		// 지정한 게시물을 수정(파일 포함)
		public int updateEdit(ReviewDTO dto) {
			int result = 0;

			try {
				String sql = "update REVIEWBOARD set title=?, content=?, ofile=?, sfile=? where num=?";

				psmt = con.prepareStatement(sql);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getOfile());
				psmt.setString(4, dto.getSfile());
				psmt.setInt(5, dto.getNum());

				result = psmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}

			return result;
		}
		
		
		//파일 수정
		public int updateFileReset(ReviewDTO dto) {
			int result=0;
			try {
				String sql = "update reviewboard set ofile =' ', sfile =' ' where num =?";
				
				psmt=con.prepareStatement(sql);
				psmt.setInt(1, dto.getNum());
				
				psmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("파일만 삭제 중 오류발생");
				e.printStackTrace();
			}
			return result;
		}

		
		
		//파일을 포함한 글쓰기(어드민 상단 고정글 기능 추가)
			public int insertFile(ReviewDTO dto) {
				int applyResult=0;
				try {
					String sql="insert into reviewboard ";
					
					if(dto.getTopfix() == -1) {
						sql+="( num, id, title, content, ofile, sfile, topfix) "
								+ " values(rboard_seq.nextval,?,?,?,?,?,-1)";
					} else {
						sql+="( num, id, title, content, ofile, sfile, topfix) "
								+ " values(rboard_seq.nextval,?,?,?,?,?,0)";
					}
					psmt = con.prepareStatement(sql);
					psmt.setString(1, dto.getId());
					psmt.setString(2, dto.getTitle());
					psmt.setString(3, dto.getContent());
					psmt.setString(4, dto.getOfile());
					psmt.setString(5, dto.getSfile());
					applyResult = psmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("파일 insert중 오류 발생");
				}
				return applyResult;
				
			}
	
	
		
		
		//글 삭제하기
		public int deletePost(ReviewDTO dto) {
			int result = 0;
			try {

				String query = "DELETE FROM REVIEWBOARD WHERE num=?";

				psmt = con.prepareStatement(query);
				psmt.setInt(1, dto.getNum());

				result = psmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("게시물 삭제 중 예외 발생");
				e.printStackTrace();
			}

			return result;
		}
		
	}

