package dao;

import dto.MemberDTO;
import common.DBConnPool;

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