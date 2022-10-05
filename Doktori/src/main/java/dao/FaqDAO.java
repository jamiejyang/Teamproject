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
			String sql = "INSERT INTO faqtable (QU, AN, qnum) " + "VALUES (?, ?, faq_seq.NEXTVAL)";
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

}
