package dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import common.DBConnPool;
import dto.FaqDTO;

public class FaqDAO extends DBConnPool {

	public FaqDAO() {
		super();
	}

	public FaqDAO(ServletContext applicattion) {
		super();
	}

	public List<FaqDTO> selectFaq() {
		String sql = "select * from faqtable ORDER BY qnum";

		List<FaqDTO> list = new ArrayList<FaqDTO>();
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				FaqDTO dto = new FaqDTO();

				dto.setQu(rs.getString("qu"));
				dto.setAn(rs.getString("an"));
				dto.setNum(rs.getString("qnum"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return list;
	}

	public int insertFaq(FaqDTO dto) {
		int result = 0;

		try {
			String sql = "INSERT INTO faqtable (QU, AN, qnum,id) " + "VALUES (?, ?, faq_seq.NEXTVAL, 'admin')";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getQu());
			psmt.setString(2, dto.getAn());

			result = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}

	public FaqDTO selectView(String num) {
		FaqDTO dto = new FaqDTO();

		String query = "select * from faqtable WHERE qnum=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setQu(rs.getString(1));
				dto.setAn(rs.getString(2));
				dto.setNum(rs.getString(3));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	public int updateEdit(FaqDTO dto) {
		int result = 0;
		String query = "UPDATE faqtable SET QU=?, AN=? WHERE qnum=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getQu());
			psmt.setString(2, dto.getAn());
			psmt.setString(3, dto.getNum());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}

	public int deletePost(FaqDTO dto) {
		int result = 0;
		String query = "DELETE FROM faqtable WHERE qnum=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());

			result = psmt.executeUpdate();
			System.out.print("asdasd");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return result;
	}

}
