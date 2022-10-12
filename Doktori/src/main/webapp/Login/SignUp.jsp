<%@ include file="../Include/Subheader.jsp" %>
<%@page import="java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="dao.MemberDAO"%>
	<%@ page import="dto.MemberDTO"%>
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
				form.user_name.focus();
				alert("이름을 입력하세요.");
				return false;
			}
			if (!form.user_nickname.value) {
				alert("닉네임을 입력하세요.");
				form.user_nickname.focus();
				return false;
			}
			if (!form.user_id.value) {
				alert("아이디를 입력하세요.");
				form.user_id.focus();
				return false;
			}
			if (form.user_pw.value == "") {
				alert("패스워드를 입력하세요.");
				form.user_pw.focus();
				return false;
			}
			if (form.user_pw.value.length < 4 || form.user_pw.value.length > 10){
				alert("비밀번호는 4자 이상, 10자 이하로 설정해주세요.");
				form.user_pw.focus();
				return false;
			}
		}

//         function id(){
//         	var id = document.getElementById('user_id').value;
        	
//         	  //비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
//         	  var idCheck = /^(?=.*[!@#$%^*+=-]).{4,10}$/;

//         	  if (idCheck.test(id.value)) {
//         	    alert("아이디는 특수문자 x");
//         	    return false;
//         	  };
//         }

// function checkIDs{
// 	    var id = document.getElementById('user_id').value;
// 		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
//     if(special_pattern.test(id) == true){
//     alert('특수문자가 입력되었습니다.');
//     return false;
//   }
// }
		
     	function checkID(){
     		var checkID = document.getElementById('user_id').value;
     		window.open("SignUpCheckID.jsp?user_id=" + checkID, "checkid", "width=400, height=350");
     	} 
     	
		
	</script>
	<form action="SignUpProcess.jsp" method="post" name="regForm"
		onsubmit="return validateForm(this);">
		이름 : <input type="text" name="user_name" /><br /> 
		닉네임 : <input type="text" name="user_nickname" /><br /> 
		아이디 : <input type="text" name="user_id" id="user_id" />
<!-- 		<input type="hidden" name="checkid" value=0> -->
		<input type="button" value="중복확인" onClick="checkID()"/>
		<br />
		패스워드 : <input type="password" name="user_pw" /><br />
		
		<button type="submit" class="btn btn-outline-success" value="회원가입하기">회원가입하기</button>
	</form>
	</div>
	</body>
</html>
<%@ include file="../Include/Footer.jsp" %>