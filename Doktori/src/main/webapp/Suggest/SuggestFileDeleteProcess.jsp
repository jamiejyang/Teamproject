<%@page import="dto.SuggestDTO"%>
<%@page import="dao.SuggestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int result =0;
String num= request.getParameter("num");
SuggestDAO dao =new SuggestDAO();
SuggestDTO dto= dao.selectView(num);
result= dao.updateFileReset(dto);
if(result !=0){
	System.out.println("파일만 변경 성공");
}
	response.sendRedirect("SuggestEdit.jsp?num="+num);
%>
<!DOCTYPE html>