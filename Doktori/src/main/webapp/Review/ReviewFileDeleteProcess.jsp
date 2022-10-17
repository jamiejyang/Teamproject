<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int result =0;
int num= Integer.parseInt(request.getParameter("num"));
ReviewDAO dao =new ReviewDAO();
ReviewDTO dto= dao.selectView(num);
result= dao.updateFileReset(dto);

if(result !=0){
	System.out.println("파일만 변경 성공");
}
	response.sendRedirect("ReviewEdit.jsp?num="+num);
%>
<!DOCTYPE html>