<%@page import="org.apache.catalina.ant.jmx.JMXAccessorQueryTask"%>
<%@page import="utils.BoardPage"%>
<%@page import="dto.LibDTO"%>
<%@page import="javax.swing.text.AbstractDocument.BranchElement"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="java.security.cert.CertPathParameters"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%
NoticeDAO dao = new NoticeDAO();
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
String searchLib = request.getParameter("searchLib");
if (searchLib == null && searchWord == null) {
	param.put("searchLib", searchLib);
	param.put("searchWord", searchWord);
	param.put("searchField", searchField);
} else if (searchLib.equals("전체도서관") && searchWord != null) {
	param.put("searchLib", searchLib);
	param.put("searchWord", searchWord);
	param.put("searchField", searchField);
} else if (searchLib.equals("전체도서관")) {
	param.put("searchLib", searchLib);
	param.put("searchWord", searchWord);
	param.put("searchField", searchField);
} else if (searchLib != null && searchWord != null) {

	param.put("searchLib", searchLib);
	param.put("searchWord", searchWord);
	param.put("searchField", searchField);
}

int totalCount = dao.selectCount(param);
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int) Math.ceil((double) totalCount / pageSize);
// 전체 페이지

int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);
//페이지 확인

int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);

List<NoticeDTO> noticeLists = dao.selectListPage(param);
dao.close();

// 머지할떄 삭제 
if (session.getAttribute("UserId") == null) {
	session.setAttribute("UserId", "guest");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<title>Notice</title>
</head>
<body>
	<h3>
		목록 현재 :
		<%=pageNum%><br> 전체 :
		<%=totalPage%>
	</h3>

	<%@ include file="../Include/SubHeader.jsp"%>
	<div>
		<form method="get">
			<table border="1">
				<tr>
					<td align="center"><select name="searchLib">
							<option>전체도서관</option>
							<option value="강남도서관">강남도서관</option>
							<option value="강동도서관">강동도서관</option>
							<option value="강서도서관">강서도서관</option>
							<option value="개포도서관">개포도서관</option>
							<option value="고덕평생학습관">고덕평생학습관</option>
							<option value="고척도서관">고척도서관</option>
							<option value="구로도서관">구로도서관</option>
							<option value="남산도서관">남산도서관</option>
							<option value="노원평생학습관">노원평생학습관</option>
							<option value="도봉도서관">도봉도서관</option>
							<option value="동대문도서관">동대문도서관</option>
							<option value="동작도서관">동작도서관</option>
							<option value="마포평생아현분">마포평생아현분</option>
							<option value="마포평생학습관">마포평생학습관</option>
							<option value="서대문도서관">서대문도서관</option>
							<option value="송파도서관">송파도서관</option>
							<option value="양천도서관">양천도서관</option>
							<option value="어린이도서관">어린이도서관</option>
							<option value="영등포평생학습">영등포평생학습</option>
							<option value="용산도서관">용산도서관</option>
							<option value="정독도서관">정독도서관</option>
							<option value="종로도서관">종로도서관</option>
					</select> <select name="searchField">
							<option value="title" selected="selected">제목</option>
							<option value="content">내용</option>
					</select> <input type="text" name="searchWord" autofocus="autofocus" /> <input
						type="submit" value="검색하기" class="btn btn-secondary" /> <%
 if (session.getAttribute("UserId").equals("admin")) {
 %> <a href="NoticeUpload.jsp">글쓰기</a></td>
					<%
					}
					%>

				</tr>
			</table>
		</form>
		<table border="1">
			<tr>
				<th style="width: 5%;">게시번호</th>
				<th style="width: 5%">도서관 코드</th>
				<th style="width: 70%">제목</th>
				<th>작성일</th>
				<th>첨부</th>
				<th>조회수</th>
			</tr>
			<%
			if (noticeLists.isEmpty()) {
			%>
			<tr>
				<td colspan="6" align="center">등록된 게시물이 없습니다.</td>
				<!-- 				게시물이 없으면 true -->
			</tr>

			<%
			} else {
			int virtualNum = 0;
			int countNum = 0;
			for (NoticeDTO n : noticeLists) {
				virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
			%>
			<tr align="center">
				<td><%=virtualNum%></td>
				<td><%=n.getLibname()%></td>
				<td align="left"><a href="NoticeView.jsp?num=<%=n.getNum()%>"><%=n.getTitle()%></a></td>

				<td><%=n.getWritedate()%></td>
				<%
				if (n.getFiles().equals(" ")) {
				%>
				<%-- 				<td align="left"><%=n.getFiles()%></td> --%>
				<td>파일이 없ㅇ</td>
				<!-- 				여기다가 파일 있으면 체크 하면 댐 -->
				<%
				} else {
				%>
				<td><img alt="" style="height: auto;" src="../Uploads/tan.png">
				</td>
				<%
				}
				%>
				<td><%=n.getReadcount()%></td>
			</tr>
			<%
			}

			}
			%>
		</table>
		<table border="1">
			<tr align="center">
				<td><%=BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI())%>
				</td>
			</tr>
		</table>
	</div>
	<%@ include file="../Include/Footer.jsp"%>
</body>
</html>