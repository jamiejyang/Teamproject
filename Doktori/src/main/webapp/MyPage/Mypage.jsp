<%@ include file="../Include/SubHeader.jsp" %>
<%@page import="utils.JSFunction"%>
<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>

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
	function deleteMember() {
		var confirmed = confirm("탈퇴 하시겠습니까?");
		if (confirmed) {
			var form = document.delFrm;
			form.method = "get";
			form.action = "MemberDeleteProcess.jsp";
			form.submit();
		}
	}
</script>
<div class="mypageArea">
	<div class="list_area">
		<ul class="my_list">
			<li class="my_list__item">
				<a href="MyLike.jsp">관심 도서</a>
			</li>
			<li class="my_list__item">
				<a href="MyReserve.jsp">예약 도서</a>
			</li>
			<li class="my_list__item">
				<a href="Mypage.jsp">내 정보</a>
			</li>
		</ul>
	</div>
	<form name="delFrm">
	<div class="info_area">
		<span class="txt"><%=dto.getName() %>님 반갑습니다.</span>
		<button class="edit_button" type="button" onclick="location.href='UpdateMember.jsp'">내정보수정</button>
		<div class="my_img">
			<img src="../Images/default.png" style=" height: auto;">
		</div>
		<div class="my_info">
			<label>아이디 <%=dto.getId() %>
				<input type="hidden" name="id" value="<%=dto.getId()%>">
				
			</label>
			<label>닉네임 <%=dto. getNickname() %>
				<input type="hidden" name="nickname" value="<%=dto.getNickname()%>">
			</label>
			<label>비밀번호 <%= dto.getPass() %>
				<input type="hidden" name="password" value="<%=dto.getPass()%>">
			</label>
		</div>
	</div >
		<button class="edit_button" type="submit" onclick="deleteMember();" >회원탈퇴</button>
		</form>
</div>
	
<%@ include file="../Include/Footer.jsp" %>