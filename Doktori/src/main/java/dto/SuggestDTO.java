package dto;

public class SuggestDTO {

	private String num;
	private String title;
	private String content;
	private String processing;
	private String id;
	private String pass;
	private java.sql.Date writedate;
	private String readcount;
	private String ofile;
	private String sfile;
	

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
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

	public String getProcessing() {
		return processing;
	}

	public void setProcessing(String processing) {
		this.processing = processing;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		System.out.println(pass);
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public java.sql.Date getWritedate() {
		return writedate;
	}

	public void setWritedate(java.sql.Date writedate) {
		this.writedate = writedate;
	}

	public String getReadcount() {
		return readcount;
	}

	public void setReadcount(String readcount) {
		this.readcount = readcount;
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
