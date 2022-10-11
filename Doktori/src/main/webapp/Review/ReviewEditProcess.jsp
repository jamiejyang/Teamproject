<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="utils.JSFunction"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ include file="./IsLoggedIn.jsp" %>
    <% 
    String sessionId = session.getAttribute("UserId").toString();
    
    String saveDirectory = application.getRealPath("/Uploads");
    int maxPostSize = 1024* 2000;
    String encoding = "UTF-8";
    
    try{
    	//객체생성
    	MultipartRequest mr = new MultipartRequest(request, saveDirectory,
    			maxPostSize, encoding);
    	ReviewDAO dao = new ReviewDAO();
    	ReviewDTO dto = new ReviewDTO();
    	
    
    	int num = Integer.parseInt(mr.getParameter("num"));
    	String oFileName = mr.getFilesystemName("oldfile");
    	String title = mr.getParameter("title");
    	String content = mr.getParameter("content");
    	String fileName = mr.getFilesystemName("files");
    	
    	if(fileName !=null){
    		
    		
    		String ext = fileName.substring(fileName.lastIndexOf("."));
    		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
    		String newFileName = now + ext;
    	
    		File oldFile = new File(saveDirectory + File.separator + fileName);
    		File newFile = new File(saveDirectory + File.separator + newFileName);
    		oldFile.renameTo(newFile);
    		
    		dto.setTitle(title);
    		dto.setContent(content);
    		dto.setNum(num);
    		dto.setOfile(fileName);
    		dto.setSfile(newFileName);
    		dao.updateEdit(dto);
    		dao.close();
    		
    		}else{
    			dto=dao.selectView(num);
    			
    			dto.setTitle(title);
    			dto.setContent(content);
    			dto.setNum(num);
    			dao.updateEdit(dto);
    			dao.close();
    		}
    		response.sendRedirect("ReviewList.jsp?num="+dto.getNum());
    		
    } catch (Exception e) {
    	e.printStackTrace();
    	request.setAttribute("errorMessage", "파일 업로드 오류");
    	request.getRequestDispatcher("ReviewWrite.jsp").forward(request, response);
    }
    %>