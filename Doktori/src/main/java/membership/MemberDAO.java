package membership;

import common.DBConnPool;

public class MemberDAO extends DBConnPool {
	public MemberDAO(String drv, String url, String id, String pw) {
		super();
	}

	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		String query = "SELECT * FROM dmember WHERE id=? AND pass=?";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setNickname(rs.getString(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}
}
