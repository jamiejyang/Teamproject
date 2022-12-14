package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.DBConnPool;
import dto.NoticeDTO;

public class NoticeDAO extends DBConnPool {
	
	public  NoticeDAO() {
		super();
	}

	public NoticeDAO(ServletContext applicattion) {
		super();
	}
	public List<NoticeDTO> MainList() {
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		try {
			String sql= "SELECT n.num, n.title FROM NOTICE n order by num desc ";
				
			psmt=con.prepareStatement(sql);
			rs= psmt.executeQuery();
			
			int count=0;
			while(rs.next()) {
				NoticeDTO dto= new NoticeDTO();
				dto.setTitle(rs.getString("title"));
				dto.setNum(rs.getString("num"));
//				System.out.println(dto.getTitle());
//				System.out.println(dto.getNum());
				list.add(dto);
				count++;
//				
				if(count==3) {
					break;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("메인 중 오류 ");
		}
		return list;
	}
	
	public List<NoticeDTO> selectListPage(Map<String, Object> map) { // 게시글 리스트 
		List<NoticeDTO> list = new Vector<NoticeDTO>();
		String sql = "SELECT * FROM ( " + " SELECT TB.*, ROWNUM rNum FROM ( " + " SELECT * FROM Notice ";

		if (map.get("searchLib") == null && map.get("searWord") == null) {
			sql += " ORDER BY NUM desc " + " ) TB " + " ) " + " WHERE rNum BETWEEN ? AND ?";
		}

		else if (map.get("searchLib").equals("전체도서관")) {
			sql += "WHERE " + map.get("searchField") + " " + " LIKE '%" + map.get("searchWord") + "%' "
					+ " ORDER BY NUM desc  " + " ) TB " + " ) " + " WHERE rNum BETWEEN ? AND ?";
		} else if (map.get("searchLib") != null && map.get("searchWord") != null) {
			sql += "WHERE managecode = '" + map.get("searchLib") + "' AND " + map.get("searchField") + " " + " LIKE '%"
					+ map.get("searchWord") + "%' " + " ORDER BY NUM  desc " + " ) TB " + " ) "
					+ " WHERE rNum BETWEEN ? AND ?";
		}

		try {
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setmanagecode(rs.getString("managecode"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWritedate(rs.getDate("writedate"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("페이징 나눈 게시물 조회 중 예외 발생");
		}
		return list;
	}

	public int selectCount(Map<String, Object> map) { // 개시물 숫자 세기
		int totalCount = 0;
		String sql = "";
		if (map.get("searchLib") == null && map.get("searchWord") == null) {
			sql += "SELECT count(*) From Notice ";
		}

		else if (map.get("searchLib").equals("전체도서관")) {
			sql +="SELECT count(*) From Notice WHERE "+map.get("searchField")+" LIKE '%"+map.get("searchWord")+"%' ";

		} else if (map.get("searchLib") != null && map.get("searchWord") != null) {
			sql +="SELECT count(*) From Notice WHERE "+map.get("searchField")+" LIKE '%"+map.get("searchWord")+"%'"
					+ " AND managecode = '"+map.get("searchLib")+"' ";
		}

		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("게시물 수 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	public int updateFileReset(NoticeDTO dto) {
		int result=0;
		try {
			String sql = "update notice set ofile =' ', sfile =' ' where num =?";
			
			psmt=con.prepareStatement(sql);
			psmt.setString(1, dto.getNum());
			
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("파일만 삭제 중 오류발생");
			e.printStackTrace();
		}
		return result;
	}
	public int updateEdit(NoticeDTO dto) {  // 게시글 수정하기 
		int result = 0;

		try {
			String sql = "update notice set title =?, content = ?,ofile =?, sfile =? where num =?";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			psmt.setString(5, dto.getNum());
			
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("파일포함 수정 중 오류 발생");
			e.printStackTrace();
		}
		return result;
	}

	public int deletePost(NoticeDTO dto) { // 지우기 
		int result = 0;

		try {
			String sql = "delete from notice where num =?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getNum());
//			System.out.println(sql); // 삭제확인해야함
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("게시글 삭제 중 오류 발생");
		}
		return result;
	}

	public NoticeDTO selectView(String num) { // 게시글 찾기 
		NoticeDTO dto = new NoticeDTO();
		try {
			String sql = "select * from Notice  where  num = ? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);	
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setmanagecode(rs.getString("managecode"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWritedate(rs.getDate("writedate"));
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("상세보기 중 오류 발생");
		}

		return dto;
	}

	public int insertFile(NoticeDTO dto) { // 삽입! 
		int applyResult = 0;
		try {
			String sql = "insert into notice " + "( num , name ,title,content,ofile,sfile,managecode,id) "
					+ "values(notice_num.nextval, ? , ? , ? , ? , ?, ?, 'admin' ) ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getmanagecode());

			applyResult = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Insert 중 예외 발생");
		}

		return applyResult;
	}
	

	public void updateReadCount(String num) { // 조회수 올리기
		String sql = "update notice set readcount=readcount+1 where num = ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);

			psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("조회수 업뎃 중 오류 발생");
		}
	}

	
}
