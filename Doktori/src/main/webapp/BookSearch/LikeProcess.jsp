<%@page import="dto.LikesDTO"%>
<%@page import="dao.LikesDAO"%>
<%@page import="dao.LibDAO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
LikesDAO dao = new LikesDAO();
LikesDTO dto = new LikesDTO();
int result = 0;

if (session.getAttribute("UserId") == null || session.getAttribute("UserId").equals("guest")) {
	JSFunction.alertLocation("로그인 후 이용 가능합니다", "../Login/LoginForm.jsp", out);
} else if (session.getAttribute("UserId").equals("admin")) {
	JSFunction.alertBack("관리자는 관심도서 앙대..", out);
} else {
	// 	비회원이나 관리자가 아니면
	String id = session.getAttribute("UserId").toString();
	String booknum = request.getParameter("booknum");
	System.out.println(booknum);
	

	result = dao.LikeSearch(id, booknum);
	if (result == 1) {
		JSFunction.alertBack("이미 등록된 도서 입니다.", out);
	} else {
		// 		검색 후 없는 도서면 insert
		dto.setBooknum(booknum);
		dto.setId(id);
		result = dao.insertLike(dto);
		dao.close();
		if (result == 1) {
	JSFunction.alertLocation("관심도서에 등록 되었습니다.", "BookList.jsp", out);
		} else {
	JSFunction.alertBack("관심도서 등록 실패", out);
		}
	}

}
%>
<!DOCTYPE html>