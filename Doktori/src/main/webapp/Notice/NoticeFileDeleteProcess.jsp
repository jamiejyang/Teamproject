<%@page import="dto.NoticeDTO"%>
<%@page import="dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int result =0;
String num= request.getParameter("num");
NoticeDAO dao =new NoticeDAO();
NoticeDTO dto= dao.selectView(num);
result= dao.updateFileReset(dto);
// System.out.println(result);
// System.out.println("해치웠나?");
if(result !=0){
	System.out.println("파일만 변경 성공");
}
	response.sendRedirect("NoticeEdit.jsp?num="+num);
%>
<!DOCTYPE html>
