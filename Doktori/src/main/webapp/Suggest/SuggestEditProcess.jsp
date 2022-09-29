<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO" %>
<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="./IsLoggedIn.jsp" %>
    <%
    
    String num = request.getParameter("num");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String files = request.getParameter("files");
    
    SuggestDTO dto = new SuggestDTO();
    dto.setNum(num);
    dto.setTitle(title);
    dto.setContent(content);
    dto.setFiles(files);
    
    SuggestDAO dao = new SuggestDAO(application);
    int affected = dao.updateEdit(dto);
    dao.close();
    
    if (affected == 1) {
    	response.sendRedirect("SuggestView.jsp?num=" + dto.getNum());
    }
    else {
    	JSFunction.alertBack("수정하기에 실패하였습니다.", out);
    }
    %>