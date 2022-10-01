<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.io.File" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="commentDTO" class="dto.CommentDTO" scope="page" />
<jsp:setProperty name="cmtContent" property="cmtContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	 <%
	 	String userId = null;
	 	if(session.getAttribute("UserId") != null){
	 		userId = (String) session.getAttribute("UserId");
	 	}
// 	 	int boardID = 0;
// 		if (request.getParameter("boardID") != null){
// 			boardID = Integer.parseInt(request.getParameter("boardID"));
// 		}
		String realFolder="";
		String saveFolder = "Uploads/CommentUploads";
		String encType = "utf-8";
		int maxSize=5*1024*1024;
		
		ServletContext context = this.getServletContext();
		realFolder = context.getRealPath(saveFolder);
		
		MultipartRequest multi = null;
		
		multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());		
		String fileName = multi.getFilesystemName("fileName");
		String cmtContent = multi.getParameter("cmtContent");
		commentDTO.setCmtcontent(cmtContent);
		
	 	if(userId == null){
	 		PrintWriter script = response.getWriter();
	 		script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
	 		script.println("location.href = 'LoginForm.jsp'");
	 		script.println("</script>");
	 	} 
	 	else{
		 	int num = 0; 
		 	if (request.getParameter("num") != null){
		 		num = Integer.parseInt(request.getParameter("num"));
		 	
		 	if (num == 0){
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('유효하지 않은 글입니다.')");
		 		script.println("location.href = 'LoginForm.jsp'");
		 		script.println("</script>");
		 	}
	 		if (commentDTO.getCmtcontent() == null){
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('댓글을 입력되지 않았습니다.')");
		 		script.println("history.back()");
		 		script.println("</script>");
		 	} else {
		 		CommentDAO dao = new CommentDAO();
		 		int cmtNum = dao.writeComment(num, userId, commentDTO.getCmtcontent());
		 		if (cmtNum == -1){
			 		PrintWriter script = response.getWriter();
			 		script.println("<script>");
			 		script.println("alert('댓글 쓰기에 실패했습니다.')");
			 		script.println("history.back()");
			 		script.println("</script>");
			 	}
		 		else{
			 		PrintWriter script = response.getWriter();
			 		if(fileName != null){
						File oldFile = new File(realFolder+"/"+fileName);
						File newFile = new File(realFolder+"/"+num+"사진"+(cmtNum-1)+".jpg");
						oldFile.renameTo(newFile);
					}
			 		script.println("<script>");
			 		script.println("location.href=document.referrer;");
			 		script.println("</script>");
			 	}
		 	}
		 }
	 	}
	 %>
</body>
</html>