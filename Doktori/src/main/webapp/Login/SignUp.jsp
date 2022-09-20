<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>SignUp</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
</head>
<body>
		<div align="center">
	<span style="color: red; font-size: 1.2em;"> <%=request.getAttribute("SignUpErrMsg") == null ? "" : request.getAttribute("SignUpErrMsg")%>
	</span>

	<script>
		function validateForm(form) {
			if (!form.user_name.value) {
				alert("이름을 입력하세요.");
				return false;
			}
			if (!form.user_nickname.value) {
				alert("닉네임을 입력하세요.");
				return false;
			}
			if (!form.user_id.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if (form.user_pw.value == "") {
				alert("패스워드를 입력하세요.");
				return false;
			}
		}
	</script>
	<form action="RegisterProcess.jsp" method="post" name="registerFrm"
		onsubmit="return validateForm(this);">
		이름 : <input type="text" name="user_name" /><br /> 
		닉네임 : <input type="text" name="user_nickname" /><br /> 
		아이디 : <input type="text" name="user_id" /><br /> 
		패스워드 : <input type="password" name="user_pw" /><br /> 

		<button type="submit" class="btn btn-outline-success" value="회원가입하기">회원가입하기</button>
	</form>
	</div>
	</body>
</html>