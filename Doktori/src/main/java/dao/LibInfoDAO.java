package dao;

import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.LibInfoDTO;

public class LibInfoDAO extends DBConnPool{

	public LibInfoDAO(){
		super();
	}
	public LibInfoDTO libInfo(String managecode) {
		LibInfoDTO dto = new LibInfoDTO();
		
		try {
			String sql= "select * from liblist where managecode =?";
			psmt=con.prepareStatement(sql);
			psmt.setString(1, managecode);
			rs=psmt.executeQuery();
			if(rs.next()) {
				dto.setLibname(rs.getString("libname"));
				dto.setTel(rs.getString("tel"));
				dto.setUrl(rs.getString("url"));
				dto.setDayoff(rs.getString("dayoff"));
				dto.setPlace(rs.getString("place"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("도서관 인포중 오류");
		}
		return dto;
	}
	public List<LibInfoDTO> libside(String managecode){
		List<LibInfoDTO> list = new ArrayList<>();
		String sql="SELECT * FROM LIBINFO f ,LIBLIST l WHERE l.MANAGECODE = f.MANAGECODE and l.managecode= ?";
		
		try {
		psmt=con.prepareStatement(sql);
		psmt.setString(1, managecode);
		rs=psmt.executeQuery();		
		while(rs.next()) {
			LibInfoDTO dto= new LibInfoDTO();
//			dto.setLibname(rs.getString("libname"));
//			dto.setTel(rs.getString("tel"));
//			dto.setUrl(rs.getString("url"));
//			dto.setDayoff(rs.getString("dayoff"));
//			dto.setPlace(rs.getString("place"));
			dto.setHours(rs.getString("hours"));
			dto.setStatus(rs.getString("status"));
			list.add(dto);
		}
				
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("도서관 시설현황 확인 중 오류 발생");
		}
			
		
		return list;
	}
}
