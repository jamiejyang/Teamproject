<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dto.CommentDTO" %>
<%@ page import="dao.CommentDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../Css/reset.css">
<link rel="stylesheet" href="../Css/reset.css">

<title>댓글 수정</title>
</head>
<body>
	<%
	
	int num = 0;
	if (request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	int cmtNum = 0;
	if (request.getParameter("cmtNum") != null){
		cmtNum = Integer.parseInt(request.getParameter("cmtNum"));
	}
	CommentDAO dao = new CommentDAO();
	String cmtContent = dao.getUpdateComment(cmtNum);
	
	dao.close();
	%>
	<div class="container" align="center">
		<div class="col-lg-10">
			<div class="jumbotron" style="padding-top: 1px;">				
				<h3><br>댓글수정창</h3>
				<form name = c_commentUpdate>
					<input type="text" id="update" style="width:400px;height:50px;" maxlength=1024 value="<%= cmtContent %>">
					<input type="button" onclick="send(<%=num %>,<%=cmtNum %>)" value="수정">
					<br><br>
<!-- 					<input type="file" id="updatePicture" name="updatePicture"/>		 -->
				</form>
			</div>
		</div>
		<div class="col-lg-10"></div>
	</div>
</body>
<script>
// 	var upload = document.querySelector('#updatePicture');
// 	updatePicture.addEvent
	function send(num,cmtNum){
		var sb;
		var cmtContent = document.c_commentUpdate.update.value;
		sb = "CommentUpdateProcess.jsp?num="+num+"&cmtNum="+cmtNum+"&cmtContent="+cmtContent;
		window.opener.location.href= sb;
		window.close();
	}
</script>

</html>