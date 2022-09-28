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
int maxPostSize = 2000 * 1024;
String encoding = "UTF-8";

try {
	// 	객체 생성
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);

	// 	새로운 파일명 생성
	String fileName = mr.getFilesystemName("attachedFile");
	// 	String ext = fileName.substring(fileName.lastIndexOf("."));
	// 	String now = new SimpleDateFormat("YYYYMMDD_HmsS").format(new Date());
	String newFileName = fileName;

	// 	파일 명 변경
	File newFile = new File(saveDirectory + File.separator + newFileName);

	// 	다른폼값 받기
	String name = mr.getParameter("name");
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String libname = mr.getParameter("libname");

	NoticeDTO dto = new NoticeDTO();
	dto.setName(name);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setLibname(libname);
	NoticeDAO dao = new NoticeDAO();

	if (fileName == null) {
		dto.setFiles(" ");
		//	dao.notfileinsert(dto);
	} else {
		dto.setFiles(newFileName);
		dao.insertFile(dto);
		dao.close();
	}

	System.out.println(name);
	response.sendRedirect("NoticeList.jsp");
} catch (Exception e) {
	e.printStackTrace();
	// 	JSFunction.alertBack("errorMessage", "업로드 실패! ");
	// 	request.setAttribute("errorMessage", "파일 업로드 오류 여기인것인가");
	request.getRequestDispatcher("NoticeUpload.jsp").forward(request, response);
}
%>