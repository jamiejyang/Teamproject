<%@page import="dao.ReserveDAO"%>
<%@page import="dto.LikesDTO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if(session.getAttribute("UserId")==null||session.getAttribute("UserId").equals("guest")){
	JSFunction.alertLocation("로그인 후 이용 가능합니다", "../Login/LoginForm.jsp", out);
}else if (session.getAttribute("UserId").equals("admin")) {
	JSFunction.alertBack("관리자는 관심도서 앙대..", out);
} else{
	ReserveDAO dao = new ReserveDAO();
	LikesDTO dto = new LikesDTO();
	int result = 0;
	String id = session.getAttribute("UserId").toString();
	String booknum = request.getParameter("booknum");
	
	result= dao.ReserveSearch(booknum);
	if(result !=0 ){
		dao.close();
		JSFunction.alertBack("이미 예약된 도서 입니다. ", out);
	}else{
		dto.setId(id);
		dto.setBooknum(booknum);
		result= dao.insertReserve(dto);
		dao.close();
		if(result == 1){
			JSFunction.alertBack("해당 도서가 예약 되었습니다.", out);
		} else {
			JSFunction.alertBack("예약 실패.", out);
		}
	}
			
}
%>

<!DOCTYPE html>
