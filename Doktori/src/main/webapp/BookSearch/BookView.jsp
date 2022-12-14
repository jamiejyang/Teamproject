<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dao.ReserveDAO"%>
<%@page import="dto.LibDTO"%>
<%@page import="dao.LibDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String num = request.getParameter("num");
String UserId = "";
LibDAO dao = new LibDAO();
LibDTO dto = dao.selectBook(num);
dao.close();
ReserveDAO rdao = new ReserveDAO();
String booknum= dto.getBookNum();
int result = rdao.ReserveSearch(booknum);
rdao.close();
%>
<style>
.resultViewDetail {
	overflow: hidden;
	position: relative;
	margin-bottom: 30px;
	border: 1px solid #3e3e3e;
	border-radius: 5px;
	background-color: #fff;
}

.resultViewDetail:after {
	content: '';
	display: block;
	clear: both;
}

.resultViewDetail .tit {
	position: relative;
	padding: 10px 15px;
	background-color: #f4f4f4;
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

.resultViewDetail .tit .cate ~ h4 {
	display: inline-block;
	vertical-align: top;
}

.resultViewDetail .tit h4 {
	font-weight: 600;
	font-size: 1.067em;
	line-height: 22px;
	vertical-align: middle;
}

.resultViewDetail .thumb {
	position: absolute;
	top: 20px;
	left: 20px;
}

.resultViewDetail .thumb .cover {
	display: inline-block;
	overflow: hidden;
	padding: 6px 17px 10px;
/* 	background: url(/include/booksearch/image/common/bg_book_cover.png) 0 0 */
/* 		no-repeat; */
}

.bookInfoTbl {
	table-layout: fixed;
	height: 210px;
}

table {
	width: 100%;
	border-spacing: 0;
	font-size: inherit;
}

.bookInfoTbl th {
	font-weight: 600;
	text-align: left;
}

.bookInfoTbl th, .bookInfoTbl td {
	padding: 3px 0;
	line-height: 1.3;
	vertical-align: text-top;
}

colgroup {
	display: table-column-group;
}

.bookInfoTbl {
    table-layout: fixed;
    height: 210px;
}
.resultViewDetail .thumb .img {
	display: block;
	width: 136px;
	height: 194px;
	border: 1px solid #969696;
	float: left;
	overflow: hidden;
}
.resultViewDetail .resultBookInfo {
    position: relative;
    min-height: 210px;
    padding: 20px;
}

.resultViewDetail .tit {
    position: relative;
    padding: 10px 15px;
    background-color: #f4f4f4;
}
.bookDataWrap {
	padding-left: 200px;
}
.tblWrap {
	margin-bottom: 50px;
}
</style>
<div style="width: 1400px; margin: 0 auto">
	<div class="resultViewDetail">
		<div class="tit clearfix">
			<span class="cate fl">??????</span>
			<h4 class="fl"><%=dto.getTitle() %></h4>
		</div>
		<div class="resultBookInfo">
			<div class="thumb">
				<div class="cover">
				<%if(dto.getBookimg().equals(" ")){ %>
					<span class="img"><img class="bookCoverImg"
						src="../Images/tan.png" alt=""></span>
				<%}else{
					%>
					<span class="img"><img class="bookCoverImg"
						src="../BookImg/<%=dto.getBookimg() %>" alt=""></span>
				<% }%>
				</div>
			</div>
			<div class="bookDataWrap">
				<table class="bookInfoTbl">
					<caption>
						<!-- ????????? ????????? ?????? -->
						?????? ????????????
					</caption>
					<colgroup>
						<col style="width: 90px;">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">????????????</th>
							<td><%=dto.getAuthor() %></td>
						</tr>
						<tr>
							<th scope="row">?????????</th>
							<td><%=dto.getPublisher() %></td>
						</tr>
						<tr>
							<th scope="row">????????????</th>
							<td><%=dto.getPubYear() %>???</td>
						</tr>
						<tr>
							<th scope="row">??? ????????????</th>
							<td><%=dto.getBookKey() %></td>
						</tr>
						<tr>
							<th scope="row">???????????????</th>
							<td><%=dto.getLibName() %></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th scope="row">????????????</th> -->
<%-- 							<td><%=dto.getTitle() %></td> --%>
<!-- 						</tr> -->
						<tr>
							<th scope="row">????????????</th>
							<td>ISBN:<%=dto.getIsbn() %></td>
						</tr>
						<tr>
							<th scope="row">????????????</th>
							<td><%=dto.getControlNo() %></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="tblWrap">
		<table class="tbl hasLibrary" border="1">
			<caption>????????? ???????????? ?????????</caption>
			<colgroup>
<!-- 				<col class="col_state" style="width: 150px"> -->
<!-- 				<col class="col_callno" style="width: 150px"> -->
<!-- 				<col class="col_standardno" style="width: 150px"> -->
<!-- 				<col class="col_reservation" style="width: 150px"> -->
<!-- 				<col class="col_doorae" style="width: 150px"> -->
<!-- 				<col class="col_return" style="width: 150px"> -->
				
			</colgroup>
			<thead>
				<tr>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
				</tr>
			</thead>
			<tbody>
				<tr align="center">
					<%if(result ==1){
						%>
					<td class="col_state" align="center">????????????<br>[?????????]
					<%
					}else{
						
					%>
					<td class="col_state" align="center">????????????<br>[?????????]
					<%
					}
					%>
					</td>
					<td class="col_callno"><%=dto.getCallNo() %><br>
					</td>
					<td class="col_standardno"><%=dto.getRegNo() %></td>
					<td class="col_room"><%=dto.getShelfLocName() %></td>
					<td class="col_return" align="center">
					<form action="LikeProcess.jsp" name="LikeFrm">
					<input type="hidden" name="booknum" value="<%=dto.getBookNum()%>">
					<button type="submit" class="default_btn"  >??????????????????</button>
					</form>
					</td>
					<%if(result ==1){
						%>
						<td class="col_reservation"><span class="tblBtn tB04">????????????</span></td>
					<%
					}else{
						
					%>
					<td class="col_reservation">
					<form action="ReserveProcess.jsp">
					<input type="hidden" name="booknum" value="<%=dto.getBookNum()%>">
					<button class="default_btn" type="submit">
					????????????
					</button>
					</form>
					</td>
					<%
					}
					%>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="../Include/Footer.jsp"%>