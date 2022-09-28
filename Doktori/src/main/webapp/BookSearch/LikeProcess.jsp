<%@page import="dao.LibDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
    String booknum = request.getParameter("booknum");
	LibDAO dao = new LibDAO();
    
%>
<!DOCTYPE html>