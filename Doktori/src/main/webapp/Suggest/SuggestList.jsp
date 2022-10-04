<%@ include file="../Include/Subheader.jsp" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="./IsLoggedIn.jsp"%>
<%
String userId = null;
if(session.getAttribute("User_id") != null){
	userId = (String)session.getAttribute("User_Id");
}


SuggestDAO dao = new SuggestDAO();


String sessionId = session.getAttribute("UserId").toString();
String pass = request.getParameter("pass");

Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null) {
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
}

int totalCount = dao.selectCount(param); // 게시물 수 확인

// 전체 페이지 수 계산
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int) Math.ceil((double) totalCount / pageSize);

// 현재 페이지 확인
int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

// 목록에 출력할 게시물 범위 계산
int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);

List<SuggestDTO> boardLists = dao.selectListPage(param);
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<!-- <link -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" -->
<!-- 	rel="stylesheet" -->
<!-- 	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" -->
<!-- 	crossorigin="anonymous"> -->
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<body>
	<jsp:include page="/Suggest/SuggestLink.jsp" />

<!-- 	<h2> -->
<!-- 		목록 보기(List) - 현재 페이지 : -->
<%-- 		<%=pageNum%> --%>
<!-- 		(전체 : -->
<%-- 		<%=totalPage%>) --%>
<!-- 	</h2> -->

	<form method="get">
		<table border="1" width="90%">
			<tr>
				<td align="center"><select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
				</select> <input type="text" name="searchWord" /> <input type="submit"
					class="btn btn-outline-success" value="검색하기" /></td>
		</table>
	</form>

	<table border="1" width="90%">

		<tr>
			<th width="10%">번호</th>
			<th style="width: 30%;">제목</th>
			<th width="10%">처리상태</th>
			<th width="10%">작성자</th>
			<th width="10%">조회수</th>
			<th width="10%">작성일</th>
			<th width="10%">파일</th>
		</tr>

		<%
		if (boardLists.isEmpty()) {
		%>
		<tr>
			<td colspan="7" align="center">등록된 게시물이 없습니다.</td>
		</tr>
		<%
		} else {
		int virtualNum = 0;
		int countNum = 0;
		for (SuggestDTO dto : boardLists) {
			// 			virtualNum = totalCount--;
			virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
		%>
		
	    
		<tr align="center"><td><%=virtualNum%></td>
<!-- 		    관리자로 로그인 했을 때 비밀글 전체 조회가능, 일반회원일때 비밀번호 확인창 -->
			<% if(sessionId.equals("admin")) {%>
			<td align="left"><a href="SuggestView.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a>
			<% } else { %>
			<td align="left"><a href="SuggestCheckPassword.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a>
			<%} %>

			<td align="center"><%=dto.getProcessing()%></td>
			<td align="center"><%=dto.getId()%></td>
			<td align="center"><%=dto.getReadcount()%></td>
			<td align="center"><%=dto.getWritedate()%></td>
			<td align="center"><%=dto.getFiles()%></td>
		</tr>
		<%
		}
		}
		%>
	</table>

	<table border="1" width="90%">
		<tr align="center">
			<td><%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %></td>
			<td><button type="button" class="btn btn-outline-success"
					onclick="location.href='SuggestWrite.jsp';">글쓰기</button></td>
		</tr>
	</table>
</body>
</html>
<%@ include file="../Include/Footer.jsp" %>