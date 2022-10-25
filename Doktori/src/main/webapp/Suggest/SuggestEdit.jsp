<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO"%>
<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../Include/SubHeader.jsp" %>
<%
String num = request.getParameter("num");
SuggestDAO dao = new SuggestDAO(application);
SuggestDTO dto = dao.selectView(num);
String sessionId = session.getAttribute("UserId").toString();
if (!sessionId.equals(dto.getId())) {
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
	return;
}
dao.close();
%>
<script type="text/javascript">
function validateForm(form) {
	if (form.title.value == ""){
		alert("제목을 입력하세요.");
		form.title.focus();
		return false;
	}
	if (form.content.value == ""){
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<div style="width: 1400px; margin: 0 auto;">
    <form name="writeFrm" method="post" enctype="multipart/form-data" action="SuggestEditProcess.jsp"
		onsubmit="return validateForm(this);">
		<input type="hidden" name="num" value="<%=dto.getNum()%>" />
		<input type="hidden" name="oldfile" value="<%=dto.getOfile()%>" />
		<input type="hidden" name="newfile" value="<%=dto.getSfile()%>" />
		<table>
			<tr>
				<th>제목</th>
				<td style="width: 100%;"><input style="width: 100%;" type="text" name="title" value="<%=dto.getTitle()%>" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea style="width: 100%; height: 200px;" name="content"><%=dto.getContent()%></textarea></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3"><img alt=""
					style="height: auto; width: 25%; display: block;"
					src="../Uploads/<%=dto.getSfile()%>">
					<button type="button"
					onclick="location.href='SuggestFileDeleteProcess.jsp?num=<%=dto.getNum()%>'">파일삭제하기</button>
				<%=dto.getOfile()%><br>
					<input type="file" name="attachedFile" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button class="default_btn" type="submit">작성 완료</button>
					<button class="default_btn" type="reset">다시 입력</button>
					<button class="default_btn" type="button" onclick="location.href='SuggestList.jsp';">
						목록 보기</button>
				</td>
			</tr>
		</table>
	</form>
</div>
<%@ include file="../Include/Footer.jsp" %>
