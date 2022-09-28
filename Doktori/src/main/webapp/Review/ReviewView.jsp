<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));

ReviewDAO dao = new ReviewDAO(application);
dao.updateReadCount(num);
ReviewDTO dto = dao.selectView(num);
dao.close();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
function deletePost(){
   var confirmed = confirm("정말로 삭제하겠습니까?");
   if(confirmed){
      var form = document.writeFrm;
      form.method = "post";
      form.action = "ReviewDeleteProcess.jsp";
      form.submit();
   }
}
</script>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<body>
<h2>토론 / 리뷰 게시판 - 게시글 상세보기</h2>
<form name="writeFrm">
   <input type="hidden" name="num" value="<%= num %>"/>
   <table>
      <tr>
         <th>번호</th>
         <td><%= dto.getNum() %></td>
         <th>작성자</th>
         <td><%= dto.getId() %></td>
      </tr>
      <tr>
         <th>작성일</th>
         <td><%= dto.getWritedate() %></td>
         <th>조회수</th>
         <td><%= dto.getReadcount() %></td>
      </tr>
      <tr>
         <th>제목</th>
         <td colspan="3"><%= dto.getTitle() %></td>
      </tr>
      <tr>
         <th>내용</th>
         
<%--          <td colspan="3" height="100"><%= dto.getContent().replace("\r\n", "<br/>") %> --%>
         <td colspan="3" height="100"><%= dto.getContent() %>
         </td>
      </tr>
      <tr>
         <th>첨부파일</th>
         <td colspan="3" height="100">
         <img alt="" style="height: auto; width: 100%" src="../Uploads/<%=dto.getFiles()%>">
         <a ></a>
         </td>
      </tr>
      <tr>
         <td colspan="4" align="center">
            <%
            if(session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())){
            %>
            <button type="button" onclick="location.href='ReviewEdit.jsp?num=<%= dto.getId() %>';">수정하기</button>
            <button type="button" onclick="deletePost();">삭제하기</button>
            <%
            }
            %>
            <button type="button" onclick="location.href='ReviewList.jsp';">목록 보기</button>
         </td>
   </table>
</form>

<!--  댓글작성부분 -->
<div class="container">
	<div class="form-group">
		<form method="post" encType = "multipart/form-data" action="CommentProcess.jsp?bbsID=<%= bbsID %>&boardID=<%=boardID%>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tr>
					<td style="border-bottom:none;" valign="middle"><br><br><%= userID %></td>
					<td><input type="text" style="height:100px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다." name = "commentText"></td>
					<td><br><br><input type="submit" class="btn-primary pull" value="댓글 작성"></td>
				</tr>
				<tr>
					<td colspan="3"><input type="file" name="fileName"></td>
				</tr>
			</table>
		</form>
	</div>
</div>



</body>
</html>
<%@ include file="../Include/Footer.jsp" %>