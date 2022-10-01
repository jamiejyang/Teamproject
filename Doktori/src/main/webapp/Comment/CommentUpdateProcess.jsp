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
<title>Insert title here</title>

<script type="text/javascript">
	window.name='commentUpdate';
</script>

</head>
<body>

	<%

		String userId = null;
		if (session.getAttribute("UserId") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userId = (String) session.getAttribute("UserId");//유저아이디에 해당 세션값을 넣어준다.
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = '../Login/LoginForm.jsp'");
			script.println("</script>");
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
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'ReviewView.jsp'");
			script.println("</script>");
		}
		CommentDTO dto = new CommentDAO().getComment(cmtNum);
		if (!userId.equals(dto.getCmtid())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'ReviewView.jsp'");
			script.println("</script>");				
		} else {
	 		if (dto.getCmtcontent().equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				CommentDAO dao = new CommentDAO();
				int result = dao.updateComment(cmtNum, cmtContent);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
// 					script.println("location.href='../Review/ReviewView.jsp?num="+num+"'");
					script.println("location.href= \'ReviewView.jsp?num="+num+"\'");
					script.println("</script>");
				}
				dao.close();
			}
		}
	%>
</body>
</html>