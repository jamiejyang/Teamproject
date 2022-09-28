<%@ include file="../Include/Subheader.jsp" %>
<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    String num = request.getParameter("num");
    String pass = request.getParameter("pass");
    
    SuggestDAO dao = new SuggestDAO();
    SuggestDTO dto = new SuggestDTO();
    dto.setNum(num);
    dto.setPass(pass);
    
    //비밀번호가 없는 게시글은 바로 해당글 조회
    int check = dao.checkPass(dto);
    if(dto.getPass()==null){
    	response.sendRedirect("SuggestView.jsp?num=" + dto.getNum());
    }
%>    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
function validateForm(form) {
	if (form.pass.value == ""){
		alert("비밀번호를 입력하세요.");
		form.pass.focus();
		return false;
	}
}
</script>
</head>
<body>
<h3>비밀번호 검증(Pass)</h3>
<form name="writeFrm" method="post" action="SuggestCheckProcess.jsp" onsubmit=
"return validateForm(this);">
<input type="hidden" name="num" value="<%=num %>"/>
<table border="1" width="90%">
<tr>
<td>비밀번호</td>
<td>
<input type="password" name="pass" style="width:100px;" />
</td>
</tr>
<tr>
<td colspan="2" align="center">
<button type="submit" action="SuggestCheckProcess.jsp">검증하기</button>
<button type="reset">RESET</button>
<button type="button" onclick="location.href='SuggestList.jsp';">
목록 바로가기
</button>
</td>
</tr>
</table>
</form>
</body>
</html>
<%@ include file="../Include/Footer.jsp" %>