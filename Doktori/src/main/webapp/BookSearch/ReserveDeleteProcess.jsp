<%@page import="dao.ReserveDAO"%>
<%@page import="dao.LikesDAO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

String booknum = request.getParameter("booknum1");

// String booknum[] =request.getParameterValues("booknum");
String id = session.getAttribute("UserId").toString();

// System.out.println(booknum);
int result = 0;
ReserveDAO dao = new ReserveDAO();
result = dao.deleteReserve(id, booknum);
dao.close();

if (result == 1) {
	JSFunction.alertBack("도서 예약이 취소되었습니다.", out);
// 	JSFunction.alertLocation("관심도서에서 삭제 되었습니다.", "../MyPage/MyLike.jsp", out);
} else {
	JSFunction.alertBack("반납 실패.", out);
}
%>

<!DOCTYPE html>
