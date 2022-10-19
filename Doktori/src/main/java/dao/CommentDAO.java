package dao;

import common.DBConnPool;
import dto.CommentDTO;

import java.util.ArrayList;


public class CommentDAO extends DBConnPool {
	public CommentDAO() {
		super();
	}
	
	public int writeComment(CommentDTO dto) {	
		int result = 0;
		String sql = "INSERT INTO reviewcomment (cmtnum, bbsnum, cmtid, cmtdate, cmtcontent) "
				+" values(cmt_seq.nextval,?,?,sysdate,?)";
		try {
			psmt = con.prepareStatement(sql);
			
			psmt.setInt(1, dto.getBbsnum());
			psmt.setString(2, dto.getCmtid());
//			psmt.setString(3, dto.getCmtdate());
			psmt.setString(3, dto.getCmtcontent());
			
			psmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("댓글 입력 중 예외 발생");
		}
		return result; 
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
		String sql = "SELECT * FROM REVIEWCOMMENT WHERE bbsnum= ? ORDER BY cmtnum"; 
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
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	
	
	public int updateComment(int cmtNum, String cmtContent) {
		String sql = "UPDATE REVIEWCOMMENT SET cmtcontent = ? WHERE cmtnum = ?";
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
	
	//글 지울때 댓글 지우기
//	public int deletePostComment(int cmtNum) {
//		String sql = "DELETE FROM REVIEWCOMMENT WHERE bbsnum=? and cmtnum = ?";
//		try {
//			psmt = con.prepareStatement(sql);
//			psmt.setInt(1, cmtNum);
//			return psmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1; 
//	}
}