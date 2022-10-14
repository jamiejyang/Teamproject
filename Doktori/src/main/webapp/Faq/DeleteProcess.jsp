<%@page import="utils.JSFunction"%>
<%@page import="dao.FaqDAO"%>
<%@page import="dto.FaqDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String num = request.getParameter("num");
FaqDTO dto = new FaqDTO();
FaqDAO dao = new FaqDAO(application);
dto = dao.selectView(num);

int delResult = 0;
dto.setNum(num);
delResult = dao.deletePost(dto);

dao.close();

if (delResult == 1) {
	JSFunction.alertLocation("삭제되었습니다.", "Faq.jsp", out);
} else {
	JSFunction.alertBack("삭제에 실패했습니다", out);
}
%>