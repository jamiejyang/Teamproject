<%@page import="dao.LikesDAO"%>
<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
MemberDAO dao = new MemberDAO();
MemberDTO dto = new MemberDTO();
LikesDAO ldao = new LikesDAO();
String mid[];
String id;
int result = 0;
if (request.getParameterValues("mid") == null && request.getParameter("id") == null) {
	JSFunction.alertBack("회원 선택을 해야 탈퇴가 가능합니다.", out);
} else if (request.getParameterValues("mid") != null) {
	mid = request.getParameterValues("mid");
	result = ldao.AdmindeleteLike(mid);
	result = dao.deleteAdmin(mid);
	dao.close();
	ldao.close();
	if (result != 0) {
		JSFunction.alertLocation("회원탈퇴 성공.", "AdminPage.jsp", out);
	} else {
		JSFunction.alertBack(" 회원 탈퇴 실패.", out);

	}

} else {
	id = request.getParameter("id");
	result = dao.deleteMember(id);
	dao.close();
	if (result == 1) {
		session.removeAttribute("UserId");
		session.removeAttribute("UserName");
		JSFunction.alertLocation("회원님의탈퇴가 완료되었습니다.", "../Login/LoginForm.jsp", out);

	}
	JSFunction.alertBack(" 회원 탈퇴 중 오류가 발생하였습니다.", out);
}
%>
<!DOCTYPE html>
