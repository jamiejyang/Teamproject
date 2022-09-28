<%@page import="dao.NoticeDAO"%>
<%@page import="dao.LibDAO"%>
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

	// 	파일 명 변경
	File newFile = new File(saveDirectory + File.separator + fileName);

	NoticeDAO dao = new NoticeDAO();
	NoticeDTO dto = new NoticeDTO();
	String num = mr.getParameter("num");
	String oldfileName = mr.getParameter("oldfile");

	File oldFile = new File(saveDirectory + File.separator + oldfileName);
	if (oldFile.exists()) {
		oldFile.delete();
	}

	// 	다른폼값 받기
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");

	dto.setTitle(title);
	dto.setContent(content);
	dto.setNum(num);

	if (fileName == null) {
		dto.setFiles(" ");
		// 	dao.notfileUpdate(dto);
	} else {
		dto.setFiles(fileName);
	}

	dao.updateEdit(dto);
	dao.close();

	response.sendRedirect("NoticeList.jsp");
} catch (Exception e) {
	e.printStackTrace();
	request.setAttribute("errorMessage", "파일 업로드 오류 여기인것인가");
	request.getRequestDispatcher("NoticeUpload.jsp").forward(request, response);
}
%>