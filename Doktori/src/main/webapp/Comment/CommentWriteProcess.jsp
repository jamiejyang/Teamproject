<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="utils.JSFunction"%>
<%@ page import="dao.CommentDAO"%>
<%@ page import="dto.CommentDTO"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%-- <jsp:useBean id="commentDTO" class="dto.CommentDTO" scope="page" /> --%>
<%-- <jsp:setProperty name="cmtContent" property="cmtContent" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
	CommentDAO dao = new CommentDAO();
	CommentDTO dto = new CommentDTO();

	String userId = null;
	if (session.getAttribute("UserId") != null) {
		dto.setCmtid(session.getAttribute("UserId").toString());
	}

	int num = 0;
	if (request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
// 		System.out.println("게시글번호 " + num);
	}
	if (num == 0) {
		JSFunction.alertLocation("유효하지 않은 글입니다.", "../Login/LoginForm.jsp", out);
	}

	String cmtContent = request.getParameter("cmtContent");
	dto.setCmtcontent(cmtContent);
	dto.setBbsnum(num);

	int cmtNum = dao.writeComment(dto);
	if (cmtNum == -1) {
		JSFunction.alertBack("댓글 쓰기 실패!", out);
	} else {
		JSFunction.alertLocation("댓글을 성공적으로 작성하였습니다.", "../Review/ReviewView.jsp?num=" + num, out);
	}

	dao.close();
	%>
</body>
</html>