<%@page import="dao.NoticeDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.NoticeDTO"%>
<%
String num = request.getParameter("num");
String UserId = null;
NoticeDAO dao = new NoticeDAO();
dao.updateReadCount(num);
NoticeDTO dto = dao.selectView(num);
dao.close();
if (session.getAttribute("UserId") == null) {
	session.setAttribute("UserId", "guest");
}
%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<script>
	function deletePost() {
		var confirmed = confirm("삭제하시겠습니까?");
		if (confirmed) {
			var form = document.writeFrm;
			form.method = "post";
			form.action = "NoticeDeleteProcess.jsp";
			form.submit();
		}
	}
</script>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<title>공지사항 상세보기</title>
</head>
<body>
<%@ include file="../Include/SubHeader.jsp" %>
	<div style="width: ; height: 50%;">
		<form name="writeFrm">
			<input type="hidden" name="num" value="<%=dto.getNum()%>">
			<input type="hidden" name="oldFile" value="<%=dto.getOfile()%>">
			<input type="hidden" name="newFile" value="<%=dto.getSfile()%>">
			
			<table>
				<tr>
					<th style="width: 15%">제목</th>
					<td><%=dto.getTitle()%></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=dto.getWritedate()%></td>
				</tr>
				<tr>
					<th>도서관</th>
					<td><%=dto.getLibname()%></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><%=dto.getReadcount()%></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td> 
					<a href="NoticeDownload.jsp?oName=<%=URLEncoder.encode(dto.getOfile(), "UTF-8")%>&sName=<%=URLEncoder.encode(dto.getSfile(), "UTF-8")%>"><%=dto.getOfile() %></a>
					</td>
				</tr>
				<tr style="width: 50%">
					<td colspan="2"><img alt="" style="height: auto; width: 100%"
						src="../Uploads/<%=dto.getSfile()%>"> <br><%=dto.getContent()%></td>
				</tr>

			</table>
			<button type="button" onclick="location.href='NoticeList.jsp';">목록</button>
			<%
			if (session.getAttribute("UserId").equals("admin")) {
			%>
			<button type="button" onclick="deletePost();">삭제하기</button>

			<button type="button"
				onclick="location.href='NoticeEdit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
			<%
			}
			%>
		
	</form>
	</div>
	<%@ include file="../Include/Footer.jsp"%>
</body>
</html>