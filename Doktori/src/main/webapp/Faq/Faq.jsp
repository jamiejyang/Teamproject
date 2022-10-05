<%@page import="dto.FaqDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.FaqDAO"%>
<%@ include file="../Include/SubHeader.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	FaqDAO dao = new FaqDAO(application);
	List<FaqDTO> faqLists = dao.selectFaq();
	
	if (session.getAttribute("UserId") == null) {
		session.setAttribute("UserId", "guest");
	}
%>
<div class="faqArea">
	<ul class="faq_list">
	<% 
		for(FaqDTO dto : faqLists) {
	%>
	<li class="faq_list__item">
		<input type="hidden" name="num" value="<%= dto.getNum() %>" />
		<div class="faq_title"><%= dto.getQu() %></div>
		<div class="faq_content"><%= dto.getAn() %></div>
	</li>
	<% 
		}
	%>
	</ul>
	<%
	if (session.getAttribute("UserId").equals("admin")) {
	%>
		<button type="button" class="write_button" onclick="location.href='FaqWrite.jsp';">글쓰기</button>
	<%
	} 
	%>
</div>
<script>
	$('.faq_list__item').click(function() {
		$(this).children('.faq_content').slideToggle();
	})
</script>


<%@ include file="../Include/Footer.jsp" %>