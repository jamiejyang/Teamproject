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

		// 검색 조건에 맞는 게시물 목록을 반환
		public List<ReviewDTO> selectList(Map<String, Object> map) {
			List<ReviewDTO> bbs = new Vector<ReviewDTO>(); // 결과(게시물 목록)를 담을 변수

			String query = "select * from REVIEWBOARD";
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
					ReviewDTO dto = new ReviewDTO();

					dto.setNum(rs.getInt("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setId(rs.getString("id"));
					dto.setPass(rs.getString("pass"));
					dto.setParent(rs.getInt("parent"));
					dto.setWritedate(rs.getDate("writedate"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setFiles(rs.getString("files"));

					bbs.add(dto); // 결과 목록에 저장
				}
			} catch (Exception e) {
				System.out.println("게시물 조회 중 예외 발생");
				e.printStackTrace();
			}

			return bbs;
		}

		// 검색 조건에 맞는 게시물 목록을 반환합니다(페이징 가능 지원).
		public List<ReviewDTO> selectListPage(Map<String, Object> map) {
			List<ReviewDTO> bbs = new Vector<ReviewDTO>(); // 결과(게시물 목록)를 담을 변수

			// 쿼리문 템플릿
			String query = " SELECT * FROM ( " + "   SELECT Tb.*, ROWNUM rNUM FROM ( "
					+ "      SELECT * FROM REVIEWBOARD ";
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
					ReviewDTO dto = new ReviewDTO();
					dto.setNum(rs.getInt("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setId(rs.getString("id"));
					dto.setPass(rs.getString("pass"));
//					dto.setParent(rs.getInt("parent"));
					dto.setWritedate(rs.getDate("writedate"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setFiles(rs.getString("files"));
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

		
		// 게시글 데이터를 받아 DB에 추가(파일 업로드 지원)
//		public int insertWrite(ReviewDTO dto) {
//			int result = 0;
//
//			try {
//
//				// insert 쿼리문 작성
//				String sql = "insert into REVIEWBOARD (num, title, content, id, pass, files, readcount) "
//						+ "values (rboard_seq.nextval, ?, ?, ?, ?, ?, 0)";
//				System.out.println(sql);
//				psmt = con.prepareStatement(sql);
//				psmt.setString(1, dto.getTitle());
//				psmt.setString(2, dto.getContent());
//				psmt.setString(3, dto.getId());
//				psmt.setString(4, dto.getPass());
//				psmt.setString(5, dto.getFiles());
//
//				result = psmt.executeUpdate();
//				
//				System.out.println("id"+dto.getId());
//				
//			} catch (Exception e) {
//				System.out.println("게시물 입력 중 예외 발생");
//				e.printStackTrace();
//			}
//			return result;
//		}
//		
		
		// 지정한 게시물을 찾아 내용을 반환
		public ReviewDTO selectView(int num) {
			ReviewDTO dto = new ReviewDTO();

			String sql = "select * from REVIEWBOARD where num= ? ";
			System.out.println("selectView: "+sql);
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
					dto.setPass(rs.getString("pass"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setFiles(rs.getString("files"));
			
				}
			} catch (Exception e) {
				System.out.println("게시물 상세보기 중 예외 발생");
				e.printStackTrace();
			}
			return dto;
		}

		
//		public ReviewDTO getBbs(int num) {
//			String sql = "SELECT * FROM REVIEWBOARD WHERE NUM = ?";
//			System.out.println("getbbs: "+sql);
//			try {
//				psmt = con.prepareStatement(sql);
//				psmt.setInt(1,  num);
//				rs = psmt.executeQuery();
//				
//				while (rs.next()) {
//					ReviewDTO dto = new ReviewDTO();
//					dto.setNum(rs.getInt(1));
//					dto.setTitle(rs.getString(2));
//					dto.setId(rs.getString(3));
//					dto.setWritedate(rs.getDate(4));
//					dto.setContent(rs.getString(5));
//					return dto;
//				}
//			}catch(Exception e) {
//				e.printStackTrace();
//			}
//			return null;
//		}
		
		
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

		// 지정한 게시물을 수정
		public int updateEdit(ReviewDTO dto) {
			int result = 0;

			try {
				String sql = "update REVIEWBOARD set title=?, content=?, files=? where num=?";

				psmt = con.prepareStatement(sql);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getFiles());
				psmt.setInt(4, dto.getNum());

				result = psmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}

			return result;
		}

		public int insertFile(ReviewDTO dto) {
			int applyResult=0;
			try {
				String sql="insert into reviewboard " + "( num, id, title, content, files, pass) "
			+ " values(rboard_seq.nextval,?,?,?,?,?)";
				
				psmt = con.prepareStatement(sql);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getTitle());
				psmt.setString(3, dto.getContent());
				psmt.setString(4, dto.getFiles());
				psmt.setString(5, dto.getPass());

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
		
		public int checkPass(ReviewDTO dto) {
			int result = 1;
			try {
				
				String query = "SELECT * FROM REVIEWBOARD WHERE NUM =?";
				
				psmt = con.prepareStatement(query);
				psmt.setInt(1, dto.getNum());
				
				rs = psmt.executeQuery();
				
				if (rs.next()) {
					dto.setNum(rs.getInt(1));
					dto.setId(rs.getString("id"));
					dto.setPass(rs.getString("pass"));
				}
				
			} catch(Exception e) {
				System.out.println("비밀번호 조회 중 예외 발생");
				e.printStackTrace();
			}
			
			return result;
				
			}

//	// 시퀀스를 가져온다
//	public int getSeq() {
//		int result = 1;
//		try {
//
//			StringBuffer sql = new StringBuffer();
//			sql.append("SELECT BOARD_NUM.NEXTVAL FROM DUAL");
//
//			psmt = con.prepareStatement(sql.toString());
//			rs = psmt.executeQuery();
//
//			if (rs.next())
//				result = rs.getInt(1);
//		} catch (Exception e) {
//			throw new RuntimeException(e.getMessage());
//		}
//
//		return result;
//	}
//
//	// 글 삽입
//	public int boardInsert(ReviewDTO board) {
////		boolean result = false;
//		int result = 0;
//		
//		try {
//			StringBuffer sql = new StringBuffer();
//			sql.append("INSERT INTO MEMBER_BOARD");
//			sql.append("(BOARD_NUM, BOARD_ID, BOARD_SUBJECT, BOARD_CONTENT, BOARD_FILE");
//			sql.append(", BOARD_RE_REF, BOARD_COUNT, BOARD_DATE, BOARD_PARENT)");
//			sql.append(" VALUES(?,?,?,?,?,?,?,sysdate,?)");
//
//			int num = board.getBoard_num(); // 시퀀스값을 글번호와 그룹번호로 사용
//			int ref = board.getBoard_re_ref(); //그룹 번호
//			int parent = board.getBoard_parent();  //부모글 번호
//			
//			
//			
//			//부모글일 경우, 그룹번호와 글번호 동일
//			if (parent == 0)
//				ref = num;
//
//			psmt = con.prepareStatement(sql.toString());
//			psmt.setInt(1, num);
//			psmt.setString(2, board.getBoard_id());
//			psmt.setString(3, board.getBoard_subject());
//			psmt.setString(4, board.getBoard_content());
//			psmt.setString(5, board.getBoard_file());
//			psmt.setInt(6, ref);
//			psmt.setInt(7, board.getBoard_count());
//			psmt.setInt(8, parent);
//			
//			result=psmt.executeUpdate();
//			
////			int flag = psmt.executeUpdate();
////			if (flag > 0) {
////				result = true;
////				con.commit();
////			}
//
//		} catch (Exception e) {
////			try {
////				con.rollback();
////			} catch (SQLException sqle) {
////				sqle.printStackTrace();
////			}
//			e.printStackTrace();
//			throw new RuntimeException(e.getMessage());
//		}
//		return result;
//	}
//
//	
//	// 검색 조건에 맞는 게시물 목록을 반환
//		public List<ReviewDTO> selectList(Map<String, Object> listOpt) {
//			List<ReviewDTO> bbs = new Vector<ReviewDTO>(); // 결과(게시물 목록)를 담을 변수
//
//			String query = "select * from suggestboard";
//			if (listOpt.get("searchWord") != null) {
//				query += " where " + listOpt.get("searchField") + " " + " like '%" + listOpt.get("searchWord") + "%' "; // searchWord에
//				// 있는 글자를
//				// 포함하고 있는
//				// 모든 문자를
//				// 반환함
//			}
//			query += " order by num desc ";
//			System.out.println(query);
//			try {
//				stmt = con.createStatement();
//				rs = stmt.executeQuery(query);
//
//				while (rs.next()) {
//					ReviewDTO dto = new ReviewDTO();
//
//					dto.setBoard_num(rs.getInt("num"));
//					dto.setBoard_subject(rs.getString("title"));
//					dto.setBoard_content(rs.getString("content"));
//					dto.setBoard_id(rs.getString("id"));
//					dto.setBoard_date(rs.getDate("date"));
//					dto.setBoard_count(rs.getInt("count"));
//					dto.setBoard_file(rs.getString("fileName"));
//
//					bbs.add(dto); // 결과 목록에 저장
//				}
//			} catch (Exception e) {
//				System.out.println("게시물 조회 중 예외 발생");
//				e.printStackTrace();
//			}
//
//			return bbs;
//		}
//	
//	
//	
//	//글 목록 가져오기
//	public ArrayList<ReviewDTO> getBoardList(HashMap<String, Object> listOpt)	{
//		ArrayList<ReviewDTO> list = new ArrayList<ReviewDTO>();
//		
//		String opt = (String)listOpt.get("opt"); //검색옵션
//		String condition = (String)listOpt.get("condition"); //검색내용
//		int start = (Integer)listOpt.get("start");// 현재 페이지번호
//		
//		try {
//			StringBuffer sql = new StringBuffer();
//			
//			//글 목록 전체 보여주기
//			if(opt==null) {
////				BOARD_RE_REF(그룹번호)의 내림차순 정렬 후 동일한 그룹번호일 때는 
////				BOARD_RE_SEQ(답변글 순서)의 오름차순으로 정렬 한 후에
////				start번 째 부터 start+9까지(10개의 글을 한 목록에 보여주기 위해)의 데이터를 검색
//				
//				sql.append("SELECT * FROM ");
//				sql.append("(select rownum rnum, board_num, board_id, board_subject");
//				sql.append(", board_content, board_file, board_count, board_re_ref");
//				sql.append(", board_re_lev, board_re_weq, board_date ");
//				sql.append(" from ");
//				sql.append(" (select * from member_board order by board_re_ref desc, board_re_seq)) ");
//				sql.append(" where rnum>=? and rnum<=?");
//				
//				psmt.setInt(1, start);
//				psmt.setInt(2, start+9);
//				
//				sql.delete(0, sql.toString().length());
//			}
//			
//			else if(opt.equals("0")) // 제목으로 검색
//			{
//				sql.append("SELECT * FROM");
//				sql.append(" (SELECT  ROWNUM AS rnum, data.* FROM ");
//				sql.append("	(SELECT LEVEL, BOARD_NUM, BOARD_ID,	BOARD_SUBJECT,");
//				sql.append("			BOARD_CONTENT, BOARD_FILE,BOARD_COUNT,");
//				sql.append("			BOARD_RE_REF, BOARD_PARENT, BOARD_DATE");
//				sql.append("	FROM MEMBER_BOARD");
//				sql.append(" 	WHERE BOARD_SUBJECT like ?");
//				sql.append("	START WITH BOARD_PARENT = 0");
//				sql.append("	CONNECT BY PRIOR BOARD_NUM = BOARD_PARENT");
//				sql.append("	ORDER SIBLINGS BY BOARD_RE_REF desc)");              
//				sql.append(" data) ");
//				sql.append("WHERE rnum>=? and rnum<=?");
//				
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setString(1, "%"+condition+"%");
//				psmt.setInt(2, start);
//				psmt.setInt(3, start+9);
//				
//				sql.delete(0, sql.toString().length());
//			}
//			else if(opt.equals("1")) //내용으로 검색
//			{
//				sql.append("SELECT * FROM");
//				sql.append(" (SELECT  ROWNUM AS rnum, data.* FROM ");
//				sql.append("	(SELECT LEVEL, BOARD_NUM, BOARD_ID,	BOARD_SUBJECT,");
//				sql.append("			BOARD_CONTENT, BOARD_FILE,BOARD_COUNT,");
//				sql.append("			BOARD_RE_REF, BOARD_PARENT, BOARD_DATE");
//				sql.append("	FROM MEMBER_BOARD");
//				sql.append(" 	WHERE BOARD_CONTENT like ?");
//				sql.append("	START WITH BOARD_PARENT = 0");
//				sql.append("	CONNECT BY PRIOR BOARD_NUM = BOARD_PARENT");
//				sql.append("	ORDER SIBLINGS BY BOARD_RE_REF desc)");              
//				sql.append(" data) ");
//				sql.append("WHERE rnum>=? and rnum<=?");
//				
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setString(1, "%"+condition+"%");
//				psmt.setInt(2, start);
//				psmt.setInt(3, start+9);
//				
//				sql.delete(0, sql.toString().length());
//			}
//			else if(opt.equals("2")) //제목+내용으로 검색
//			{
//				sql.append("SELECT * FROM");
//				sql.append(" (SELECT  ROWNUM AS rnum, data.* FROM ");
//				sql.append("	(SELECT LEVEL, BOARD_NUM, BOARD_ID,	BOARD_SUBJECT,");
//				sql.append("			BOARD_CONTENT, BOARD_FILE,BOARD_COUNT,");
//				sql.append("			BOARD_RE_REF, BOARD_PARENT, BOARD_DATE");
//				sql.append("	FROM MEMBER_BOARD");
//				sql.append(" 	WHERE BOARD_SUBJECT like ?");
//				sql.append(" 	OR BOARD_CONTENT like ?");
//				sql.append("	START WITH BOARD_PARENT = 0");
//				sql.append("	CONNECT BY PRIOR BOARD_NUM = BOARD_PARENT");
//				sql.append("	ORDER SIBLINGS BY BOARD_RE_REF desc)");              
//				sql.append(" data) ");
//				sql.append("WHERE rnum>=? and rnum<=?");
//				
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setString(1, "%"+condition+"%");
//				psmt.setString(2, "%"+condition+"%");
//				psmt.setInt(3, start);
//				psmt.setInt(4, start+9);
//				
//				sql.delete(0, sql.toString().length());
//			}
//			else if(opt.equals("3")) //글쓴이로 검색 
//			{	
//				sql.append("SELECT * FROM");
//				sql.append(" (SELECT  ROWNUM AS rnum, data.* FROM ");
//				sql.append("	(SELECT LEVEL, BOARD_NUM, BOARD_ID,	BOARD_SUBJECT,");
//				sql.append("			BOARD_CONTENT, BOARD_FILE,BOARD_COUNT,");
//				sql.append("			BOARD_RE_REF, BOARD_PARENT, BOARD_DATE");
//				sql.append("	FROM MEMBER_BOARD");
//				sql.append(" 	WHERE BOARD_ID like ?");
//				sql.append("	START WITH BOARD_PARENT = 0");
//				sql.append("	CONNECT BY PRIOR BOARD_NUM = BOARD_PARENT");
//				sql.append("	ORDER SIBLINGS BY BOARD_RE_REF desc)");              
//				sql.append(" data) ");
//				sql.append("WHERE rnum>=? and rnum<=?");
//				
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setString(1, "%"+condition+"%");
//				psmt.setInt(2, start);
//				psmt.setInt(3, start+9);
//				
//				sql.delete(0, sql.toString().length());
//			}
//			
//			rs = psmt.executeQuery();
//			while(rs.next())
//			{
//				ReviewDTO board = new ReviewDTO();
//				board.setBoard_re_lev(rs.getInt("LEVEL"));
//				board.setBoard_num(rs.getInt("BOARD_NUM"));
//				board.setBoard_id(rs.getString("BOARD_ID"));
//				board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
//				board.setBoard_content(rs.getString("BOARD_CONTENT"));
//				board.setBoard_file(rs.getString("BOARD_FILE"));
//				board.setBoard_count(rs.getInt("BOARD_COUNT"));
//				board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
//				board.setBoard_parent(rs.getInt("BOARD_PARENT"));
//				board.setBoard_date(rs.getDate("BOARD_DATE"));
//				list.add(board);
//			}
//			
//		}catch(Exception e) {
//			e.printStackTrace();
//			throw new RuntimeException(e.getMessage());
//		}
//		return list;
//	}
//	
//	//글의 개수를 가져오기
//		public int getBoardListCount(Map<String, Object> listOpt)
//		{
//			int totalCount = 0;
//			String opt = (String)listOpt.get("opt");
//			String condition = (String)listOpt.get("condition");
//			
//			try {
//				StringBuffer sql = new StringBuffer();
//				
//				if(opt == null)	// 전체 글의 개수
//				{
//					sql.append("select count(*) from MEMBER_BOARD");
//					psmt = con.prepareStatement(sql.toString());
//					
//					// StringBuffer비우기
//					sql.delete(0, sql.toString().length());
//				}
//				else if(opt.equals("0")) // 제목으로 검색시 글의 개수
//				{
//					sql.append("select count(*) from MEMBER_BOARD where BOARD_SUBJECT like ?");
//					psmt = con.prepareStatement(sql.toString());
//					psmt.setString(1, '%'+condition+'%');
//					
//					sql.delete(0, sql.toString().length());
//				}
//				else if(opt.equals("1")) // 내용으로 검색시 글의 개수
//				{
//					sql.append("select count(*) from MEMBER_BOARD where BOARD_CONTENT like ?");
//					psmt = con.prepareStatement(sql.toString());
//					psmt.setString(1, '%'+condition+'%');
//					
//					sql.delete(0, sql.toString().length());
//				}
//				else if(opt.equals("2")) //제목+내용으로 검색시 글의 개수
//				{
//					sql.append("select count(*) from MEMBER_BOARD ");
//					sql.append("where BOARD_SUBJECT like ? or BOARD_CONTENT like ?");
//					psmt = con.prepareStatement(sql.toString());
//					psmt.setString(1, '%'+condition+'%');
//					psmt.setString(2, '%'+condition+'%');
//					
//					sql.delete(0, sql.toString().length());
//				}
//				else if(opt.equals("3")) // 글쓴이로 검색시 글의 개수
//				{
//					sql.append("select count(*) from MEMBER_BOARD where BOARD_ID like ?");
//					psmt = con.prepareStatement(sql.toString());
//					psmt.setString(1, '%'+condition+'%');
//					
//					sql.delete(0, sql.toString().length());
//				}
//				
//				rs = psmt.executeQuery();
//				if(rs.next())	totalCount = rs.getInt(1);
//				
//			} catch (Exception e) {
//				throw new RuntimeException(e.getMessage());
//			}
//			
//	
//			return totalCount;
//		} 
//		
//		
//		// 상세보기
//		//지정한 게시물을 찾아 내용물을 반환
//		public ReviewDTO getDetail(int boardNum)
//		{	
//			ReviewDTO board = null;
//			
//			try {
//				
//				StringBuffer sql = new StringBuffer();
//				sql.append("select * from MEMBER_BOARD m, dmember d where m.board_id= d.id and BOARD_NUM = ?");
//				
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setInt(1, boardNum);
//				
//				rs = psmt.executeQuery();
//				if(rs.next())
//				{
//					board = new ReviewDTO();
//					board.setBoard_num(boardNum);
//					board.setBoard_id(rs.getString("BOARD_ID"));
//					board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
//					board.setBoard_content(rs.getString("BOARD_CONTENT"));
//					board.setBoard_file(rs.getString("BOARD_FILE"));
//					board.setBoard_count(rs.getInt("BOARD_COUNT"));
//					board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
//					board.setBoard_date(rs.getDate("BOARD_DATE"));
//					board.setBoard_parent(rs.getInt("BOARD_PARENT"));
//				}
//				
//			} catch (Exception e) {
//				throw new RuntimeException(e.getMessage());
//			}
//			
//			
//			return board;
//		}
//				
//		
//		
//		// 조회수 증가
//		public boolean updateCount(int boardNum)
//		{
//			boolean result = false;
//			
//			try {
//				
//				con.setAutoCommit(false);
//				
//				StringBuffer sql = new StringBuffer();
//				sql.append("update MEMBER_BOARD set BOARD_COUNT = BOARD_COUNT+1 ");
//				sql.append("where BOARD_NUM = ?");
//				
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setInt(1, boardNum);
//				
//				int flag = psmt.executeUpdate();
//				if(flag > 0){
//					result = true;
//					con.commit(); //완료시 커밋
//				}	
//			} catch (Exception e) {
//				try {
//					con.rollback(); // 오류시 롤백
//				} catch (SQLException sqle) {
//					sqle.printStackTrace();
//				}
//				throw new RuntimeException(e.getMessage());
//			}
//			
//			
//			return result;
//		}
//		
////		public boolean updateReSeq(BoardBean board) {
////			boolean result=false;
////			
////			
////			int ref = board.getBoard_re_ref(); //원본 글 번호 (그룹번호)
////			int seq = board.getBoard_re_seq();  //답변글 순서(이게 0이면 답글이 없는 상태이므로 부모글을 나타냄
////			
////			try {
////				StringBuffer sql = new StringBuffer();
////				
////				conn = DBManager.getConnection();
////				con.setAutoCommit(false);
////				
////				//ref, seq을 확인하여 원본 글에 다른 답변 글이 있으면, 답변 글보다 상위에 있는 글의 seq보다 높은 글으 seq값을 1증가
////				sql.append("update MEMBER_BOARD set BOARD_RE_SEQ = BOARD_RE_SEQ+1 ");
////				sql.append("where BOARD_RE_REF = ? and BOARD_RE_SEQ > ?");
////				
////				psmt = con.prepareStatement(sql.toString());
////				psmt.setInt(1, ref);
////				psmt.setInt(2, seq);
////				
////				int flag = psmt.executeUpdate();
////				if(flag>0) {
////					result = true;
////					con.commit();
////				}
////			
////			} catch(Exception e) {
////				try {
////					con.rollback();
////				}catch(SQLException sqle) {
////					sqle.printStackTrace();
////				} throw new RuntimeException(e.getMessage());
////				
////			}
////			return result;
////		
////		}
//		
//		//삭제할 파일명을 가져온다
//		public String getFileName(int boardNum)
//		{
//			String fileName = null;
//			
//			try {
//				
//				StringBuffer sql = new StringBuffer();
//				sql.append("SELECT BOARD_FILE from MEMBER_BOARD where BOARD_NUM=?");
//				
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setInt(1, boardNum);
//				
//				rs = psmt.executeQuery();
//				if(rs.next()) fileName = rs.getString("BOARD_FILE");
//				
//			} catch (Exception e) {
//				throw new RuntimeException(e.getMessage());
//			}
//			
//		
//			return fileName;
//		}
//			
//		
//		public int deleteBoard(int boardNum) 
//		{
//			int result = 0;
//
//			try {
//				
//
////				서브쿼리의 in연산자는 in뒤의 값들 중 하나라도 일치하는게 있으면 검색이됨
//				StringBuffer sql = new StringBuffer();
//				sql.append("DELETE FROM MEMBER_BOARD");
//				sql.append(" WHERE BOARD_NUM IN");
//				sql.append(" (SELECT BOARD_NUM");
//				sql.append(" FROM MEMBER_BOARD");
//				sql.append(" START WITH BOARD_NUM = ?");
//				sql.append(" CONNECT BY PRIOR BOARD_NUM = BOARD_PARENT) ");
//				
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setInt(1, boardNum);
//				
//				result = psmt.executeUpdate();
//			
//				
//			} catch (Exception e) {
//			
//				throw new RuntimeException(e.getMessage());
//			}
//
//			
//			return result;
//		} 
//
//		
//		
//		public int updateBoard(ReviewDTO border) 
//		{
//			int result = 0;
//			
//			try{
////				con.setAutoCommit(false); 
//				
//				StringBuffer sql = new StringBuffer();
//				sql.append("UPDATE MEMBER_BOARD SET");
//				sql.append(" BOARD_SUBJECT=?");
//				sql.append(" ,BOARD_CONTENT=?");
//				sql.append(" ,BOARD_FILE=?");
//				sql.append(" ,BOARD_DATE=SYSDATE ");
//				sql.append("WHERE BOARD_NUM=?");
//
//				psmt = con.prepareStatement(sql.toString());
//				psmt.setString(1, border.getBoard_subject());
//				psmt.setString(2, border.getBoard_content());
//				psmt.setString(3, border.getBoard_file());
//				psmt.setInt(4, border.getBoard_num());
//				
//				result =psmt.executeUpdate();
//				
////				int flag = psmt.executeUpdate();
////				if(flag > 0){
////					result = true;
////					con.commit();
////				}
//				
//			} catch (Exception e) {
////				try {
////					con.rollback(); 
////				} catch (SQLException sqle) {
////					sqle.printStackTrace();
////				}
//				throw new RuntimeException(e.getMessage());
//			}
//		
//			
//			return result;
//		}
//		
//		
//		
////		private void close()
////		{
////			try {
////				if ( psmt != null ){ psmt.close(); psmt=null; }
////				if ( conn != null ){ con.close(); conn=null;	}
////			} catch (Exception e) {
////				throw new RuntimeException(e.getMessage());
////			}
////		} 
//		
	}

