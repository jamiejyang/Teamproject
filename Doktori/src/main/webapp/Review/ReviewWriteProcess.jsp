<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="utils.JSFunction"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String title = request.getParameter("title");
String content = request.getParameter("content");
String fileName = request.getParameter("fileName");
System.out.println(title);
System.out.println(content);
System.out.println(fileName);


ReviewDTO dto = new ReviewDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setFiles(fileName);
//외래키로 연결되어있으므로 id가 빈값이면 insert시 제약조건 위배 
dto.setId(session.getAttribute("UserId").toString());

//db에 dto 저장 p.314
ReviewDAO dao = new ReviewDAO(application);
int iResult =0;
for(int i=1; i<=100; i++){
	dto.setTitle(title+ "-" +i);
	iResult = dao.insertWrite(dto);
};
dao.close();

if (iResult == 1) {
	response.sendRedirect("ReviewList.jsp");
	
} else {
	JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>