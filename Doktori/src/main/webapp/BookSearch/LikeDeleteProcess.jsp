<%@page import="dao.LikesDAO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String booknum = request.getParameter("booknum");
String id = session.getAttribute("UserId").toString();
int result = 0;
LikesDAO dao = new LikesDAO();
result = dao.deleteLike(id, booknum);
dao.close();

if (result == 1) {
	JSFunction.alertLocation("관심도서에서 삭제 되었습니다.", "여기가 돌아갈 곳 !", out);
} else {
	JSFunction.alertBack("삭제 실패.", out);
}
%>

<!DOCTYPE html>
