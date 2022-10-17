<%@page import="dto.Comment2DTO"%>
<%@ page import="dao.SuggestDAO" %>%>
<%@ page import="dto.SuggestDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="utils.JSFunction"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%
String cmtnum = request.getParameter("cmtnum");
String bbsnum = request.getParameter("bbsnum");
String sessionId = session.getAttribute("UserId").toString();

Comment2DTO dto = new Comment2DTO();
SuggestDAO dao = new SuggestDAO(application);


int delResult = 0;

	dto.setCmtNum(cmtnum);
	delResult = dao.deleteComment(dto);
	dao.close();

	if (delResult == 1) {
		JSFunction.alertLocation("댓글 삭제되었습니다.", "SuggestView.jsp?num=" + bbsnum, out);
	} else {
		JSFunction.alertBack("댓글 삭제에 실패하였습니다.", out);

	return;
}
%>