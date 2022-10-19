<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.FaqDTO"%>
<%@page import="dao.FaqDAO"%>
<%@ include file="../Include/SubHeader.jsp"%>
<%
String num = request.getParameter("num");
FaqDAO dao = new FaqDAO(application);
FaqDTO dto = dao.selectView(num);
%>
<script type="text/javascript">
	function validateForm(form) {
		if (form.title.value == "") {
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if (form.content.value == "") {
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
	}
</script>
<style>
	.ipt {width: 99%;}
	.tarea {width: 100%;}
</style>
<div class="edit_wrap" style="max-width: 1400px; width: 100%; margin: 0 auto;">
	<form name="writeFrm" method="post" action="EditProcess.jsp" onsubmit="return validateForm(this);">
		<input type="hidden" name="num" value="<%= dto.getNum() %>" />
		<table border="1" width="100%">
			<tr>
				<td width="10%">제목</td>
				<td>
					<input class="ipt" type="text" name="title" value="<%= dto.getQu() %>" />
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="content" class="tarea"><%= dto.getAn() %></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">수정 완료</button>
					<button type="reset">다시 입력</button>
					<button type="button" onclick="location.href='Faq.jsp';">돌아가기</button>
				</td>
			</tr>
		</table>
	</form>
</div>

<%@ include file="../Include/Footer.jsp"%>