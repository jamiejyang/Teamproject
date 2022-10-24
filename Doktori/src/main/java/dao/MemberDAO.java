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

	
	//회원가입
	public int insertMemberDTO(MemberDTO dto) {
		int result = 0;
		String query = "INSERT INTO dmember VALUES(?,?,?,?)";

		try {
			psmt = con.prepareStatement(query);


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
	
	public MemberDTO get(String id) {
		MemberDTO dto = new MemberDTO();
		String sql = "select * from dmember where id= ? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setNickname(rs.getString("nickname"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류");
		}
		return dto;
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
				dto.setNickname(rs.getString("nickname"));

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
	
	public int deleteAdmin( String []mid) {
		int result = 0;
		String sql = "delete from dmember ";
		if(mid.length !=0) {
			sql+= "Where id ='";
			for(int i=0; i<mid.length;i++) {
				sql+= mid[i];
				if(i != (mid.length-1)) {
					sql+="' or id ='";
				}else {
					sql+="'";
				}
			}
		}
//		System.out.println(sql);
		try {
			psmt = con.prepareStatement(sql);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원 탈퇴 중 오류 발생");
		}
		return result;
	}
	public int deleteMember(String id) {
		int result =0;
		String sql= "delete from dmember where id =?";
		try {
			psmt=con.prepareStatement(sql);
			psmt.setString(1, id);
			result= psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원 탈퇴(멤버) 중 오류발생");
		}
		return result;
	}
	
	public  int updateMember(MemberDTO dto) {
		int result=0;
		String sql="update dmember set nickname = ? , pass = ? where id = ?";
		try {
			psmt= con.prepareStatement(sql);
			psmt.setString(1, dto.getNickname());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getId());
			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원 정보 수정 중 오류 발생");
		}
		return result;
	}


}
