package dto;

public class Comment2DTO {
	private int cmtNum;
	private int bbsNum;
	private String cmtID;
	private java.sql.Date cmtDate;
	private String cmtContent;
	public int getCmtNum() {
		return cmtNum;
	}
	public void setCmtNum(int cmtNum) {
		this.cmtNum = cmtNum;
	}
	public int getBbsNum() {
		return bbsNum;
	}
	public void setBbsNum(int bbsNum) {
		this.bbsNum = bbsNum;
	}
	public String getCmtID() {
		return cmtID;
	}
	public void setCmtID(String cmtID) {
		this.cmtID = cmtID;
	}
	public java.sql.Date getCmtDate() {
		return cmtDate;
	}
	public void setCmtDate(java.sql.Date cmtDate) {
		this.cmtDate = cmtDate;
	}
	public String getCmtContent() {
		return cmtContent;
	}
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}
	
	

}