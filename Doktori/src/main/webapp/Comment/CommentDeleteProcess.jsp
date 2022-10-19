<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.CommentDAO"%>
<%@ page import="dto.CommentDTO"%>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%
		String userId = null;
		if (session.getAttribute("UserId") != null) {
			userId = (String) session.getAttribute("UserId");
		}
		if (userId == null) {
			JSFunction.alertLocation("로그인을 해주세요", "../Login/LoginForm.jsp", out);
		} 
		//게시글이 유효한지 판별
		int num = 0;
		if (request.getParameter("num") != null){
			num = Integer.parseInt(request.getParameter("num"));
		}
		//댓글이 유효한지 판별
		int cmtNum = 0;
		if (request.getParameter("cmtNum") != null) {
			cmtNum = Integer.parseInt(request.getParameter("cmtNum"));
		}
		if (cmtNum == 0) {
			JSFunction.alertLocation("유효하지 않은 글입니다.", "../Review/ReviewView.jsp", out);
		}
		CommentDTO dto = new CommentDAO().getComment(cmtNum);
		if (!userId.equals(dto.getCmtid()) && !userId.equals("admin")) {
			JSFunction.alertLocation("권한이 없습니다.", "../Review/ReviewView.jsp", out);				
		} else {
			CommentDAO dao = new CommentDAO();
			int result = dao.deleteComment(cmtNum);
			dao.close();
			if (result == -1) {
				JSFunction.alertBack("댓글 삭제에 실패하였습니다.", out);
			} else {
				JSFunction.alertLocation("댓글을 삭제하였습니다.", "../Review/ReviewView.jsp?num="+num, out);
			}
		}
		%>
</body>
</html>