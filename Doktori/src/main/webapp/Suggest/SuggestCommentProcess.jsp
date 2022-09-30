<%-- <%@ page import="dao.Comment2DAO"%> --%>
<%@ page import="dao.SuggestDAO"%>
<%@ page import="dto.SuggestDTO"%>
<%@ page import="dto.Comment2DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="utils.JSFunction"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%
// String num = request.getParameter("num");
// SuggestDTO sdto = new SuggestDTO();
// sdto.setNum(num);
// String bbsnum = request.getParameter("bbsnum");


// String num = request.getParameter("num");
String cmtcontent = request.getParameter("cmtcontent");

// System.out.println(bbsnum);
System.out.println(cmtcontent);

Comment2DTO dto = new Comment2DTO();
dto.setBbsNum(request.getParameter("bbsnum"));
dto.setCmtContent(cmtcontent);
dto.setCmtID(session.getAttribute("UserId").toString());

SuggestDAO dao = new SuggestDAO();
int iResult = dao.insertComment(dto);
dao.close();
if (iResult == 1) {
	response.sendRedirect("SuggestList.jsp");
	
} else {
	JSFunction.alertBack("댓글쓰기에 실패하였습니다.", out);
}
%>