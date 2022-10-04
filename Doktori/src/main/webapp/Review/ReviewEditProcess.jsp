<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ include file="./IsLoggedIn.jsp" %>
    <%
    
    String saveDirectory = application.getRealPath("/Uploads");
    System.out.println("============ saveDirectory = " + saveDirectory);
    int maxPostSize = 1024* 2000;
    String encoding = "UTF-8";
    
    try{
    	//객체생성
    	MultipartRequest mr = new MultipartRequest(request, saveDirectory,
    			maxPostSize, encoding);
    	//새로운 파일명 생성
    	String fileName = mr.getFilesystemName("files");

		//파일명 생성    	
    	File newFile = new File(saveDirectory + File.separator + fileName); //파일명 변경
    	
    	ReviewDAO dao = new ReviewDAO();
    	ReviewDTO dto = new ReviewDTO();
    	
    	int num = Integer.parseInt(mr.getParameter("num"));
    	String oldFileName = mr.getParameter("oldfile");
    	
    	File oldFile=new File(saveDirectory + File.separator +oldFileName);
    	if(oldFile.exists()) {
    		oldFile.delete();
    	}
    	
    	//다른 폼값 받기
    	String title = mr.getParameter("title");
    	String content = mr.getParameter("content");
    
    	dto.setTitle(title);
    	dto.setContent(content);
    	dto.setNum(num);
    	
    	if(fileName==null) {
    		dto.setFiles(" ");
     	} else{
     		dto.setFiles(fileName);
     	}
    	
    	
    	dao.updateEdit(dto);
    	dao.close();
    	response.sendRedirect("ReviewList.jsp?num="+dto.getNum());
//     	response.sendRedirect("ReviewList.jsp");
    }
    catch (Exception e) {
    	e.printStackTrace();
    	request.setAttribute("errorMessage", "파일 업로드 오류");
    	request.getRequestDispatcher("ReviewWrite.jsp").forward(request, response);
    }
    %>