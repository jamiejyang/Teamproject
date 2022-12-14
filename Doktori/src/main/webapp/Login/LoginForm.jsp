<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- <link -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" -->
<!-- 	rel="stylesheet" -->
<!-- 	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" -->
<!-- 	crossorigin="anonymous"> -->
<%@ include file="../Include/SubHeader.jsp"%>
	<div class="login" align="center">
		<span style="color: red; font-size: 1.2em;"> <%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg")%>
		</span>
		<%
		if (session.getAttribute("UserId") == null || session.getAttribute("UserId").equals("guest")) {
		%>
		<script>
			function validateForm(form) {
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
		<form action="LoginProcess.jsp" method="post" name="loginFrm"
			onsubmit="return validateForm(this);" style="width: 215px;">
			<label>
				아이디 : <input type="text" name="user_id" style="margin-left: 15px;"/>
			</label>
			<br />
			<label>
				패스워드 : <input type="password" name="user_pw" />
			</label>
			<br />
			<button class="default_btn" type="submit" style="margin: 10px auto 0; display: block;" class="test" value="로그인하기" >로그인하기</button>
		</form>
		<%
		} else {
		%>
		<%=session.getAttribute("UserName")%>
		회원님, 로그인하셨습니다. <br /> <a href="Logout.jsp">[로그아웃]</a>
		<%
		}
		%>
	</div>
<%@ include file="../Include/Footer.jsp" %>
