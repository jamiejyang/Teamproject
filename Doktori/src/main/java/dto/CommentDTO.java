package dto;

public class CommentDTO {
	private int cmtnum;
	private int bbsnum;
	private String cmtid;
	private String cmtnickname;
	private String cmtdate;
	private String cmtcontent;
	
	
	public int getCmtnum() {
		return cmtnum;
	}
	public void setCmtnum(int cmtnum) {
		this.cmtnum = cmtnum;
	}
	public int getBbsnum() {
		return bbsnum;
	}
	public void setBbsnum(int bbsnum) {
		this.bbsnum = bbsnum;
	}
	public String getCmtid() {
		return cmtid;
	}
	public void setCmtid(String cmtid) {
		this.cmtid = cmtid;
	}
	public String getCmtdate() {
		return cmtdate;
	}
	public void setCmtdate(String cmtdate) {
		this.cmtdate = cmtdate;
	}
	public String getCmtcontent() {
		return cmtcontent;
	}
	public void setCmtcontent(String cmtcontent) {
		this.cmtcontent = cmtcontent;
	}
	public String getCmtnickname() {
		return cmtnickname;
	}
	public void setCmtnickname(String cmtnickname) {
		this.cmtnickname = cmtnickname;
	}

	
}