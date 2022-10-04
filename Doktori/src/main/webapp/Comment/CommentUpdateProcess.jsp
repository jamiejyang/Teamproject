<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="dao.CommentDAO"%>
<%@ page import="dto.CommentDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%-- <%request.setCharacterEncoding("UTF-8");%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript">
	window.name='commentUpdate';
</script>

</head>
<body>

	<%

		String userId = null;
		if (session.getAttribute("UserId") != null) {
			userId = (String) session.getAttribute("UserId");
		} else {
			JSFunction.alertLocation("로그인을 해주세요", "../Login/LoginForm.jsp", out);
		} 
		
		int cmtNum = 0;
		if (request.getParameter("cmtNum") != null){
			cmtNum = Integer.parseInt(request.getParameter("cmtNum"));
		}
		String cmtContent = null;
		if (request.getParameter("cmtContent")!=null){
			cmtContent = request.getParameter("cmtContent");
		}
		
		//글이 유효한지 판별
		int num = 0;
		if (request.getParameter("num") != null) {
			num = Integer.parseInt(request.getParameter("num"));
		}
		if (num == 0) {
			JSFunction.alertLocation("유효하지 않은 글입니다.", "../Review/ReviewView.jsp", out);
		}
		
		CommentDAO dao = new CommentDAO();
		CommentDTO dto = dao.getComment(cmtNum);
		
		if (!userId.equals(dto.getCmtid())) {
			JSFunction.alertLocation("권한이 없습니다.", "../Review/ReviewView.jsp", out);
		} else {
	 		if (dto.getCmtcontent().equals("")){
	 			JSFunction.alertBack("댓글을 입력해주세요.", out);
				
			} else {
				int result = dao.updateComment(cmtNum, cmtContent);
				if (result == -1) {
					JSFunction.alertBack("글 수정에 실패하였습니다.", out);
				} else {
					JSFunction.alertLocation("댓글을 수정하였습니다.", "../Review/ReviewView.jsp?num="+num, out);
// 					script.println("location.href='../Review/ReviewView.jsp?num="+num+"'");
				
				}
				dao.close();
			}
		}
	%>
</body>
</html>