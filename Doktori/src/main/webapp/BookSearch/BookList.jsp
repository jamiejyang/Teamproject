<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dto.LikesDTO"%>
<%@page import="dao.ReserveDAO"%>
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
<style>
.resultList>li {
	overflow: hidden;
	position: relative;
	min-height: 135px;
	padding: 15px 0;
	border-bottom: 1px solid #c5c5c5;
}

.resultList .thumb .img {
	display: block;
	width: 100px;
	height: 140px;
}

.tit .cate {
	display: inline-block;
	min-width: 40px;
	margin: 1px 4px 1px 0;
	padding: 0 3px;
	line-height: 20px;
	text-align: center;
	vertical-align: top;
	border: 1px solid #c8c8c8;
	background: linear-gradient(to bottom, #f2f2f2 0%, #ffffff 100%);
}

.resultList .thumb {
	position: absolute;
	top: 13px;
	left: 0;
}

.resultList.imageType .chk ~ .thumb {
	left: 25px;
}

.resultList .thumb .cover, .kdcBookList .bookList .cover {
	display: block;
	overflow: hidden;
	padding-top: 4px;
	/* 	background: url(/include/booksearch/image/common/bg_book.png) 0 0 */
	/* 		no-repeat; */
	/* 	background-size: 100% 4px; */
}

.resultList.imageType .chk ~ .thumb {
	left: 25px;
}

.resultList .thumb {
	position: absolute;
	top: 13px;
	left: 0;
}

.resultList .bookDataWrap {
	margin-left: 150px;
	min-height: 120px;
}

.bookDataWrap dd {
	overflow: hidden;
	line-height: 24px;
}

.bookDataWrap dd {
	overflow: hidden;
	line-height: 24px;
}

.bookDataWrap dd>span {
	display: inline-block;
	position: relative;
	margin-right: 24px;
	margin-left: -15px;
	padding-left: 14px;
	font-size: 10.5pt;
	word-break: normal;
}
</style>
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

	<%
			if (booklists.isEmpty() || booklists== null) {
			%>
	<div align="center">검색도서가 없습니다.</div>
	<%
			} else {
				int virtualNum = 0;
				for (LibDTO dto : booklists) {
					virtualNum = totalCount--;
					%>

	<ul class="resultList">
		<li>
			<div class="thumb">
				<a href="#link" onclick="" class="cover"> <span class="img">
						<%if(dto.getBookimg().equals(" ")|| dto.getBookimg()==null){
						%> <img class="bookCoverImg" src="../Images/tan.png" alt="doktori"
						style="height: auto;"> <%
					}else{
						
					%> <img class="bookCoverImg" src="../BookImg/<%=dto.getBookimg()%>"
						alt="doktori" style="height: auto;"> <%
					}
					%>
				</span>
				</a>
			</div>
			<dl class="bookDataWrap">
				<dt class="tit">
					<span class="cate">도서</span> <a
						href="BookView.jsp?num=<%=dto.getBookNum()%>"><span
						class="searchKwd themeFC"><%=dto.getTitle()%></span></a>
				</dt>
				<dd class="author">
					<span>책 레코드 키 | <%=dto.getBookKey() %></span> <span>종 레코드 키
						| <%= dto.getSpeciesKey() %></span> <span>소장 도서관 | <%=dto.getLibName() %></span>
					<span>도서관 코드 | <%=dto.getManageCode() %></span>
				</dd>
				<dd class="data">
					<span>등록 번호 | <%=dto.getRegNo() %></span> <span>제어번호 | <%= dto.getControlNo() %></span>
					<span>청구 기호 | <%=dto.getCallNo() %></span> <span>소장자료실 명 | <%=dto.getShelfLocName() %></span>
				</dd>
				<dd class="site">
					<span>저작자 | <%=dto. getAuthor()%></span> <span>출판사 | <%=dto.getPublisher() %></span>
					<span>발행년도 | <%=dto.getPubYear() %></span> <span>ISBN | <%= dto.getIsbn() %></span>
				</dd>
			</dl>
			<div class="bookStateBar clearfix">
				<%
				ReserveDAO rdao = new ReserveDAO();
				String booknum= dto.getBookNum();
				int result = rdao.ReserveSearch(booknum);
				rdao.close();
				if(result ==1){
					%>
				<p class="txt">
					<b>대출불가[예약중]</b>
				</p>
				<%
				}else{
					
				%>
				<p class="txt">
					<b>대출가능[비치중]</b>
				</p>
				<%
				}
%>

				<div class="stateArea" align="right">
					<form name="LikeFrm" action="LikeProcess.jsp">
						<input type="hidden" name="booknum" value="<%=dto.getBookNum()%>">
						<button type="submit" value="check">관심도서</button>
					</form>
					<form action="ReserveProcess.jsp">
						<input type="hidden" name="booknum" value="<%=dto.getBookNum()%>">
						<button type="submit">예약하기</button>
					</form>
				</div>
			</div>
		</li>
	</ul>

	<%
			}
			}
				
			
			%>
		<%@ include file="../Include/Footer.jsp"%>
</body>
</html>