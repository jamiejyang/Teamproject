<%@ include file="../Include/Subheader.jsp" %>
<%@ page import="dao.SuggestDAO" %>
<%@ page import="dto.SuggestDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");

SuggestDAO dao = new SuggestDAO(application);
dao.updateVisitCount(num);
SuggestDTO dto = dao.selectView(num);
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
      form.action = "SuggestDeleteProcess.jsp";
      form.submit();
   }
}
</script>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<body>

	<jsp:include page="./SuggestLink.jsp" />

<h2>건의사항 게시판 - 상세보기(view)</h2>
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
         <td><%= dto.getPostdate() %></td>
         <th>조회수</th>
         <td><%= dto.getVisitcount() %></td>
      </tr>
      <tr>
         <th>제목</th>
         <td colspan="3"><%= dto.getTitle() %></td>
      </tr>
      <tr>
         <th>내용</th>
         
<%--          <td colspan="3" height="100"><%= dto.getContent().replace("\r\n", "<br/>") %> --%>
         <td colspan="3" height="100"><%= dto.getContent()%>
         </td>
      </tr>
      <tr>
         <th>첨부파일</th>
         <td colspan="3" height="100">
         <img alt="" style="height: auto; width: 100%" src="../Uploads/<%=dto.getUfile()%>">
         <a ></a>
         </td>
      </tr>
      <tr>
         <td colspan="4" align="center">
            <%
            if(session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())){
            %>
            <button type="button" onclick="location.href='SuggestEdit.jsp?num=<%= dto.getNum() %>';">수정하기</button>
            <button type="button" onclick="deletePost();">삭제하기</button>
            <% } else if(session.getAttribute("UserId").equals("admin")) { %>
            <button type="button" onclick="deletePost();">삭제하기</button>
            <%
            }
            %>
            <button type="button" onclick="location.href='SuggestList.jsp';">목록 보기</button>
         </td>
   </table>
</form>
</body>
</html>
<%@ include file="../Include/Footer.jsp" %>