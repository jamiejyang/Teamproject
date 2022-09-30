<%@page import="org.apache.tomcat.util.net.jsse.JSSESupport"%>
<%@page import="dto.LibDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.LibDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
LibDAO dao = new LibDAO(application);
// LibDTO dto = new LibDTO();
dao.libList();
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
String name[] = request.getParameterValues("searchLib");

if (searchWord.equals(null)) {
	// 	System.out.println("프로세스1");
} else if (searchWord != null) {
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
	// 	System.out.println("프로세스2");
}
if (name == null) {
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
	// 	System.out.println("프로세스3");
}
List<LibDTO> libLists = dao.libList();
List<LibDTO> bookLists = dao.Select(param, name);

int count = 0;
int totalCount = dao.selectCount(param, name);
dao.close();
session.setAttribute("totalCount", totalCount);
session.setAttribute("booklists", bookLists);
// request.getRequestDispatcher("BookList.jsp").forward(request, response);
response.sendRedirect("BookList.jsp");
%>

