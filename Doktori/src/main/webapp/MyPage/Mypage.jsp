<%@ include file="../Include/SubHeader.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="mypageArea">
	<div class="list_area">
		<ul class="my_list">
			<li class="my_list__item">
				<a href="">내 서재</a>
			</li>
			<li class="my_list__item">
				<a href="">관심 도서</a>
			</li>
			<li class="my_list__item">
				<a href="">예약 도서</a>
			</li>
			<li class="my_list__item">
				<a href="">내 정보</a>
			</li>
		</ul>
	</div>
	<div class="info_area">
		<span class="txt">OOO님 반갑습니다.</span>
		<button class="edit_button" type="button">내정보수정</button>
		<div class="my_img">
			<img src="../Images/expic.png">
		</div>
		<div class="my_info">
			<label>아이디
				<input type="text" name="id">
			</label>
			<label>닉네임
				<input type="text" name="nickname">
			</label>
			<label>비밀번호
				<input type="text" name="password">
			</label>
		</div>
	</div>
</div>
	
<%@ include file="../Include/Footer.jsp" %>