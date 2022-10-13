<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dao.ReserveDAO"%>
<%@page import="utils.BoardPage"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="utils.JSFunction"%>
<%@page import="dto.LibDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.LikesDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

if (session.getAttribute("UserId") == null || session.getAttribute("UserId").equals("guest")) {
	JSFunction.alertLocation("로그인이 필요한 페이지입니다.", "../Login/LoginForm.jsp", out);
}
String id = "";
Map<String, Object> param = new HashMap<String, Object>();
if (session.getAttribute("UserId") != null) {
	id = session.getAttribute("UserId").toString();
}
ReserveDAO dao= new ReserveDAO();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null) {
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
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

List<LibDTO> ReserveList = dao.selectReserve(param, id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심도서</title>
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
<script>
	function deleteLike() {
		var confirmed = confirm("관심도서에서 삭제 시키겠습니까?");
		if (confirmed) {
			var form = document.getElementByName('delLikeFrm');
			form.method = "post";
			form.action = "../BookSearch/LikeDeleteProcess.jsp";
			form.submit();
		}
	}
</script>
</head>
<body>
	<div class="mypageArea">
		<div class="list_area">
			<ul class="my_list">
				<li class="my_list__item"><a href="MyLike.jsp">관심 도서</a></li>
				<li class="my_list__item"><a href="MyReserve.jsp">예약 도서</a></li>
				<li class="my_list__item"><a href="Mypage.jsp">내 정보</a></li>
			</ul>
		</div>
		<div class="info_area">
			<form method="get">
				<table border="1">
					<tr>
						<td align="center"><select name="searchField">
								<option value="title">제목</option>
								<option value="libname">도서관</option>
						</select> <input type="text" name="searchWord" /> <input type="submit"
							value="검색하기" class="btn btn-secondary" name="11" /></td>
					</tr>
				</table>
			</form>
			<%
			if (ReserveList.isEmpty() || ReserveList == null) {
			%>
			<label> 관심도서가 없습니다.</label>
			<%
			} else {
				int virtualNum=0;
				int countNum= 0;
			for (LibDTO dto : ReserveList) {
				virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
			%>

			<ul class="resultList">
				<li>
					<div class="thumb">
						<a href="#link" onclick="" class="cover"> <span class="img">
								<img class="bookCoverImg" src="../Images/tan.png" alt="doktori">
						</span>
						</a>
					</div>
					<dl class="bookDataWrap">
						<dt class="tit">
							<span class="cate">도서</span> <a href="#link"><span
								class="searchKwd themeFC"><%=dto.getTitle()%></span></a>
						</dt>
						<dd class="author">
							<span>저자 : <%=dto.getAuthor()%></span> <span>발행자:<%=dto.getPublisher()%></span>
							<span class="mobileHide">발행년도: <%=dto.getPubYear()%></span>
						</dd>
						<dd class="data">
							<span class="mobileHide">등록번호: <%=dto.getRegNo()%></span> <span
								class="mobileHide">ISBN: <%=dto.getIsbn()%></span> <span>
								청구기호: <%=dto.getCallNo()%>
							</span>
						</dd>
						<dd class="site">
							<span>도서관: <%=dto.getLibName()%></span> <span>자료실: <%=dto.getShelfLocName()%></span>

						</dd>
					</dl>
					<div class="bookStateBar clearfix">
						<p class="txt">
						<%
			
				String booknum= dto.getBookNum();
				int result = dao.ReserveSearch(booknum);
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

						<div class="stateArea">
							<form name="delLikeFrm" >
								<input type="hidden" name="booknum1" value="<%=dto.getBookNum()%>">
								<a class="state del typeC"><span
									class="ico"></span> 도서반납</a>
							</form>
						</div>
					</div>
				</li>
			</ul>
			
			<%
			}
			}
			dao.close();
			%>
		</div>
<div align="center"><%=BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI())%></div>
	</div>
</body>
</html>
<%@ include file="../Include/Footer.jsp"%>