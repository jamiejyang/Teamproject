<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="utils.BoardPage"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

String userId = null;
if(session.getAttribute("User_id") != null){
	userId = (String)session.getAttribute("User_Id");
}
ReviewDAO dao = new ReviewDAO();

String sessionId = session.getAttribute("UserId").toString();
String pass = request.getParameter("pass");

Map<String, Object> param = new HashMap<String, Object>();


request.setCharacterEncoding("utf-8");


String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if(searchWord!=null) {
	param.put("searchField",searchField);
	param.put("searchWord",searchWord);
}

int totalCount = dao.selectCount(param);//게시물 수 확인

int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int)Math.ceil((double) totalCount/pageSize);


int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);

//글 목록 가져오기
List<ReviewDTO> boardLists = dao.selectListPage(param);
dao.close();

%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<meta charset="UTF-8">
</head>
<body>


	<form method="get">
		<table border="1" style="width: 90%;"  align="center">
			<tr>
				<td align="center"><select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
				</select> <input type="text" name="searchWord" /> 
				<input type="submit" class="btn btn-outline-success" value="검색하기" /></td>
			<tr>
				<td align="right">
				<%
						if (session.getAttribute("UserId") != null) {
						%> <input type="button" value="글쓰기" onclick="location.href='ReviewWrite.jsp'">
				</td>
				<% } %>
			</tr>
		</table>
	</form>




	<!-- 게시글 목록 부분 -->
	<div id="board">
		<table border="1" style="width: 90%;"  align="center">
			<tr align="center" >
				<th style="width:5%" align="center">글번호</th>
				<th style="width:60%" align="center">제목</th>
				<th style="width:15%" align="center">작성자</th>
				<th align="center">작성일</th>
				<th align="center">조회수</th>
				<th align="center">파일</th>
			</tr>
			<%
			if (boardLists.isEmpty()) {
			%>
			<tr>
				<td colspan="6" align="center">등록된 게시물이 없습니다.</td>
			</tr>
			<%} else {
				int virtualNum = 0;
				int countNum = 0;
			for (ReviewDTO dto : boardLists) {
				virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
				%>
				<tr align="center">
					
<!-- 					글번호 -->
					<td align="center" valign="middle">
					<% if(dto.getTopfix()==-1){
					%>
					<i class="bi bi-megaphone-fill"></i>
					<% } else {%>
					<%=virtualNum%></td>
					<%} %>
					
					
<!-- 					제목[댓글수] -->
					<td align="left">
					<% if(dto.getTopfix()==-1){
					%>
					<b><i><a href="ReviewView.jsp?num=<%=dto.getNum()%>" style="color:red" >
					<%=dto.getTitle()%></a></b></i>&nbsp;&nbsp;<b><a href="ReviewView.jsp?num=<%=dto.getNum()%>"><i class="bi bi-chat-dots-fill"></i>&nbsp;<%=dto.getCmtcount() %></a></b>
					</td>
					<%} else {%>
					<a href="ReviewView.jsp?num=<%=dto.getNum()%>">
					<%=dto.getTitle()%></a>&nbsp;&nbsp;<b><a href="ReviewView.jsp?num=<%=dto.getNum()%>"><i class="bi bi-chat-dots-fill"></i>&nbsp;<%=dto.getCmtcount() %></a></b>
					</td>
					<%} %>
					
					
					
					<td align="center"><%=dto.getId()%></td>
					<td align="center"><%=dto.getWritedate()%></td>
					<td align="center"><%=dto.getReadcount()%></td>
					
<!-- 					첨부파일여부 -->
					<td align="center">
					<% if(!dto.getOfile().equals(" ")){
					%>
					<i class="bi bi-folder-fill"></i>
					<% } %> 
					</td>
				</tr>
				<%
				}
				}
				%>
			</table>
	
	<table border="1" style="width: 90%;" align="center">
		<tr align="center">
			<td><%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %></td>
		</tr>
	</table>
	
	</div>


	<%@ include file="../Include/Footer.jsp"%>
</body>
</html>