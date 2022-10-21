package dto;

import java.sql.Date;

public class ReviewDTO {
	private int num; //게시물 글번호(시퀀스)
	private String id; //글작성자 ID
	private String title; //글제목
	private String content;  //글 내용
	private int cmtcount;  //댓글 갯수
	private int readcount;  //글 조회수
	private Date writedate;  //작성 날짜
	private int topfix; //공지사항 상단노출
	private String ofile;
	private String sfile;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	public int getCmtcount() {
		return cmtcount;
	}
	public void setCmtcount(int cmtcount) {
		this.cmtcount = cmtcount;
	}
	public int getTopfix() {
		return topfix;
	}
	public void setTopfix(int topfix) {
		this.topfix = topfix;
	}
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getSfile() {
		return sfile;
	}
	public void setSfile(String sfile) {
		this.sfile = sfile;
	}
		
}
