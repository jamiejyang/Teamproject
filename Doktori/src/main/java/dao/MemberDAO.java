package dao;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.DBConnPool;
import dto.MemberDTO;

public class MemberDAO extends DBConnPool {
	public MemberDAO() {
		super();
	}

	// 회원가입
	public int insertMemberDTO(MemberDTO dto) {
		int result = 0;
		String query = "INSERT INTO dmember VALUES(?,?,?,?)";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getNickname());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getPass());
			result = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// 로그인
	public MemberDTO getMemberDTO(String uid, String upass, String uname) {
		MemberDTO dto = new MemberDTO();
		String query = "SELECT * FROM dmember WHERE id=? AND pass=? ";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			System.out.println("읽는 도중 에러");
			e.printStackTrace();
		}

		return dto;
	}
	public List<MemberDTO> MemberList(Map<String,Object> map){
		List<MemberDTO> list = new ArrayList<>();
			
		String sql= "SELECT * FROM (  SELECT TB.*, ROWNUM rNum FROM (  SELECT * FROM DMEMBER d  ";
		if(map.get("searchWord")!= null) {
			sql+=" where "+map.get("searchField")+ " Like '%"+map.get("searchWord")+"%' ";
		}
		sql+=" ORDER BY name desc  ) TB  )  WHERE rNum BETWEEN ? AND ?";
		try {
			psmt= con.prepareStatement(sql);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs=psmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNickname(rs.getString("nickname"));
				dto.setPass(rs.getString("pass"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원정보 리스트 조회 중 오류 발생 ");
		}
		return list;
	}
	
	public int MemberCount(Map<String,Object>map) {
		int totalCount =0;
		String sql= "select count(*) from dmember";
		if(map.get("searchWord")!=null) {
			sql+= " where "+ map.get("searchField")+" Like '%"+map.get("searchWord")+"%' ";
		}
		try {
			stmt=con.createStatement();
			rs= stmt.executeQuery(sql);
			rs.next();
			totalCount= rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원 수 구하는 중 오류발생");
		}
		return totalCount;
	}
	public MemberDTO selectMember(String id) {
		MemberDTO dto =new MemberDTO();
		
		try {
			String sql= "select * from dmember where id =?";
			psmt=con.prepareStatement(sql);
			psmt.setString(1, id);
			rs= psmt.executeQuery();
			
			if(rs.next()){
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNickname(rs.getString("nickname"));
				dto.setPass(rs.getString("pass"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("내정보 불러오는 중 오류 발생");
		}
		return dto;
		
	}
	
	public int deleteMember(MemberDTO dto) {
		int result = 0;
		try {
			String sql = "delete from dmember where id= ? ";
			System.out.println(sql);
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원 탈퇴 중 오류 발생");
		}
		return result;
	}
	public void close() {
	      try {
	         if (rs != null)
	            rs.close();
	         if (stmt != null)
	            stmt.close();
	         if (psmt != null)
	            psmt.close();
	         if (con != null)
	            con.close();
	         System.out.println("DB커넥션 풀 자원반납");
	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	   }
}
