package membership;

import common.DBConnPool;

public class MemberDAO extends DBConnPool {
	public MemberDAO() {
		super();
	}

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
			System.out.println("읽는 도중 에러  ");
			e.printStackTrace();
		}

		return dto;
	}
}
