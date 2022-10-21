<%@ include file="../Include/SubHeader.jsp" %>
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



String libname ="";
switch (dto.getmanagecode()) {
case "MA" : libname="강남도서관";
	break;
case "MB" : libname="강동도서관";
	break;
case "MC" : libname="강서도서관";
	break;
case "MD" : libname="개포도서관";
	break;
case "ME" : libname="고덕평생학습관";
	break;
case "MF" : libname="고척도서관";
	break;
case "MG" : libname="구로도서관";
	break;
case "MH" : libname="남산도서관";
	break;
case "MV" : libname="노원평생학습관";
	break;
case "MJ" : libname="도봉도서관";
	break;
case "MK" : libname="동대문도서관";
	break;
case "ML" : libname="동작도서관";
	break;
case "MX" : libname="마포평생아현분관";
	break;
case "MM" : libname="마포평생학습관";
	break;
case "MP" : libname="서대문도서관";
	break;
case "MW" : libname="송파도서관";
	break;
case "MN" : libname="양천도서관";
	break;
case "MQ" : libname="어린이도서관";
	break;
case "MR" : libname="영등포평생학습관";
	break;
case "MS" : libname="용산도서관";
	break;
case "MT" : libname="정독도서괸";
	break;
case "MU" : libname="종로도서관";
	break;
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

	<div style="width: ; height: 50%;" class="inner">
		<form name="writeFrm">
			<input type="hidden" name="num" value="<%=dto.getNum()%>">
			<input type="hidden" name="oldFile" value="<%=dto.getOfile()%>">
			<input type="hidden" name="newFile" value="<%=dto.getSfile()%>">
			
			<table >
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
					<td><%=libname%></td>
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
				<%if(!dto.getSfile().equals(" ")) {
				%>
				<tr style="width: 50%">
					<td colspan="2" align="center"><img alt="" style="height: auto; width: 40%; margin: 30px; padding-left: 200px; padding-right: 200px;" 
						src="../Uploads/<%=dto.getSfile()%>" >
						</td>
				</tr>
				<%} %>
						<tr>
						<td colspan="2"><%=dto.getContent().replace("\r\n", "<br/>")%></td>
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