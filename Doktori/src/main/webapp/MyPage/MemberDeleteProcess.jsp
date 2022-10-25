<%@page import="dao.CommentDAO"%>
<%@page import="dao.SuggestDAO"%>
<%@page import="oracle.net.resolver.TimeUnitSuffixUtility"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dao.ReserveDAO"%>
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
ReserveDAO rdao = new ReserveDAO();
ReviewDAO vdao = new ReviewDAO();
SuggestDAO sdao = new SuggestDAO();
CommentDAO cdao = new CommentDAO();
String mid[];
int result = 0;
if (request.getParameterValues("mid") == null && request.getParameter("id") == null) {
	JSFunction.alertBack("회원 선택을 해야 탈퇴가 가능합니다.", out);
} else if (request.getParameterValues("mid") != null) {
	mid = request.getParameterValues("mid");
	// 관심도서 삭제
	result = ldao.AdmindeleteLike(mid);
	ldao.close();
	// 예약도서 삭제
	result= rdao.AdmindeleteReserve(mid);
	rdao.close();
	
	// 건의사항 삭제
	result = sdao.Admindelete(mid);
	sdao.close();
	// 리뷰 댓글 삭제 
	result = cdao.deleteAdmin(mid);
	cdao.close();
	//회원게시판 삭제 
	result = vdao.AdmindeleteReview(mid);
	vdao.close();
	
	
	
	
	// 후 아이디 삭제
	result = dao.deleteAdmin(mid);
	dao.close();
	if (result != 0) {
		session.removeAttribute("UserId");
		session.removeAttribute("UserName");
		JSFunction.alertLocation("회원탈퇴 성공.", "../", out);
	} else {
		JSFunction.alertBack(" 회원 탈퇴 실패.", out);

	}

} else {
	mid = request.getParameterValues("mid");
	
	result = ldao.AdmindeleteLike(mid);
	ldao.close();
	// 예약도서 삭제
	result= rdao.AdmindeleteReserve(mid);
	rdao.close();
	
	// 건의사항 삭제
	result = sdao.Admindelete(mid);
	sdao.close();
	//회원게시판 삭제 
	result = vdao.AdmindeleteReview(mid);
	vdao.close();
	result = dao.deleteAdmin(mid);
	dao.close();
	if (result == 1) {
		session.removeAttribute("UserId");
		session.removeAttribute("UserName");
		JSFunction.alertLocation("회원님의탈퇴가 완료되었습니다.", "../", out);

	}
	JSFunction.alertBack(" 회원 탈퇴 중 오류가 발생하였습니다.", out);
}
%>
<!DOCTYPE html>
