<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.MultipartParser"%>
<%@ page import="utils.JSFunction"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    	SuggestDAO dao = new SuggestDAO();
    	SuggestDTO dto = new SuggestDTO();
    	
    	
    	String num = mr.getParameter("num");
    	String oldfileName = mr.getParameter("oldfile");
        String title = mr.getParameter("title");
        String content = mr.getParameter("content");
    	// 	새로운 파일명 생성
    	String fileName = mr.getFilesystemName("attachedFile");
    	
    if(fileName!=null){
    	
    	String ext = fileName.substring(fileName.lastIndexOf("."));
    	String now = new SimpleDateFormat("YYYYMMDD_HmsS").format(new Date());
    	String newFileName = now + ext;
    	
    	
    	File oldFile = new File(saveDirectory + File.separator + fileName);
    	File newFile = new File(saveDirectory + File.separator + newFileName);
    	
    	oldFile.renameTo(newFile);
    	
    	dto=dao.selectView(num);
    	String nfileName=dto.getSfile();
    	File file = new File(saveDirectory+File.separator+nfileName);
    	if (file.exists()){
    		file.delete();
    	}
        dto.setNum(num);
        dto.setTitle(title);
        dto.setContent(content);
    	dto.setOfile(fileName);
        dto.setSfile(newFileName);
        dao.updateEdit(dto);
        dao.close();
    
    }else{
    	dto = dao.selectView(num);
    	
        dto.setNum(num);
        dto.setTitle(title);
        dto.setContent(content);
        dao.updateEdit(dto);
        System.out.println(oldfileName+" 이게 올드파일네임 여기냐?");
    	System.out.println(fileName+" 이게 파일네임 제발 ㅠㅠ ");
        dao.close();
    }
    
    response.sendRedirect("SuggestView.jsp?num=" + dto.getNum());
    
    }
    catch(Exception e){
    	e.printStackTrace();
//     	request.setAttribute("errorMessage", "파일 업로드 오류");
    	request.getRequestDispatcher("SuggestWrite.jsp").forward(request,response);
    }
    %>