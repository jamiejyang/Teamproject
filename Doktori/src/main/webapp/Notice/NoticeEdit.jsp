<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDAO"%>
<%@ page import="dto.NoticeDTO"%>

<%
String num = request.getParameter("num");
NoticeDAO dao = new NoticeDAO(application);
NoticeDTO dto = dao.selectView(num);
String sessionId = session.getAttribute("UserId").toString();
if (!sessionId.equals("admin")) {
	JSFunction.alertBack("관리자만 수정이 가능합니다", out);
	return;
}
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function validateForm(form) {
		if (form.title.value == "") {
			alert("제목을 입력해주세요.");
			form.title.focus();
			return false;
		}
		if (form.content.value == "") {
			alert("내용을 입력해주세요.");
			form.content.focus();
			return false;
		}
	
	}
</script>
<title>공지사항 수정</title>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<body>


	<div align="center">
		<form name="fileForm" method="post" enctype="multipart/form-data"
			onsubmit="return validateForm(this);" action="NoticeEditProcess.jsp">
			<input type="hidden" name="num" value="<%=dto.getNum()%>" /> <input
				type="hidden" name="oldfile" value="<%=dto.getOfile()%>"> <input
				type="hidden" name="newfile" value="<%=dto.getSfile()%>">

			<table>
				<tr>
					<th>작성자</th>
					<td><%=dto.getName()%></td>
				</tr>
				<tr>
					<th>도서관</th>
					<td><%=dto.getmanagecode()%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title"
						value="<%=dto.getTitle()%>" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea style="width: 100%; height: 100px"
							name="content"></textarea></td>
				</tr>

				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="attachedFile" /></td>
				</tr>
			</table>
			<div>
				<button type="submit">작성완료</button>
				<button type="reset">다시 입력</button>
				<button type="button" onclick="location.href='NoticeList.jsp'">목록가기</button>
			</div>
		</form>
		<form action="">
			<div>
				<%=dto.getOfile()%><button type="button"
					onclick="location.href='NoticeFileDeleteProcess.jsp?num=<%=dto.getNum()%>'">삭제하기</button>
			</div>
		</form>
	</div>
</body>
</html>
<%@ include file="../Include/Footer.jsp"%>