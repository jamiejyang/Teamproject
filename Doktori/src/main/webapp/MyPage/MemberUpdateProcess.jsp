<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    int result=0;
    String id= request.getParameter("id");
    String pass= request.getParameter("password");
    String nickname = request.getParameter("nickname");
	MemberDTO dto = new MemberDTO();    
	dto.setId(id);
	dto.setPass(pass);
	dto.setNickname(nickname);
	MemberDAO dao = new MemberDAO();
	
	result= dao.updateMember(dto);
	if(result == 0){
		JSFunction.alertLocation("회원 정보가 수정되었습니다.", "Mypage.jsp", out);
		
	}else{
		JSFunction.alertBack(" 회원 정보 수정 중 오류발생.", out);
	}
    dao.close();
    %>
<!DOCTYPE html>
