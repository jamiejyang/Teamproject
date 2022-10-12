package dao;

import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.LibInfoDTO;

public class LibInfoDAO extends DBConnPool{

	public LibInfoDAO(){
		super();
	}
	
	public List<LibInfoDTO> libinfo(String place){
		List<LibInfoDTO> list = new ArrayList<>();
		String sql="SELECT * FROM LIBLIST l , LIBINFO f WHERE l.MANAGECODE =f.MANAGECODE AND l.PLACE =?";
		
		try {
		psmt=con.prepareStatement(sql);
		psmt.setString(1, place);
		rs=psmt.executeQuery();
		
		while(rs.next()) {
			LibInfoDTO dto= new LibInfoDTO();
			dto.setLibname(rs.getString("libname"));
			dto.setTel(rs.getString("tel"));
			dto.setUrl(rs.getString("url"));
			dto.setDayoff(rs.getString("datoff"));
//			dto.setPlace(rs.getString("place"));
			dto.setHours(rs.getString("hours"));
			dto.setStatus(rs.getString("status"));
			list.add(dto);
		}
				
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("도서관 인포리슽중 오류 발생");
		}
			
		
		return list;
	}
}
