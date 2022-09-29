<%@page import="java.io.File"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDAO"%>
<%@ page import="dto.NoticeDTO"%>

<%
String num = request.getParameter("num");
NoticeDTO dto = new NoticeDTO();
NoticeDAO dao = new NoticeDAO(application);
dto = dao.selectView(num);

String sessionId = session.getAttribute("UserId").toString();
String fileName = dto.getFiles();
String saveDirectory = application.getRealPath("/Uploads");
File file = new File(saveDirectory + File.separator + fileName);
int delResult = 0;

if (sessionId.equals("admin")) {
	dto.setNum(num);
	delResult = dao.deletePost(dto);
	dao.close();
	if (file.exists()) {
		file.delete();
	}
	if (delResult == 1) {
		JSFunction.alertLocation("해당 글이 삭제되었습니다.", "NoticeList.jsp", out);
	} else {
		JSFunction.alertBack("삭제 실패.", out);
	}
} else {
	JSFunction.alertBack("비 정상적 접근 입니다.", out);

	return;
}
%>
<!DOCTYPE html>