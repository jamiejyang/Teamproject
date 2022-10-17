package dao;

import common.DBConnPool;
import dto.MemberDTO;

public class MemberDAO extends DBConnPool {
	public MemberDAO() {
		super();
	}
	
	//회원가입
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
	
	//아이디 중복체크
	public boolean checkID(String id) {
		boolean result = true;
		try {
			String query = "SELECT id from dmember where id = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = false;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//로그인
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
}
