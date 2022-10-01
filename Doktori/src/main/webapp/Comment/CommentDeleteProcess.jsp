<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.CommentDAO"%>
<%@ page import="dto.CommentDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File" %>
<%-- <% request.setCharacterEncoding("UTF-8");%> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
	<%
		String userId = null;
		if (session.getAttribute("UserId") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userId = (String) session.getAttribute("UserId");//유저아이디에 해당 세션값을 넣어준다.
		}
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = '../Login/LoginForm.jsp'");
			script.println("</script>");
		} 
		int num = 0;
		if (request.getParameter("num") != null){
			num = Integer.parseInt(request.getParameter("num"));
		}
		//댓글이 유효한지 판별
		int cmtNum = 0;
		if (request.getParameter("cmtNum") != null) {
			cmtNum = Integer.parseInt(request.getParameter("cmtNum"));
		}
		if (cmtNum == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		CommentDTO dto = new CommentDAO().getComment(cmtNum);
		if (!userId.equals(dto.getCmtid())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");				
		} else {
			CommentDAO dao = new CommentDAO();
			int result = dao.deleteComment(cmtNum);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 삭제에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				String real = "C:\\Users\\j8171\\Desktop\\studyhard\\JSP\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\BBS\\commentUpload";
				File delFile = new File(real+"\\"+num+"사진"+cmtNum+".jpg");
				if(delFile.exists()){
					delFile.delete();
				}
				script.println("<script>");
				script.println("location.href=document.referrer;"); //링크를 통해 현재 페이지로 이동 시킨, 전 페이지의 URI 정보를 반환.
				script.println("</script>");
			}
		}
		%>
</body>
</html>