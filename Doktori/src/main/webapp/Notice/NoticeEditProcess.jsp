
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
	NoticeDAO dao = new NoticeDAO();
	NoticeDTO dto = new NoticeDTO();
	
	String num = mr.getParameter("num");
	String oldfileName = mr.getParameter("oldfile");
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	// 	새로운 파일명 생성
	String fileName = mr.getFilesystemName("attachedFile");
	
	if(fileName !=null){
		
	
	String ext = fileName.substring(fileName.lastIndexOf("."));
	String now = new SimpleDateFormat("YYYYMMDD_HmsS").format(new Date());
	String newFileName = now + ext;
	// 	파일 명 변경
	File oldFile = new File(saveDirectory + File.separator + fileName);
	File newFile = new File(saveDirectory + File.separator + newFileName);
	oldFile.renameTo(newFile);
	dto= dao.selectView(num);
	String nfileName= dto.getSfile();
	File file= new File(saveDirectory+File.separator+nfileName);
	if (file.exists()) {
		file.delete();
	}
	dto.setTitle(title);
	dto.setContent(content);
	dto.setNum(num);

	dto.setOfile(fileName);
	dto.setSfile(newFileName);

	dao.updateEdit(dto);
	dao.close();
	}else{
		dto =dao.selectView(num);
		// 		-----------
		dto.setTitle(title);
		dto.setContent(content);
		dto.setNum(num);
		dao.updateEdit(dto);
		dao.close();
	}
	response.sendRedirect("NoticeList.jsp");
} catch (Exception e) {
	e.printStackTrace();
	request.getRequestDispatcher("NoticeEdit.jsp").forward(request, response);
}
%>