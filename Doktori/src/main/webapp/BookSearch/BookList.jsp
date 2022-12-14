<%@page import="utils.BoardPage"%>
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
<style>
.resultList>li {
	overflow: hidden;
	position: relative;
	min-height: 135px;
	padding: 30px 0;
	border-bottom: 1px solid #c5c5c5;
}

.resultList .thumb .img {
	display: block;
	width: 85px;
	height: 130px;
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
	left: 18px;
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
<script type="text/javascript">



// ???????????? ?????? 
function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('searchLib');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}
	

</script>
<div class="bookList">
	<h2 align="center">
	</h2>
	<form action="BookSearchProcess.jsp">
		<table>
			<tr>
				<th><input type="checkbox" name="searchLib" value="selectall"
					onclick="selectAll(this)"> ?????? ????????? ??????</th>
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
		<table>
			<tr>
				<td align="center"><select name="searchField">
						<option value="title" selected="selected">??????</option>
						<option value="libname">?????????</option>
						<option value="author">?????????</option>
				</select> <input type="text" name="searchWord" autofocus="autofocus" /> <input class="default_btn"
					type="submit" value="????????????" /></td>
			</tr>
		</table>
	</form>

	<%
			if (booklists.isEmpty() || booklists== null) {
			%>
	<div align="center">??????????????? ????????????.</div>
	<%
			} else {
				int virtualNum = 0;
				for (LibDTO dto : booklists) {
					virtualNum = totalCount--;
					%>

	<ul class="resultList">
		<li>
			<div class="thumb">
				<a href="BookView.jsp?num=<%=dto.getBookNum()%>" onclick="" class="cover"> <span class="img" >
						<%if(dto.getBookimg().equals(" ")|| dto.getBookimg()==null){%> 
						<img class="bookCoverImg" src="../Images/tan.png" alt="doktori" style="" >   <%
					}else{
						
					%> <img class="bookCoverImg" src="../BookImg/<%=dto.getBookimg()%>"
						alt="doktori" style="height: auto; "> <%
					}
					%>
				</span>
				</a>
			</div>
			<dl class="bookDataWrap">
				<dt class="tit">
					<span class="cate">??????</span> <a
						href="BookView.jsp?num=<%=dto.getBookNum()%>"><span
						class="searchKwd themeFC"><%=dto.getTitle()%></span></a>
				</dt>
				<dd class="author">
					<span>??? ????????? ??? | <%=dto.getBookKey() %></span> <span>??? ????????? ???
						| <%= dto.getSpeciesKey() %></span> <span>?????? ????????? | <%=dto.getLibName() %></span>
<%-- 					<span>????????? ?????? | <%=dto.getManageCode() %></span> --%>
				</dd>
				<dd class="data">
					<span>?????? ?????? | <%=dto.getRegNo() %></span> <span>???????????? | <%= dto.getControlNo() %></span>
					<span>?????? ?????? | <%=dto.getCallNo() %></span> <span>??????????????? ??? | <%=dto.getShelfLocName() %></span>
				</dd>
				<dd class="site">
					<span>????????? | <%=dto. getAuthor()%></span> <span>????????? | <%=dto.getPublisher() %></span>
					<span>???????????? | <%=dto.getPubYear() %></span> <span>ISBN | <%= dto.getIsbn() %></span>
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
					<b>????????????[?????????]</b>
				</p>
				<%
				}else{
					
				%>
				<p class="txt">
					<b>????????????[?????????]</b>
				</p>
				<%
				}
%>

				<div class="stateArea" align="right">
					<form name="LikeFrm" action="LikeProcess.jsp">
						<input type="hidden" name="booknum" value="<%=dto.getBookNum()%>">
						<button class="default_btn" type="submit" value="check">????????????</button>
					</form>
					<form action="ReserveProcess.jsp">
						<input type="hidden" name="booknum" value="<%=dto.getBookNum()%>">
						<button class="default_btn" type="submit">????????????</button>
					</form>
				</div>
			</div>
		</li>
	</ul>

	<%
			}
			}
				
			
			%>
</div>
		<%@ include file="../Include/Footer.jsp"%>
