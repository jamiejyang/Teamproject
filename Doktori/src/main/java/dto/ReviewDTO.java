package dto;

import java.sql.Date;

public class ReviewDTO {
	private int num; //게시물 글번호(시퀀스)
	private String id; //글작성자 ID
	private String pass; 
	private String title; //글제목
	private String content;  //글 내용
	private String files; //첨부파일 이름
	private int cmtref; //글 그룹번호
	private int cmtlev;  //답변글 깊이
	private int cmtseq;   //답변글 순서
	private int readcount;  //글 조회수
	private Date writedate;  //작성 날짜
	private int parent;  //부모글
	
	
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
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	public int getCmtref() {
		return cmtref;
	}
	public void setCmtref(int cmtref) {
		this.cmtref = cmtref;
	}
	public int getCmtlev() {
		return cmtlev;
	}
	public void setCmtlev(int cmtlev) {
		this.cmtlev = cmtlev;
	}
	public int getCmtseq() {
		return cmtseq;
	}
	public void setCmtseq(int cmtseq) {
		this.cmtseq = cmtseq;
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
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	
	

	
}
