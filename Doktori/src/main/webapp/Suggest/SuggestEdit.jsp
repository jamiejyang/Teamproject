<%@ include file="../Include/Subheader.jsp" %>
<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO"%>
<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%
String num = request.getParameter("num");
SuggestDAO dao = new SuggestDAO(application);
SuggestDTO dto = dao.selectView(num);
String sessionId = session.getAttribute("UserId").toString();
if (!sessionId.equals(dto.getId())) {
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
	return;
}
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<!-- <link -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" -->
<!-- 	rel="stylesheet" -->
<!-- 	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" -->
<!-- 	crossorigin="anonymous"> -->
<meta charset="UTF-8">
<script type="text/javascript">
function validateForm(form {
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
</head>
<body>

	<jsp:include page="./SuggestLink.jsp" />
	
	<h2>건의사항 게시판 - 수정하기(Edit)</h2>
<!--     <form name="writeFrm" method="post" enctype="multipart/form-data" action="SuggestEditProcess.jsp" -->
<!-- 		onsubmit="return validateForm(this);"> -->
	<form name="writeFrm" method="post" action="SuggestEditProcess.jsp"
		onsubmit="return validateForm(this);">
		<input type="hidden" name="num" value="<%=dto.getNum()%>" />
		<input type="hidden" name="oldfile" value="<%=dto.getUfile()%>" />
		<table style="width: 100%;">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" style="width: 90%;" value="<%=dto.getTitle()%>" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" style="width: 90%; height: 100px;"><%=dto.getContent()%></textarea></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td height="100">
				<img alt="" style="height: auto; width: 100%" src="../Uploads/<%=dto.getUfile()%>">
				<input type="file" name="attachedFile" />
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input name="pass" type="password" style="width: 10%;" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">작성 완료</button>
					<button type="reset">다시 입력</button>
					<button type="button" onclick="location.href='SuggestList.jsp';">
						목록 보기</button>
				</td>
			</tr>
		</table>
		</form>
</body>
</html>
<%@ include file="../Include/Footer.jsp" %>