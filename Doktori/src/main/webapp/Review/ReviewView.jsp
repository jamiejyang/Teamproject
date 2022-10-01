<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="dao.CommentDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	String userId = null;
	if(session.getAttribute("UserId") != null){
		userId = (String) session.getAttribute("UserId");
	}
	int num = 0;
	if (request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	if (num == 0){
		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location href = 'LoginForm.jsp'");
			script.println("</script>");
	}
	ReviewDAO dao = new ReviewDAO();
	ReviewDTO dto = dao.selectView(num);//여기서 num은 bbsnum
	
	CommentDAO cdao = new CommentDAO();
	CommentDTO cmt = cdao.getComment(num);
	dao.close();
	

// 	dto.setId(session.getAttribute("UserId").toString());
// 	dao.updateReadCount(num);
// 	dao.close();
	
// 	dao.insertWrite(dto);
// 	dao.close();
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
<script type="text/javascript">
	function nwindow(num,cmtNum){
		window.name = "commentParant";
		var url= "../Comment/CommentUpdate.jsp?&num="+num+"&cmtNum="+cmtNum;
		window.open(url,"댓글 수정하기","width=600,height=230,left=300,resizable=no");
	}
	</script>
	
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
</head>
<body>
	<h2>토론 / 리뷰 게시판 - 게시글 상세보기</h2>
	<form name="writeFrm">
		<input type="hidden" name="num" value="<%= num %>" />
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
				<td colspan="3" height="100"><%= dto.getContent().replace("\r\n", "<br/>") %></td>
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
            if(session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())){
            %>
					<button type="button"
						onclick="location.href='ReviewEdit.jsp?num=<%= dto.getNum() %>';">수정하기</button>
					<button type="button" onclick="deletePost();">삭제하기</button> <%
            }
            %>
					<button type="button" onclick="location.href='ReviewList.jsp';">목록
						보기</button>
				</td>
		</table>
	</form>
	
	
    <!-- 댓글리스트 -->
	<div class="container">
	<div class="row">
		<table style="text-align: center; border: 1px solid #dddddd">
			<tbody>
				<tr>
					<td align="left" bgcolor="beige">댓글 목록</td>
				</tr>
				<tr>
				<%
				
// 					int bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
			 	
				
					ArrayList<CommentDTO> list = cdao.getList(num); 
					cdao.close();
					
					for(int i=0; i<list.size(); i++){
				%>
				
<!-- 					컨테이너 하나당 댓글 하나씩 보여줌 -->
						<div class="container">		
							<div class="row">
								<table style="text-align: center; border: 1px solid #dddddd">
									<tbody>
										<tr>						
<%-- 											<td align="left"><%= list.get(i).getCmtid() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= list.get(i).getCmtdate().substring(0,11) + list.get(i).getCmtdate().substring(11,13) + "시" + list.get(i).getCmtdate().substring(14,16) + "분" %></td>		 --%>
											<td align="left" style="width:10%;"><%= list.get(i).getCmtid() %></td>	
											<td colspan="2" align="left" style="width:20%;"> <%= list.get(i).getCmtdate().substring(0,11) + list.get(i).getCmtdate().substring(11,13) + "시" + list.get(i).getCmtdate().substring(14,16) + "분" %></td>
											<td align="right">
												<%
												if(list.get(i).getCmtid() != null && list.get(i).getCmtid().equals(session.getAttribute("UserId"))){   //댓글 쓴사람과 지금 유저가 같을 때 수정과 삭제를 가능하게 함
												%>
													<form name = "p_search">
														<a type="button" onclick="nwindow(<%=num %>,<%=list.get(i).getCmtnum()%>)">수정</a>
														<% System.out.println(num);
														System.out.println(list.get(i).getCmtnum());%>
													</form>	
														<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "../Comment/CommentDeleteProcess.jsp?cmtNum=<%= list.get(i).getCmtnum() %>" >삭제</a>																	
												<%
												}
												%>	
											</td>
										</tr>
										<tr>
											<td colspan="3" align="left"><%= list.get(i).getCmtcontent() %>
<%-- 											<% 	 --%>
<!--  												String commentReal = "C:\\Users\\j8171\\Desktop\\studyhard\\JSP\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\BBS\\commentUpload"; -->
<!--  												File commentFile = new File(commentReal+"\\"+bbsNum+"사진"+list.get(i).getCmtnum()+".jpg"); -->
<!--  												if(commentFile.exists()){           //해당 댓글에 대응되는 사진이 있을 경우 사진도 보여준다. -->
<%-- 											%>	 --%>
<%-- 											<br><br><img src = "Uploads/CommentUploads/<%=bbsNum%>사진<%=list.get(i).getCmtnum() %>.jpg" border="300px" width="300px" height="300px"><br><br></td> --%>
<%-- 											<%} %>	 --%>
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
	
	

	<!--  댓글작성부분 폼을 넘겨주는 방식 -->
	<div class="container">
		<div class="form-group">
			<!--게시물번호를 넘긴다(bbsid) -->
			<form method="post" encType="multipart/form-data"
				action="../Comment/CommentWriteProcess.jsp?num=<%=num %>">  
				<table style="text-align: center; border: 1px solid #dddddd">
					<tr>
<!-- 						여기 지금 로그인한놈(코멘트 쓸 놈) 아이디 떠야함 -->
						<td style="width: 15%; border-bottom: none;" valign="middle"><%=session.getAttribute("UserId")%></td> 
						<td style="width: 70%; height:100px;">
						<textarea class="form-control" style="width: 100%; height: 75px" name="content" placeholder="건강한 토론문화를 위해 상대방을 존중하는 댓글을 남겨주세요."
							name="cmtContent"></textarea> </td>
<%-- 						<input type="text" class="form-control" placeholder="건강한 토론문화를 위해 <br> 상대방을 존중하는 댓글을 남겨주세요." --%>
<!-- 							name="cmtContent"></td> -->
						<td>
						<input type="submit" value="댓글 작성"></td>
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
<%@ include file="../Include/Footer.jsp"%>