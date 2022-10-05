package dto;

public class LibDTO {
	private String bookKey;
	private String speciesKey;
	private String libName;
	private String manageCode;
	private String regNo;
	private String controlNo;
	private String callNo;
	private String shelfLocName;
	private String title;
	private String author;
	private String publisher;
	private String pubYear;
	private String isbn;
	private String bookNum;
	private String bookimg;
	
	public String getBookimg() {
		return bookimg;
	}

	public void setBookimg(String bookimg) {
		this.bookimg = bookimg;
	}

	public  String  getBookNum() {
		return bookNum;
	}

	public void setBookNum(String bookNum) {
		this.bookNum= bookNum;
	}

	public LibDTO(String bookKey, String speciesKey, String libName, String manageCode, String regNo, String controlNo,
			String callNo, String shelfLocName, String title, String author, String publisher, String pubYear,
			String isbn,String bookNum) {
		this.bookKey = bookKey; //0
		this.speciesKey = speciesKey; //1
		this.libName = libName; //2
		this.manageCode = manageCode; // 3
		this.regNo = regNo; // 4
		this.controlNo = controlNo; //5
		this.callNo = callNo; // 6
		this.shelfLocName = shelfLocName; //7
		this.title = title; //8
		this.author = author; // 11
		this.publisher = publisher; //12
		this.pubYear = pubYear; //13
		this.isbn = isbn; //15
		this.bookNum=bookNum;
	}

	public LibDTO() {

	}
	public String getBookKey() {
		return bookKey;
	}

	public void setBookKey(String bookKey) {
		this.bookKey = bookKey;
	}

	public String getSpeciesKey() {
		return speciesKey;
	}

	public void setSpeciesKey(String speciesKey) {
		this.speciesKey = speciesKey;
	}

	public String getLibName() {
		return libName;
	}

	public void setLibName(String libName) {
		this.libName = libName;
	}

	public String getManageCode() {
		return manageCode;
	}

	public void setManageCode(String manageCode) {
		this.manageCode = manageCode;
	}

	public String getRegNo() {
		return regNo;
	}

	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}

	public String getControlNo() {
		return controlNo;
	}

	public void setControlNo(String controlNo) {
		this.controlNo = controlNo;
	}

	public String getCallNo() {
		return callNo;
	}

	public void setCallNo(String callNo) {
		this.callNo = callNo;
	}

	public String getShelfLocName() {
		return shelfLocName;
	}

	public void setShelfLocName(String shelfLocName) {
		this.shelfLocName = shelfLocName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPubYear() {
		return pubYear;
	}

	public void setPubYear(String pubYear) {
		this.pubYear = pubYear;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

}
