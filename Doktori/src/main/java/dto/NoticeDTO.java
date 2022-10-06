package dto;

import java.sql.Date;

public class NoticeDTO {
private String id;
private String num;
private String name;
private String title;
private String content;
private Date writedate;
private String libname;
private int readcount;
private String ofile;
private String sfile;

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
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getNum() {
	return num;
}
public void setNum(String num) {
	this.num = num;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
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
public Date getWritedate() {
	return writedate;
}
public void setWritedate(Date writedate) {
	this.writedate = writedate;
}
public String getLibname() {
	return libname;
}
public void setLibname(String libname) {
	this.libname = libname;
}
public int getReadcount() {
	return readcount;
}
public void setReadcount(int readcount) {
	this.readcount = readcount;
}

}
