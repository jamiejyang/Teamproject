<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 추가하기</title>

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
</head>
<body>
	<form name="writeFrm" method="post" action="WriteProcess.jsp"
		onsubmit="return validateForm(this);">
		<table border="1" width="90%">
			<tr>
				<td>질문</td>
				<td><textarea name="title" style="width: 90%; height: 200px"></textarea></td>
			</tr>
			<tr>
				<td>답변</td>
				<td><textarea name="content" style="width: 90%; height: 200px;"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit" class="btn btn-warning">작성 완료</button>
					<button type="reset" class="btn btn-secondary">다시 입력</button>
					<button type="button" class="btn btn-info" onclick="location.href='Faq.jsp';">돌아가기</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>