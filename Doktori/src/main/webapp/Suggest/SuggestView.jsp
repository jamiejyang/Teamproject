<%@ include file="../Include/Subheader.jsp"%>
<%@ page import="dao.SuggestDAO"%>
<%@ page import="dto.SuggestDTO"%>
<%-- <%@ page import="dao.Comment2DAO"%> --%>
<%@ page import="dto.Comment2DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String sessionId = session.getAttribute("UserId").toString();
String num = request.getParameter("num");

SuggestDAO dao = new SuggestDAO(application);
dao.updateReadCount(num);
SuggestDTO dto = dao.selectView(num);
dao.close();

// Comment2DAO = new Comment2DAO();
// List<Comment2DTO> commentboardLists = dao.selectCommentListPage;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function deletePost() {
		var confirmed = confirm("정말로 삭제하겠습니까?");
		if (confirmed) {
			var form = document.writeFrm;
			form.method = "post";
			form.action = "SuggestDeleteProcess.jsp";
			form.submit();
		}
	}
</script>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<body>

	<jsp:include page="./SuggestLink.jsp" />

	<h2>건의사항 게시판 - 상세보기(view)</h2>
	<form name="writeFrm">
		<input type="hidden" name="num" value="<%=num%>" />
		<table>
			<tr>
				<th>번호</th>
				<td><%=dto.getNum()%></td>
				<th>작성자</th>
				<td><%=dto.getId()%></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=dto.getWritedate()%></td>
				<th>조회수</th>
				<td><%=dto.getReadcount()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<th>내용</th>

				<%--          <td colspan="3" height="100"><%= dto.getContent().replace("\r\n", "<br/>") %> --%>
				<td colspan="3" height="100"><%=dto.getContent()%></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3" height="100"><img alt=""
					style="height: auto; width: 100%"
					src="../Uploads/<%=dto.getFiles()%>"> <a></a></td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<%
					if (session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())) {
					%>
					<button type="button"
						onclick="location.href='SuggestEdit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
					<button type="button" onclick="deletePost();">삭제하기</button> <%
 } else if (session.getAttribute("UserId").equals("admin")) {
 %>
					<button type="button" onclick="deletePost();">삭제하기</button> <%
 }
 %>
					<button type="button" onclick="location.href='SuggestList.jsp';">목록
						보기</button>
								</table>
								</form> 
<%
 if (sessionId.equals("admin")) {
 %>
 
<!--  댓글 리스트 -->
<%-- 		<% --%>
<!-- // 		if (commentboardLists.isEmpty()) { -->
<%-- 		%> --%>
<!-- 		<tr> -->
<!-- 			<td colspan="5" align="center">등록된 댓글이 없습니다.</td> -->
<!-- 		</tr> -->
<%-- 		<% --%>
<!-- // 		} else { -->
<!-- // 		int virtualNum = 0; -->
<!-- // 		int countNum = 0; -->
<!-- // 		for (Comment2DTO dto : commentboardLists) { -->
<!-- // 			// 			virtualNum = totalCount--; -->
<!-- // 			virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++); -->
<%-- 		%> --%>
 
 
<!--  댓글작성 -->
	<form name="writeFrm" method="post" action="SuggestCommentProcess.jsp">
		<table border="1" width="90%">
			<tr>
				<th>댓글</th>
				<td><textarea name="cmtcontent" style="width: 90%; height: 100px;">
</textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">댓글 작성</button>
				</td>
			</tr>
					<%
					}
					%>
							</table>
							</form>
<!-- 				</td> -->
<!-- 		</table> -->
<!-- 	</form> -->
</body>
</html>
<%@ include file="../Include/Footer.jsp"%>