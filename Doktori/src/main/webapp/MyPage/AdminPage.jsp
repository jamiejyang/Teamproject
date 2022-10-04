<%@page import="utils.JSFunction"%>
<%@page import="utils.BoardPage"%>
<%@page import="dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if(session.getAttribute("UserId")==null|| !session.getAttribute("UserId").equals("admin")){
	JSFunction.alertLocation("관리자 전용 페이지 입니다.", "../Login/LoginForm.jsp", out);
}
	
MemberDAO dao = new MemberDAO();
Map<String, Object> param = new HashMap<String, Object>();

String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null) {
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
}
int totalCount = dao.MemberCount(param);
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int) Math.ceil((double) totalCount / pageSize);

int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);

List<MemberDTO> MemberLists = dao.MemberList(param);
dao.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function deleteMember() {
		var confirmed = confirm("해당 회원을 탈퇴 시키겠습니까?");
		if (confirmed) {
			var form = document.delFrm;
			form.method = "get";
			form.action = "MemberDeleteProcess.jsp";
			form.submit();
		}
	}
</script>
<title>관리자 페이지</title>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<body>
	<%@ include file="../Include/SubHeader.jsp"%>
	<div>
		<form method="get">
			<table border="1">
				<tr>
					<td align="center"><select name="searchField">
							<option value="name">이름</option>
							<option value="id">아이디</option>
					</select> <input type="text" name="searchWord" /> <input type="submit"
						value="검색하기" class="btn btn-secondary" /></td>
				</tr>
			</table>
		</form>
		<form name="delFrm">
			<table>
				<tr align="center">
					<th>아이디</th>
					<th>이름</th>
					<th>닉네임</th>
					<th>비밀번호</th>
					<th>회원탈퇴</th>
				</tr>
				<%
				if (MemberLists.isEmpty()) {
				%>
				<tr>
					<td colspan="5">회원이 없습니다 ㅠㅠ</td>
				</tr>
				<%
				} else {
				int count = 1;
				int virtualNum = 0;
				int countNum = 0;
				for (MemberDTO dto : MemberLists) {
					if (dto.getId().equals("admin")) {
					} else {
						virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
				%>
				<tr align="center">
					<td><%=dto.getId()%></td>
					<td><%=dto.getName()%></td>
					<td><%=dto.getNickname()%></td>
					<td><%=dto.getPass()%></td>
					<td><input type="checkbox" name="mid" value="<%=dto.getId()%>">
					</td>

				</tr>
				<%
				}
				}
				}
				%>
			</table>

			<table border="1" class="table table-striped">
				<tr align="center">
					<td><%=BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI())%>
					</td>
					<td><button type="submit" onclick="deleteMember();">회원
							탈퇴</button></td>
				</tr>
			</table>
		</form>
	</div>
	<%@ include file="../Include/Footer.jsp"%>
</body>
</html>