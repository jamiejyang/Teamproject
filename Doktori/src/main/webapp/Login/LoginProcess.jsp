<%@ page import="dto.MemberDTO"%>
<%@ page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%


String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");
String userName = request.getParameter("user_name");
System.out.print(userName);

MemberDAO dao = new MemberDAO();
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd, userName);
dao.close();

String UserId = null;

if (session.getAttribute("UserId") != null) {
	UserId = (String) session.getAttribute("UserId");
}
if (memberDTO.getId() != null) {
	session.setAttribute("UserId", memberDTO.getId());
	session.setAttribute("UserPwd", memberDTO.getPass());
	session.setAttribute("UserName", memberDTO.getName());
	response.sendRedirect("LoginForm.jsp");
} else {
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
}
%>