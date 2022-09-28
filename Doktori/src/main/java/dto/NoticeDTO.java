package dto;

import java.sql.Timestamp;

public class NoticeDTO {
private String id;
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
private String num;
private String name;
private String title;
private String content;
private String files;
private Timestamp writedate;
private String libname;
private int readcount;
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
public String getFiles() {
	return files;
}
public void setFiles(String files) {
	this.files = files;
}
public Timestamp getWritedate() {
	return writedate;
}
public void setWritedate(Timestamp writedate) {
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
