<%@ include file="../Include/SubHeader.jsp" %>
<%@page import="utils.JSFunction"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
if(session.getAttribute("UserId")==null || session.getAttribute("UserId").equals("guest")){
	JSFunction.alertLocation("로그인이 필요한 페이지입니다.", "../Login/LoginForm.jsp", out);
}
String id ="";
if(session.getAttribute("UserId")!=null){
id = session.getAttribute("UserId").toString();
}
MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.selectMember(id);
dao.close();
%>
<script type="text/javascript">
	function updateMember() {
		var confirmed = confirm("정보를 수정 하시겠습니까?");
		if (confirmed) {
			var form = document.updateFrm;
			form.method = "get";
			form.action = "MemberUpdateProcess.jsp";
			form.submit();
		}
	}
</script>
<div class="mypageArea">
	<div class="list_area">
		<ul class="my_list">
			<li class="my_list__item">
				<a href="">내 서재</a>
			</li>
			<li class="my_list__item">
				<a href="">관심 도서</a>
			</li>
			<li class="my_list__item">
				<a href="">예약 도서</a>
			</li>
			<li class="my_list__item">
				<a href="">내 정보</a>
			</li>
		</ul>
	</div>
	<form name="updateFrm">
	<div class="info_area">
		<span class="txt"><%=dto.getName() %>님 반갑습니다.</span>
		<button class="edit_button default_btn"  type="button" onclick="updateMember();" >수정 완료</button>
		<div class="my_img">
			<img src="../Images/default.png">
		</div>
		<div class="my_info">
			<label>아이디 <%=dto.getId() %>
				<input type="hidden" name="id" value="<%=dto.getId()%>">
				
			</label>
			<label>닉네임 
				<input type="text" name="nickname" value="<%=dto.getNickname()%>">
			</label>
			<label>비밀번호
				<input type="text" name="password" value="<%=dto.getPass()%>">
			</label>
		</div>
	</div>
		</form>
</div>
	
<%@ include file="../Include/Footer.jsp" %>