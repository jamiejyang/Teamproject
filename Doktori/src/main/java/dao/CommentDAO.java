package dao;

import common.DBConnPool;
import dto.CommentDTO;

import java.util.ArrayList;


public class CommentDAO extends DBConnPool {
	public CommentDAO() {
		super();
	}
	
//	public String getDate() {
//		String sql = "SELECT NOW()";
//		try {
//			psmt = con.prepareStatement(sql);
//			rs = psmt.executeQuery();
//			if (rs.next()) {
//				return rs.getString(1);
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		return ""; 
//	}
	
	
	
	public int getNext() {
		String sql = "SELECT cmtNum FROM reviewcomment ORDER BY cmtNum DESC";
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;//첫번째 댓글인 경우
	}
	
	
	
	public int writeComment(int num, String userId, String cmtContent) {
		String sql = "INSERT INTO reviewcomment VALUES(?, ?, ?, sysdate, ?)";
		try {
			psmt = con.prepareStatement(sql);
			
			psmt.setInt(1, getNext());
			psmt.setInt(2, num);
			psmt.setString(3, userId);
//			psmt.setString(4, getDate());
			psmt.setString(4, cmtContent);
			psmt.executeUpdate();
			return getNext();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	
	
	public String getUpdateComment(int cmtNum) {
		String sql = "SELECT cmtcontent FROM reviewcomment WHERE cmtnum = ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, cmtNum);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; 
		
		
		
		
	}
	public ArrayList<CommentDTO> getList(int num){
		String sql = "SELECT * FROM REVIEWCOMMENT WHERE bbsnum= ? ORDER BY bbsnum DESC"; 
		ArrayList<CommentDTO> list = new ArrayList<CommentDTO>();
		try {
			
			psmt = con.prepareStatement(sql);
			
			psmt.setInt(1, num);
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setCmtnum(rs.getInt(1));
				dto.setBbsnum(rs.getInt(2));     
				dto.setCmtid(rs.getString(3));
				dto.setCmtdate(rs.getString(4));
				dto.setCmtcontent(rs.getString(5));
//				dto.setCmtlevel(rs.getInt(6));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public int updateComment(int cmtNum, String cmtContent) {
		String sql = "UPDATE REVIEWCOMMENT SET cmtcontent = ? WHERE cmtnum LIKE ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, cmtContent);
			psmt.setInt(2, cmtNum);
			return psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	
	
	public CommentDTO getComment(int cmtNum) {
		String sql = "SELECT * FROM REVIEWCOMMENT WHERE cmtnum = ? ORDER BY cmtnum DESC";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1,  cmtNum);
			rs = psmt.executeQuery();
			while (rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setCmtnum(rs.getInt(1));
				dto.setBbsnum(rs.getInt(2));
				dto.setCmtid(rs.getString(3));
				dto.setCmtdate(rs.getString(4));
				dto.setCmtcontent(rs.getString(5));
//				dto.setCmtlevel(rs.getInt(6));
				return dto;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
	public int deleteComment(int cmtNum) {
		String sql = "DELETE FROM REVIEWCOMMENT WHERE cmtnum = ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, cmtNum);
			return psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}