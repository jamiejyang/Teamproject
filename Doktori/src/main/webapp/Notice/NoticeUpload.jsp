<%@ include file="../Include/SubHeader.jsp" %>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	if(!session.getAttribute("UserId").equals("admin")){
		JSFunction.alertLocation("관리자만 이용 가능합니다.", "../Login/LoginForm.jsp", out);
	}
	%>
<!DOCTYPE html>

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
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<body>
	<span style="color: red">${errorMessage }</span>

	<form name="fileForm" method="post" enctype="multipart/form-data"
		onsubmit="return validateForm(this);" action="NoticeUploadProcess.jsp">
	<div style="width: 1400px; margin: 0 auto;">
		<table>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="name" value="" /></td>
			</tr>
			<tr>
			<th>제목</th>
			<td> <input type="text" name="title" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" style="width: 90%; height: 200px;"></textarea></td>
			</tr>
			
			<tr>
			<th>첨부파일</th>
			<td><input type="file" name="attachedFile" /></td>
			</tr>
			<tr>
				<th>도서관</th>
				<td><select name="libname">
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
				</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="전송하기">
					<input type="reset" value="다시 입력">
					<input type="button" value="목록 보기" onclick="location.href='NoticeList.jsp';">
				</td>
			</tr>
		</table>
		</div>
	</form>
</body>
</html>
	<%@ include file="../Include/Footer.jsp"%>