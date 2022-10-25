<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO"%>
<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Include/SubHeader.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    String sessionId = session.getAttribute("UserId").toString();
    
    String num = request.getParameter("num");
    String pass = request.getParameter("pass");
    
    SuggestDAO dao = new SuggestDAO();
    SuggestDTO dto = new SuggestDTO();
    dto.setNum(num);
    dto.setPass(pass);
    int check = dao.checkPass(dto);
    dao.close();

    // 비밀번호가 없는 게시글은 바로 해당글 조회
    if(dto.getPass()==null){
    	response.sendRedirect("SuggestView.jsp?num=" + dto.getNum());
    	
    }else{
    	// 작성자가 본인이거나 아닐 때
    	if(dto.getId().equals(sessionId)){
    	}else {
    	JSFunction.alertBack("비밀글은 본인과 관리자만 열람할 수 있습니다.", out);
    	}
    }
    
%>    
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<script type="text/javascript">
function validateForm(form) {
	if (form.pass.value == ""){
		alert("비밀번호를 입력하세요.");
		form.pass.focus();
		return false;
	}
}
</script>
<div style="width: 1400px; margin: 0 auto; text-align: center;">
	<form name="writeFrm" method="post" action="SuggestCheckProcess.jsp" onsubmit="return validateForm(this);">
		<input type="hidden" name="num" value="<%=num %>"/>
		<label>
			비밀번호 : <input type="password" name="pass" style="width:100px;" />
		</label>
		<div style="margin: 15px 0">
			<button class="default_btn" type="submit" action="SuggestCheckProcess.jsp">확인</button>
			<button class="default_btn" type="reset">다시입력</button>
			<button class="default_btn" type="button" onclick="location.href='SuggestList.jsp';">목록 바로가기</button>
		</div>
	</form>
</div>
<%@ include file="../Include/Footer.jsp" %>