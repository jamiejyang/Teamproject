package dto;

public class SuggestDTO {

	private String num;
	private String title;
	private String content;
	private String processing;
	private String id;
	private String pass;
	private java.sql.Date postdate;
	private String visitcount;
	private String ufile;

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

	public java.sql.Date getPostdate() {
		return postdate;
	}

	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}

	public String getVisitcount() {
		return visitcount;
	}

	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}

	public String getUfile() {
		return ufile;
	}

	public void setUfile(String ufile) {
		this.ufile = ufile;
	}

}
