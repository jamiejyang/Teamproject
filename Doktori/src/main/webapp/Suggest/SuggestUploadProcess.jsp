<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String saveDirectory = application.getRealPath("/Uploads");
    int maxPostSize = 1024* 1000;
    String encoding = "UTF-8";
    
    try{
    	
    	MultipartRequest mr = new MultipartRequest(request, saveDirectory,
    			maxPostSize, encoding);
    	
    	SuggestDAO dao = new SuggestDAO();
    	SuggestDTO dto = new SuggestDTO();
    	
    	String fileName = mr.getFilesystemName("files");
    	
    	String title = mr.getParameter("title");
    	String content = mr.getParameter("content");
    	String id = mr.getParameter("id");
    	String pass = mr.getParameter("pass");
    	String uid = (String)session.getAttribute("UserId");
    	
    	if(fileName!= null) {
    	
    	String ext = fileName.substring(fileName.lastIndexOf("."));
    	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
    	String newFileName = now + ext;
    	
    	File oldFile = new File(saveDirectory + File.separator + fileName);
    	File newFile = new File(saveDirectory + File.separator + newFileName);
    	oldFile.renameTo(newFile);
    	
    	dto.setTitle(title);
    	dto.setContent(content);
    	dto.setId(uid);
    	dto.setPass(pass);
    	
    	dto.setOfile(fileName);
    	dto.setSfile(newFileName);
    	dao.insertWrite(dto);
    	dao.close();

    	} else {
    		dto.setTitle(title);
    		dto.setContent(content);
    		dto.setId(uid);
    		dto.setPass(pass);
    		dto.setOfile(" ");
    		dto.setSfile(" ");
    		
    		dao.insertWrite(dto);
    		dao.close();
    	}

    	
    	response.sendRedirect("SuggestList.jsp");
    }
    catch (Exception e) {
    	e.printStackTrace();
    	request.setAttribute("errorMessage", "파일 업로드 오류");
    	request.getRequestDispatcher("SuggestList.jsp").forward(request, response);
    }
    %>