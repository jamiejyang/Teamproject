<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="utils.JSFunction"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%

String sessionId = session.getAttribute("UserId").toString();

String num = request.getParameter("num");
String pass = request.getParameter("pass");

SuggestDTO dto = new SuggestDTO();
dto.setNum(num);
dto.setPass(pass);

SuggestDAO dao = new SuggestDAO(application);
int result = dao.checkPass(dto);
dao.close();

if(dto.getId().equals(sessionId)){
	if(dto.getNum().equals(num) && dto.getPass().equals(pass)){
	response.sendRedirect("SuggestView.jsp?num=" + dto.getNum());		
	}else{
		JSFunction.alertBack("비밀번호가 틀렸습니다.", out);		
	}
}else{
	JSFunction.alertBack("작성자만 열람할 수 있습니다.", out);
}

%>