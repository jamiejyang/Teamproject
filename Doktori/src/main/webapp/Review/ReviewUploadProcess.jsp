<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String saveDirectory = application.getRealPath("/Uploads");
    int maxPostSize = 1024* 2000;
    String encoding = "UTF-8";
    
    try{
    	
    	MultipartRequest mr = new MultipartRequest(request, saveDirectory,
    			maxPostSize, encoding);
    	
    	String fileName = mr.getFilesystemName("attachedFile");
//     	String ext = fileName.substring(fileName.lastIndexOf("."));
//     	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
    	
		String newFileName = fileName; 
    	
//     	File oldFile = new File(saveDirectory + File.separator + fileName);
    	File newFile = new File(saveDirectory + File.separator + newFileName); //파일명 변경
//     	oldFile.renameTo(newFile);
    	
    	
    	//다른 폼값 받기
    	String title = mr.getParameter("title");
    	String content = mr.getParameter("content");
    	String id = mr.getParameter("id");
    	String pass = mr.getParameter("pass");
 
    	ReviewDAO dao = new ReviewDAO();
    	String uid = (String)session.getAttribute("UserId");
    	ReviewDTO dto = new ReviewDTO();
    	
    	if(fileName== null) {
    		dto.setFiles(" ");
    	} else {
    		dto.setFiles(newFileName);
    		dao.insertFile(dto);
    		dao.close();
    	}
    	dto.setTitle(title);
    	dto.setContent(content);
    	dto.setId(uid);
//     	dto.setUfile(ufile);
    	dto.setFiles(newFileName);
    	dto.setPass(pass);
    	dao.insertWrite(dto);
    	dao.close();
    	
    	response.sendRedirect("ReviewList.jsp");
    }
    catch (Exception e) {
    	e.printStackTrace();
//     	request.setAttribute("errorMessage", "파일 업로드 오류");
    	request.getRequestDispatcher("ReviewUpload.jsp").forward(request, response);
    }
    %>