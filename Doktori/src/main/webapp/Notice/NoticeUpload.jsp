<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	if(!session.getAttribute("UserId").equals("admin")){
		JSFunction.alertLocation("관리자만 이용 가능합니다.", "../Login/LoginForm.jsp", out);
	}
	%>
<!DOCTYPE html>
<%@ include file="../Include/SubHeader.jsp" %>
<html>
<script>
	function validateForm(form) {
		if(form.name.value==""){
			alert("작성자를 입력하세요");
			form.name.focus();
			return false;
		}
		if(form.title.value==""){
			alert("제목를 입력하세요");
			form.title.focus();
		return false;
		}
</script>
<head>
<meta charset="UTF-8">
<title>공지 글</title>
</head>
<body>
	<h3>공지사항 글 쓰기</h3>
	<span style="color: red">${errorMessage }</span>

	<form name="fileForm" method="post" enctype="multipart/form-data"
		onsubmit="return validateForm(this);" action="NoticeUploadProcess.jsp">

		작성자 : <input type="text" name="name" value="" /><br /> 제목 : <input
			type="text" name="title" /><br /> 내용 :
		<textarea rows="20" cols="20" name="content"></textarea>
		<br> 첨부파일 : <input type="file" name="attachedFile" /><br />
		도서관코드: <select name="libname">
			<option value="MA">강남도서관</option>
			<option value="MB">강동도서관</option>
			<option value="MC">강서도서관</option>
			<option value="MD">개포도서관</option>
			<option value="ME">고덕평생학습관</option>
			<option value="MF">고척도서관</option>
			<option value="MG">구로도서관</option>
			<option value="MH">남산도서관</option>
			<option value="MV">노원평생학습관</option>
			<option value="MJ">도봉도서관</option>
			<option value="MK">동대문도서관</option>
			<option value="ML">동작도서관</option>
			<option value="MX">마포평생학습관아현분관</option>
			<option value="MM">마표평생학습관</option>
			<option value="MP">서대문도서관</option>
			<option value="MW">송파도서관</option>
			<option value="MN">양천도서관</option>
			<option value="MQ">어린이도서관</option>
			<option value="MR">영등포평생학습관</option>
			<option value="MS">용산도서관</option>
			<option value="MT">정독도서관</option>
			<option value="MU">종로도서관</option>
		</select> <br> <input type="submit" value="전송하기">
	</form>
</body>
</html>
	<%@ include file="../Include/Footer.jsp"%>