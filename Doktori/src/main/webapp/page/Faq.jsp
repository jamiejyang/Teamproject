<%@ include file="../include/Subheader.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="faqArea">
	<ul class="faq_list">
		<li class="faq_list__item">
			<div class="faq_title">첫번째 질의응답</div>
			<div class="faq_content">그내용 ㅎㅎ</div>
		</li>
		<li class="faq_list__item">
			<div class="faq_title">abc</div>
			<div class="faq_content">abcabcabc</div>
		</li>
		<li class="faq_list__item">
			<div class="faq_title">abc</div>
			<div class="faq_content">abcabcabc</div>
		</li>
		<li class="faq_list__item">
			<div class="faq_title">abc</div>
			<div class="faq_content">abcabcabc</div>
		</li>
		<li class="faq_list__item">
			<div class="faq_title">abc</div>
			<div class="faq_content">abcabcabc</div>
		</li>
		<li class="faq_list__item">
			<div class="faq_title">abc</div>
			<div class="faq_content">abcabcabc</div>
		</li>
	</ul>
</div>
<script>
	$('.faq_list__item').click(function() {
		$(this).children('.faq_content').slideToggle();
	})
</script>


<%@ include file="../include/Footer.jsp" %>