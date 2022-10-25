<%@page import="dto.FaqDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.FaqDAO"%>
<%@ include file="../Include/SubHeader.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
FaqDAO dao = new FaqDAO(application);
List<FaqDTO> faqLists = dao.selectFaq();
%>
<script type="text/javascript">
	function deletePost() {
		var confirmed = confirm("정말로 삭제하시겠습니까?");
		if (confirmed) {
			return true;
		}
		return false;
	}
</script>
<div class="faqArea">

	<ul class="faq_list">
		<%
		for (FaqDTO dto : faqLists) {
		%>
		<li class="faq_list__item">
			<form class="list_form" name="Frm" method="post" action="DeleteProcess.jsp" onsubmit="deletePost();">
				<div class="faq_title">
					<%=dto.getQu()%>
					<%
					if (session.getAttribute("UserId").equals("admin")) {
					%>
					<input type="hidden" name="num" value="<%=dto.getNum()%>" />
					<button type="button" onclick="location.href='FaqEdit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
					<button type="submit">삭제하기</button>
					<%
					}
					%>
				</div>
				
				<div class="faq_content">
					<%=dto.getAn().replace("\r\n", "<br/>")%>
				</div>
			</form>
		</li>
		<%
		}
		%>
	</ul>

	<%
	if (session.getAttribute("UserId").equals("admin")) {
	%>
	<button type="button" class="write_button"
		onclick="location.href='FaqWrite.jsp';">글쓰기</button>
	<%
	}
	%>
</div>
<script>
	$('.list_form').click(function() {
		$(this).children('.faq_content').slideToggle();
	})
</script>


<%@ include file="../Include/Footer.jsp"%>