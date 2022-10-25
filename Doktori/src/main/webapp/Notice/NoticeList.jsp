
<%@ include file="../Include/SubHeader.jsp"%>
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
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
	<div style="width: 1400px; margin: 0 auto 50px;">
		<form method="post">
			<table>
				<tr>
					<td align="center"><select name="searchLib">
							<option>전체도서관</option>
							<option value="MA">강남도서관</option>
							<option value="MB">강동도서관</option>
							<option value="MC">강서도서관</option>
							<option value="MD">개포도서관</option>
							<option value="ME">고덕평생학습관</option>
							<option value="MF">고척도서관</option>
							<option value="MG">구로도서관</option>
							<option value="MH">남산도서관</option>
							<option value="MV">노원평생학습관</option>
							<option value="MJ">도봉도서관</option>
							<option value="MK">동대문도서관</option>
							<option value="ML">동작도서관</option>
							<option value="MX">마포평생아현분</option>
							<option value="MM">마포평생학습관</option>
							<option value="MP">서대문도서관</option>
							<option value="MW">송파도서관</option>
							<option value="MN">양천도서관</option>
							<option value="MQ">어린이도서관</option>
							<option value="MR">영등포평생학습</option>
							<option value="MS">용산도서관</option>
							<option value="MT">정독도서관</option>
							<option value="MU">종로도서관</option>
					</select> <select name="searchField">
							<option value="title" selected="selected">제목</option>
							<option value="content">내용</option>
					</select> <input type="text" name="searchWord" autofocus="autofocus" /> <input class="default_btn"
						type="submit" value="검색하기" class="btn btn-secondary" /></td>

				</tr>
			</table>
		</form>
		<table class="ft14">
			<tr>
				<th style="width: 5%;">게시번호</th>
				<th style="width: 7%">도서관 코드</th>
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
			String libname="";
			
			
			for (NoticeDTO n : noticeLists) {
				virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
				switch (n.getmanagecode()) {
				case "MA" : libname="강남";
					break;
				case "MB" : libname="강동";
					break;
				case "MC" : libname="강서";
					break;
				case "MD" : libname="개포";
					break;
				case "ME" : libname="고덕";
					break;
				case "MF" : libname="고척";
					break;
				case "MG" : libname="구로";
					break;
				case "MH" : libname="남산";
					break;
				case "MV" : libname="노원";
					break;
				case "MJ" : libname="도봉";
					break;
				case "MK" : libname="동대문";
					break;
				case "ML" : libname="동작";
					break;
				case "MX" : libname="마포아현";
					break;
				case "MM" : libname="마포";
					break;
				case "MP" : libname="서대문";
					break;
				case "MW" : libname="송파";
					break;
				case "MN" : libname="양천";
					break;
				case "MQ" : libname="어린이";
					break;
				case "MR" : libname="영등포";
					break;
				case "MS" : libname="용산";
					break;
				case "MT" : libname="정독";
					break;
				case "MU" : libname="종로";
					break;
				}
	        
			%>
			<tr align="center">
				<td><%=virtualNum%></td>
				<td><%=libname%></td>
				<td align="left"><a href="NoticeView.jsp?num=<%=n.getNum()%>"><%=n.getTitle()%></a></td>

				<td><%=n.getWritedate()%></td>
				<%
				if (n.getOfile().equals(" ")) {
				%>
				<%-- 				<td align="left"><%=n.getFiles()%></td> --%>
				<td></td>
				<!-- 				여기다가 파일 있으면 체크 하면 댐 -->
				<%
				} else {
				%>
				<td><i class="bi bi-folder-fill"></i></td>
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
		<table>
			<tr align="center">
				<td><%=BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI())%>
				</td>
			</tr>
		</table>
		<%if (session.getAttribute("UserId").equals("admin")) {
 %>				<div style="text-align: right;">
					<input class="default_btn" type="button" value="글쓰기" onclick="location.href='NoticeUpload.jsp'">
				</div>
			<%
					}
					%>
	</div>
	<%@ include file="../Include/Footer.jsp"%>