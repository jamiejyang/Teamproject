<%@page import="utils.JSFunction"%>
<%@page import="dao.FaqDAO"%>
<%@page import="dto.FaqDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");

FaqDTO dto = new FaqDTO();
dto.setNum(num);
dto.setQu(title);
dto.setAn(content);

FaqDAO dao = new FaqDAO(application);
int affected = dao.updateEdit(dto);

if (affected == 1) {
	response.sendRedirect("Faq.jsp");
} else {
	JSFunction.alertBack("수정하기에 실패했습니다.", out);
}
%>