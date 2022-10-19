<%@page import="utils.JSFunction"%>
<%@page import="dao.FaqDAO"%>
<%@page import="dto.FaqDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	FaqDTO dto = new FaqDTO();
	dto.setQu(title);
	dto.setAn(content);
	
	FaqDAO dao = new FaqDAO(application);
	int iResult = dao.insertFaq(dto);
	
	if(iResult == 1) {
		response.sendRedirect("Faq.jsp");
	} else {
		JSFunction.alertBack("FAQ등록 실패", out);
	}
%>