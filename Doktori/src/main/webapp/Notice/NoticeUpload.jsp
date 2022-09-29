<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<option value="강남도서관">강남도서관</option>
			<option value="강동도서관">강동도서관</option>
			<option value="강서도서관">강서도서관</option>
			<option value="개포도서관">개포도서관</option>
			<option value="고덕평생학습관">고덕평생학습관</option>
			<option value="고척도서관">고척도서관</option>
			<option value="구로도서관">구로도서관</option>
			<option value="남산도서관">남산도서관</option>
			<option value="노원평생학습관">노원평생학습관</option>
			<option value="도봉도서관">도봉도서관</option>
			<option value="동대문도서관">동대문도서관</option>
			<option value="동작도서관">동작도서관</option>
			<option value="마포평생학습관아현분관">마포평생학습관아현분관</option>
			<option value="마표평생학습관">마표평생학습관</option>
			<option value="서대문도서관">서대문도서관</option>
			<option value="송파도서관">송파도서관</option>
			<option value="양천도서관">양천도서관</option>
			<option value="어린이도서관">어린이도서관</option>
			<option value="영등포평생학습관">영등포평생학습관</option>
			<option value="용산도서관">용산도서관</option>
			<option value="정독도서관">정독도서관</option>
			<option value="종로도서관">종로도서관</option>
		</select> <br> <input type="submit" value="전송하기">
	</form>
</body>
</html>