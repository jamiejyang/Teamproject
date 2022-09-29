<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    MemberDAO dao =new MemberDAO();
    MemberDTO dto= new MemberDTO();
    String mid= request.getParameter("mid");
	
    dto.setId(mid);
    
    int result =0;
    
    result= dao.deleteMember(dto);
    
    System.out.println(mid);
    System.out.println(result);
    
    if(result == 1 ){
    	JSFunction.alertLocation("회원탈퇴 성공.", "MyPageAdmin.jsp", out);
    } else {
    	JSFunction.alertBack("삭제 실패.", out);
    }
    %>
<!DOCTYPE html>
