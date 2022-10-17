<%@ page import="dto.MemberDTO"%>
<%@ page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String userName = request.getParameter("user_name");
String userNickname = request.getParameter("user_nickname");
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");


MemberDAO dao = new MemberDAO();
MemberDTO memberDTO = new MemberDTO(userName, userNickname, userId, userPwd);

int result = dao.insertMemberDTO(memberDTO);
dao.close();

if (result == 1) {
	response.sendRedirect("LoginForm.jsp");
} else {
	request.setAttribute("SignUpErrMsg", "회원가입 오류입니다.");
	request.getRequestDispatcher("SignUp.jsp").forward(request, response);
}
%>