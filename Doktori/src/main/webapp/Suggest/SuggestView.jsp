<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.List"%>
<%@ page import="dao.SuggestDAO"%>
<%@ page import="dto.SuggestDTO"%>
<%@ page import="dto.Comment2DTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%


String sessionId = session.getAttribute("UserId").toString();
String num = request.getParameter("num");
String cmtNum = request.getParameter("cmtnum");


SuggestDAO dao = new SuggestDAO(application);
dao.updateReadCount(num);
SuggestDTO dto = dao.selectView(num);

List<Comment2DTO> commentLists = dao.getList(num);
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function deletePost() {
		var confirmed = confirm("정말로 삭제하겠습니까?");
		if (confirmed) {
			var form = document.writeFrm;
			form.method = "post";
			form.action = "SuggestDeleteProcess.jsp";
			form.submit();
		}
	}
	function nwindow(num,cmtnum){
		window.name = "commentParant";
		var url= "SuggestEditComment.jsp?&num="+num+"&cmtNum="+cmtNum;
		window.open(url,"댓글수정","width=600,height=230,left=300");
	}
</script>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<body>
	<h2>건의사항 게시판 - 상세보기(view)</h2>
	<form name="writeFrm">
		<input type="hidden" name="num" value="<%=num%>" />
		<input type="hidden" name="oldFile" value="<%=dto.getOfile()%>" />
		<input type="hidden" name="newFile" value="<%=dto.getSfile()%>" />
	
		<table>
			<tr>
				<th>번호</th>
				<td><%=dto.getNum()%></td>
				<th>작성자</th>
				<td><%=dto.getId().substring(0,1) + "**"%></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=dto.getWritedate()%></td>
				<th>조회수</th>
				<td><%=dto.getReadcount()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3" height="100"><%=dto.getContent().replace("\r\n", "<br/>")%></td>
			</tr>
			<tr>
				<th>첨부파일</th>
					<td colspan="3"> 
					<a href="SuggestDownload.jsp?oName=<%=URLEncoder.encode(dto.getOfile(), "UTF-8")%>&sName=<%=URLEncoder.encode(dto.getSfile(), "UTF-8")%>"><%=dto.getOfile() %></a><br></br>
					<img alt="" style="height: auto; width: 50%"
						src="../Uploads/<%=dto.getSfile()%>"></td>
				</tr>
			<tr>
				<td colspan="4" align="center">
					<%
					if (session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())) {
					%>
					<button type="button"
						onclick="location.href='SuggestEdit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
					<button type="button" onclick="deletePost();">삭제하기</button> <%
 } else if (session.getAttribute("UserId").equals("admin")) {
 %>
					<button type="button" onclick="deletePost();">삭제하기</button> <%
 }
 %>
					<button type="button" onclick="location.href='SuggestList.jsp';">목록
						보기</button>
								</table>
								</form> 
	
 	<table border="1" style="width: 100%;">

		<tr>
			<th style="width: 70%;">내용</th>
			<th>작성자</th>
			<th>작성일</th>	
		</tr>
<%
		if (commentLists.isEmpty()) {
		%>
		<tr>
			<td colspan="3" align="center">등록된 댓글이 없습니다.</td>
		</tr>
		<%
		} else {
		int virtualNum = 0;
		int countNum = 0;
		for (Comment2DTO cdto : commentLists) {
		%>

		<tr>
			<td><%=cdto.getCmtContent().replace("\r\n", "<br/>")%></td>
			<td align="center"><%=cdto.getCmtID()%></td>
			<td align="center"><%=cdto.getCmtDate()%></td>
<!-- 		    <td align="center"><button type="button" onclick="deleteCommentPost();">삭제하기</button><td> -->
		
		    <%
 			if (session.getAttribute("UserId").equals("admin")) {
 			%>
 			<tr>
		    <td colspan="3" align="center">
 			<form action="SuggestDeleteCommentProcess.jsp" method="post">
		    <input type="hidden" name="cmtnum" value="<%=cdto.getCmtNum()%>" />
		    <input type="hidden" name="bbsnum" value="<%=cdto.getBbsNum()%>" />
		    <button type="submit" >댓글삭제하기</button>
		   	</form>
		    </td>
		    </tr>
		    		<%
					}
 					%>
<!-- 		</tr> -->
		 
		<%
		}
		}
		%>
			</table> 
		
<%
 if (sessionId.equals("admin")) {
 %>
 
<!--  댓글작성 -->
	<form method="post" action="SuggestCommentProcess.jsp">
			<input type="hidden" name="bbsnum" value="<%=num%>" />
		<table border="1" width="90%">
			<tr>
				<th>댓글</th>
				<td><textarea name="cmtcontent" style="width: 90%; height: 100px;">
</textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">댓글 작성</button>
				</td>
			</tr>
					<%
					}
					%>
							</table>
							</form>
</body>
</html>
<%@ include file="../Include/Footer.jsp" %>