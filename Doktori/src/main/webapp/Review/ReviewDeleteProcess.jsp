<%@page import="java.io.File"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%
int num = Integer.parseInt(request.getParameter("num"));

ReviewDTO dto = new ReviewDTO();
ReviewDAO dao = new ReviewDAO();
dto = dao.selectView(num);
// dao.close();


String sessionId = session.getAttribute("UserId").toString();
String fileName = dto.getFiles();
String saveDirectory = application.getRealPath("../Uploads");
File file = new File(saveDirectory + File.separator + fileName);

int delResult = 0;

if (sessionId.equals(dto.getId()) || session.getAttribute("UserId").equals("admin")) {
	dto.setNum(num);
	delResult = dao.deletePost(dto);
	dao.close();

	if(file.exists()) {
		file.delete();
	}
	if (delResult == 1) {
		
		JSFunction.alertLocation("글이 삭제되었습니다.", "ReviewList.jsp", out);
	} else {

		JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}
	dao.close();
} else {
	JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);

	
	return;
}
%>