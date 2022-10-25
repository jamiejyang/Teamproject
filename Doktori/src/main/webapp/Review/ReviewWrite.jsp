<%@ include file="../Include/SubHeader.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>

<%
String sessionId = session.getAttribute("UserId").toString();
ReviewDAO dao = new ReviewDAO();
ReviewDTO dto = new ReviewDTO();
dto.setId(session.getAttribute("UserId").toString());
dao.close();
%>

<script type="text/javascript">
function validateForm(form) {
	if (form.title.value == ""){
		alert("제목을 입력하세요.");
		form.title.focus();
		return false;
	}
	if (form.content.value == ""){
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>

<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<div style="width: 1400px; margin: 0 auto;">
	<form name="writeFrm" method="post" enctype="multipart/form-data" action="ReviewUploadProcess.jsp"
		onsubmit="return validateForm(this);">
		<table class="ft14">
			<tr>
				<th>작성자</th>
					<td><input type="text" name="id" value="<%=dto.getId()%>" disabled/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" style="width: 90%;" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" style="width: 90%; height: 200px;"></textarea></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="files" /></td>
			</tr>

			<% if(sessionId.equals("admin")) {%>
				<td colspan="2" align="left">
				<input type="checkbox" name="notice" value="-1" checked />상단 공지글로 고정 
			<% } else { %>
				<td colspan="2" align="left">
				<input type="hidden" name="notice" value="0" />
				<%}%>
			<tr>
				<td colspan="2" align="center">
					<button class="default_btn" type="submit">작성 완료</button>
					<button class="default_btn" type="reset">다시 입력</button>
					<button class="default_btn" type="button" onclick="location.href='ReviewList.jsp';">
						목록 보기</button>
				</td>
			</tr>
		</table>
	</form>
</div>
<%@ include file="../Include/Footer.jsp"%>