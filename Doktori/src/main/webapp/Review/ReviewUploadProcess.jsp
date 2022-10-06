<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="utils.JSFunction"%>
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
    	
    
    	String fileName = mr.getFilesystemName("files");
//     	String ext = fileName.substring(fileName.lastIndexOf("."));
//     	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
    	
		String newFileName = fileName; 
    	
    	File oldFile = new File(saveDirectory + File.separator + fileName);
//     	File newFile = new File(saveDirectory + File.separator + newFileName); //파일명 변경
//     	oldFile.renameTo(newFile);
    	
    	
    	String title = mr.getParameter("title");
    	String content = mr.getParameter("content");
    	String id = mr.getParameter("id");
    	int topfix = Integer.parseInt(mr.getParameter("notice")); //상단공지글 체크 여부
 		System.out.println("======================="+mr.getParameter("notice"));
    		
    	ReviewDAO dao = new ReviewDAO();
    	String uid = (String)session.getAttribute("UserId");
    	ReviewDTO dto = new ReviewDTO();
    	dto.setTitle(title);
    	dto.setContent(content);
    	dto.setId(uid);
    	dto.setFiles(newFileName);
    	dto.setTopfix(topfix);
    	
   
    	if(fileName== null) {
    		dto.setFiles(" ");
    	} else {
    		dto.setFiles(newFileName);
    	}
    		dao.insertFile(dto);
    		dao.close();
    	
    	response.sendRedirect("ReviewList.jsp");
    }
    catch (Exception e) {
    	e.printStackTrace();
    	request.setAttribute("errorMessage", "파일 업로드 오류");
//     	request.getRequestDispatcher("ReviewUpload.jsp").forward(request, response);
    }
    %>