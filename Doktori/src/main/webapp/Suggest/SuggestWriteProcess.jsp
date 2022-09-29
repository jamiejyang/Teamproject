<%@ page import="dao.SuggestDAO"%>
<%@ page import="dto.SuggestDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="utils.JSFunction"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%
String title = request.getParameter("title");
String content = request.getParameter("content");
String pass = request.getParameter("pass");
String files = request.getParameter("files");

System.out.println(title);
System.out.println(content);
System.out.println(pass);
System.out.println(files);

SuggestDTO dto = new SuggestDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setPass(pass);
dto.setFiles(files);
dto.setId(session.getAttribute("UserId").toString());

SuggestDAO dao = new SuggestDAO();
int iResult = dao.insertWrite(dto);
dao.close();
if (iResult == 1) {
	response.sendRedirect("SuggestList.jsp");
	
} else {
	JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>