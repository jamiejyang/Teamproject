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
    	
    	ReviewDAO dao = new ReviewDAO();
    	ReviewDTO dto = new ReviewDTO();
    	String fileName = mr.getFilesystemName("files");
    	System.out.println(fileName);
    	String title = mr.getParameter("title");
    	System.out.println(title);
    	String content = mr.getParameter("content");
    	System.out.println(content);
    	int topfix = Integer.parseInt(mr.getParameter("notice")); //상단공지글 체크 여부
       	String uid = (String)session.getAttribute("UserId");
       	
    	
    	if(fileName!=null){
	    	String ext = fileName.substring(fileName.lastIndexOf("."));
	    	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	    	String newFileName = now + ext; 
	    	
	    	File oldFile = new File(saveDirectory + File.separator + fileName);
	    	File newFile = new File(saveDirectory + File.separator + newFileName); 
	    	oldFile.renameTo(newFile);
	 
	    	dto.setTitle(title);
	    	dto.setContent(content);
	    	dto.setId(uid);
	    	dto.setOfile(fileName);
	    	dto.setSfile(newFileName);
	    	dto.setTopfix(topfix);
	    	
    		dao.insertFile(dto);
    		dao.close();
    	} else { 
    		dto.setTitle(title);
	    	dto.setContent(content);
	    	dto.setId(uid);
	    	dto.setOfile(" ");
	    	dto.setSfile(" ");
	    	dto.setTopfix(topfix);
	    	
    		dao.insertFile(dto);
    		dao.close();
    	}
    	
    	response.sendRedirect("ReviewList.jsp");
    }
    catch (Exception e) {
    	e.printStackTrace();
    	request.setAttribute("errorMessage", "파일 업로드 오류");
//     	request.getRequestDispatcher("ReviewUpload.jsp").forward(request, response);
    }
    %>