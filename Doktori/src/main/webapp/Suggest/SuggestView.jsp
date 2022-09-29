<%@ include file="../Include/Subheader.jsp"%>
<%@ page import="dao.SuggestDAO"%>
<%@ page import="dto.SuggestDTO"%>
<%@ page import="dao.Comment2DAO"%>
<%@ page import="dto.Comment2DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String sessionId = session.getAttribute("UserId").toString();
String num = request.getParameter("num");

SuggestDAO dao = new SuggestDAO(application);
dao.updateReadCount(num);
SuggestDTO dto = dao.selectView(num);
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
</script>
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<body>

	<jsp:include page="./SuggestLink.jsp" />

	<h2>건의사항 게시판 - 상세보기(view)</h2>
	<form name="writeFrm">
		<input type="hidden" name="num" value="<%=num%>" />
		<table>
			<tr>
				<th>번호</th>
				<td><%=dto.getNum()%></td>
				<th>작성자</th>
				<td><%=dto.getId()%></td>
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

				<%--          <td colspan="3" height="100"><%= dto.getContent().replace("\r\n", "<br/>") %> --%>
				<td colspan="3" height="100"><%=dto.getContent()%></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3" height="100"><img alt=""
					style="height: auto; width: 100%"
					src="../Uploads/<%=dto.getFiles()%>"> <a></a></td>
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
						보기</button> <%
 if (sessionId.equals("admin")) {
 %>
 
<!--  댓글 리스트 -->
 		<div class="container">
			<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<tbody>
					<tr>
						<td align="left" bgcolor="beige">댓글</td>
					</tr>
					<tr>
						<%
							Comment2DAO comment2DAO = new Comment2DAO();
							ArrayList<Comment> list = comment2DAO.getList(boardID, bbsID);
							for(int i=0; i<list.size(); i++){
						%>
							<div class="container">
								<div class="row">
									<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
										<tbody>
										<tr>						
										<td align="left"><%= list.get(i).getUserID() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= list.get(i).getCommentDate().substring(0,11) + list.get(i).getCommentDate().substring(11,13) + "시" + list.get(i).getCommentDate().substring(14,16) + "분" %></td>		
										<td colspan="2"></td>
										<td align="right"><%
													if(list.get(i).getUserID() != null && list.get(i).getUserID().equals(userID)){
												%>
														<form name = "p_search">
															<a type="button" onclick="nwindow(<%=boardID%>,<%=bbsID %>,<%=list.get(i).getCommentID()%>)" class="btn-primary">수정</a>
														</form>	
														<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "commentDeleteAction.jsp?bbsID=<%=bbsID %>&commentID=<%= list.get(i).getCommentID() %>" class="btn-primary">삭제</a>
																	
												<%
													}
												%>	
										</td>
										</tr>
										<tr>
											<td colspan="5" align="left"><%= list.get(i).getCommentText() %>
											<% 	
												String commentReal = "C:\\Users\\j8171\\Desktop\\studyhard\\JSP\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\BBS\\commentUpload";
												File commentFile = new File(commentReal+"\\"+bbsID+"사진"+list.get(i).getCommentID()+".jpg");
												if(commentFile.exists()){
											%>	
											<br><br><img src = "commentUpload/<%=bbsID %>사진<%=list.get(i).getCommentID() %>.jpg" border="300px" width="300px" height="300px"><br><br></td>											
											<%} %>	
										</tr>
									</tbody>
								</table>			
							</div>
						</div>
						<%
							}
						%>
					</tr>
				</table>
			</div>
		</div>
 
 
<!--  댓글작성 -->
					<div class="container">
						<div class="form-group">
<%-- 									<form method="post" encType = "multipart/form-data" action="commentAction.jsp?bbsID=<%= bbsID %>&boardID=<%=boardID%>"> --%>
									<form method="post" action="SuggestCommentProcess.jsp">
							<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
								<tr>
									<!-- 					<td style="border-bottom:none;" align="middle"><br><br></td> -->
									<th>댓글</th>
									<td colspan="4"><input type="text"
										style="height: 100px; width: 600px;" class="form-control" placeholder="댓글을 입력해주세요." name="commentText"><input type="submit" class="btn-primary pull" value="댓글 작성"></td>
									
									<!-- 				</tr> -->
									<!-- 					<td colspan="3"><input type="file" name="fileName"></td> -->
									<!-- 				<tr> -->
								</tr>
					<%
					}
					%>
							</table>
									</form>
						</div>
					</div>
				</td>
		</table>
	</form>
</body>
</html>
<%@ include file="../Include/Footer.jsp"%>