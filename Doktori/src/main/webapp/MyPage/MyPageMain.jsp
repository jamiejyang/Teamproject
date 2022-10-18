<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = session.getAttribute("UserId").toString();
MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.selectMember(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doktori 마이 페이지</title>
</head>
<body>
	<%@ include file="../Include/SubHeader.jsp"%>
	<div>
	<div>
		<%=dto.getName() %>님 반갑습니다.  <a href="MyPageUpdate.jsp" >내 정보 수정</a>
	</div>
		<div style="width: 30%;">
			<img alt="" src="../Uploads/tan.png" >
		</div>
		<div>
<!-- 			여기다 정보 넣기 -->
		</div>
	</div>
	<%@ include file="../Include/Footer.jsp"%>
</body>
</html>