<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="./IsLoggedIn.jsp" %>
    <%
    String saveDirectory = application.getRealPath("/Uploads");
    int maxPostSize = 2000 * 1024;
    String encoding = "UTF-8";
    
    try{
    	// 	객체 생성
    	MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
    	// 	새로운 파일명 생성
    	String fileName = mr.getFilesystemName("files");
    	// 	파일 명 변경
    	File newFile = new File(saveDirectory + File.separator + fileName);
    	SuggestDAO dao = new SuggestDAO();
    	SuggestDTO dto = new SuggestDTO();
    	String num = mr.getParameter("num");
    	String oldfileName = mr.getParameter("oldfile");
    	System.out.println(oldfileName);
    	File oldFile = new File(saveDirectory + File.separator + oldfileName);
    	if (oldFile.exists()) {
    		oldFile.delete();
    	
    }
    
    
    String title = mr.getParameter("title");
    String content = mr.getParameter("content");
    
    dto.setNum(num);
    dto.setTitle(title);
    dto.setContent(content);
    
    if(fileName==null){
    	dto.setFiles(" ");
    }else{
    	dto.setFiles(fileName);
    }
    
    dao.updateEdit(dto);
    dao.close();
    response.sendRedirect("SuggestView.jsp?num=" + dto.getNum());
    
    }
    catch(Exception e){
    	e.printStackTrace();
    	request.setAttribute("errorMessage", "파일 업로드 오류");
    	request.getRequestDispatcher("SuggestWrite.jsp").forward(request,response);
    }
    %>