<%@page import="dao.NoticeDAO"%>
<%@page import="utils.JSFunction"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.MultipartParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String saveDirectory = application.getRealPath("/Uploads");
System.out.println(saveDirectory);
int maxPostSize = 2000 * 1024;
String encoding = "UTF-8";

try {
	// 	객체 생성
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);

	// 	새로운 파일명 생성
	NoticeDAO dao = new NoticeDAO();
	NoticeDTO dto = new NoticeDTO();
	String fileName = mr.getFilesystemName("attachedFile");
	String name = mr.getParameter("name");
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String libname = mr.getParameter("libname");
	if (fileName != null) {

		String ext = fileName.substring(fileName.lastIndexOf("."));
		String now = new SimpleDateFormat("YYYYMMDD_HmsS").format(new Date());
		String newFileName = now + ext;

		// 	파일 명 변경
		File oldFile = new File(saveDirectory + File.separator + fileName);
		File newFile = new File(saveDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile);
		// 	다른폼값 받기

		dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setmanagecode(libname);

		dto.setOfile(fileName);
		dto.setSfile(newFileName);
		dao.insertFile(dto);
		dao.close();

	} else {
		dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setmanagecode(libname);
		dto.setOfile(" ");
		dto.setSfile(" ");
		dao.insertFile(dto);
		dao.close();
	}
	response.sendRedirect("NoticeList.jsp");
} catch (Exception e) {
	e.printStackTrace();
	JSFunction.alertBack("글쓰기 오류.", out);
;}
%>