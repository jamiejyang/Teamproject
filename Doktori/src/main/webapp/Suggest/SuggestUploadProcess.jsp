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
    	
    	String fileName = mr.getFilesystemName("files");
    	String ext = fileName.substring(fileName.lastIndexOf("."));
    	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
    	String newFileName = now + ext;
    	
    	File oldFile = new File(saveDirectory + File.separator + fileName);
    	File newFile = new File(saveDirectory + File.separator + newFileName);
    	oldFile.renameTo(newFile);
    	
    	String title = mr.getParameter("title");
    	String content = mr.getParameter("content");
    	String id = mr.getParameter("id");
    	String pass = mr.getParameter("pass");
    	StringBuffer cateBuf = new StringBuffer();
//     	if (cateArray == null){
//     		cateBuf.append("선택 없음");
//     	}
//     	else {
//     		for (String s : cateArray){
//     			cateBuf.append(s + ", ");
//     	}
//     }
    	SuggestDAO dao = new SuggestDAO(application);
    	String uid = (String)session.getAttribute("UserId");
    	SuggestDTO dto = new SuggestDTO();
    	dto.setTitle(title);
    	dto.setContent(content);
    	dto.setId(uid);
//     	dto.setFiles(files);
    	dto.setFiles(newFileName);
    	dto.setPass(pass);
    	dao.insertWrite(dto);
    	dao.close();
    	
    	response.sendRedirect("SuggestList.jsp");
    }
    catch (Exception e) {
    	e.printStackTrace();
    	request.setAttribute("errorMessage", "파일 업로드 오류");
//     	request.getRequestDispatcher("FileUploadMain.jsp").forward(request, response);
    }
    %>