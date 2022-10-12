<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="dao.LibDAO"%>
<%@page import="dto.LibDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%
int count = 0;
LibDAO dao = new LibDAO();
int totalCount = 0;
if (session.getAttribute("totalCount") != null) {
	totalCount = (int) session.getAttribute("totalCount");
}
List<LibDTO> libLists = dao.libList();
List<LibDTO> booklists = new ArrayList<>();
if (session.getAttribute("booklists") != null) {
	booklists = (List<LibDTO>) session.getAttribute("booklists");
}
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 성공!</title>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<script type="text/javascript">



// 체크박스 선택 
function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('searchLib');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}
	

</script>
<body>
	<%@ include file="../Include/SubHeader.jsp"%>
	<h2 align="center">
		<a href="BookList.jsp"> 도서 검색</a>
	</h2>
	<form action="BookSearchProcess.jsp">
		<table>
			<tr>
				<th><input type="checkbox" name="searchLib" value="selectall"
					onclick="selectAll(this)"> 전체 도서관 선택</th>
			</tr>
			<tr>
				<%
				for (LibDTO dto : libLists) {
				%>
				<th align="left"><input type="checkbox" name="searchLib"
					value="<%=dto.getLibName()%>"> <%=dto.getLibName()%></th>
				<%
				count++;
				if (count == 11) {
					count = 0;
				%>
			</tr>
			<tr>
				<%
				}
				}
				%>

			</tr>
		</table>


		<table border="1">
			<tr>
				<td align="center"><select name="searchField">
						<option value="title" selected="selected">제목</option>
						<option value="libname">도서관</option>
						<option value="author">저작자</option>
				</select> <input type="text" name="searchWord" autofocus="autofocus" /> <input
					type="submit" value="검색하기" /></td>
			</tr>
		</table>
	</form>


		<table border="1">

			<tr>
				<th style="width: 5%;">번호</th>
				<th style="width: 30%;">책 이름</th>
				<th>책 정보</th>
				<th style="width: 10%">이름미정</th>
			</tr>
			<%
			if (booklists.isEmpty() || booklists == null) {
			%>
			<tr>
				<td colspan="4" align="center">검색한 도서가 없습니다.</td>
			</tr>
			<%
			} else {
			int virtualNum = 0;
			for (LibDTO dto : booklists) {
				virtualNum = totalCount--;
			%>
				
			<tr>
		
				<td><%=virtualNum%></td>
				<td align="center"><a
					href="BookView.jsp?num=<%=dto.getBookNum()%>"><%=dto.getTitle()%></a>
				</td>
				<td align="left">책 레코드 키 : <%=dto.getBookKey()%>
					&nbsp;&nbsp;&nbsp;&nbsp; 종 레코드 키 : <%=dto.getSpeciesKey()%><br>

					소장 도서관 : <%=dto.getLibName()%> &nbsp;&nbsp;&nbsp;&nbsp; 도서관 코드 <%=dto.getManageCode()%>
					<br> 등록 번호 : <%=dto.getRegNo()%> &nbsp;&nbsp;&nbsp;&nbsp; 제어번호
					: <%=dto.getControlNo()%> <br> 청구 기호 : <%=dto.getCallNo()%>
					&nbsp;&nbsp;&nbsp;&nbsp; 소장 자료실명 : <%=dto.getShelfLocName()%> <br>

					저작자 : <%=dto.getAuthor()%> &nbsp;&nbsp;&nbsp;&nbsp; 출판사 : <%=dto.getPublisher()%>
					<br> 발행년도 : <%=dto.getPubYear()%> &nbsp;&nbsp;&nbsp;&nbsp;
					ISBN : <%=dto.getIsbn()%>
				</td>
				<td>
					<form name="LikeFrm" action="LikeProcess.jsp">
				<input type="hidden" name="booknum"
					value="<%=dto.getBookNum()%>">
					<button type="submit" value="check" >관심도서</button>
					</form>
					<button type="submit" value="check">예약하기</button></td>
				
			</tr>
			
			<%
			}
			}
			%>
		</table>

	<%@ include file="../Include/Footer.jsp"%>
</body>
</html>