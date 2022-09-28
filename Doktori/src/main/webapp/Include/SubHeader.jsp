<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Css/reset.css">
<link rel="stylesheet" href="../Css/style.css">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="../Js/jquery-3.6.1.min.js"></script>
</head>
<body>
	<div class="sub_wrap">
		<div class="header">
			<h1 class="title">DOKTORI</h1>
			<ul class="log_list">
				<li class="log_list__item"><a href="../Login/SignUp.jsp">회원가입</a></li>
				

<!-- // 				// 메인 페이지로 이동 했을때 세션에 값이 담겨있는지 체크 -->
<!-- // 				String UserId = null; -->
<!-- // 				if(session.getAttribute("board_id") != null){ -->
<!-- // 				   UserId = (String)session.getAttribute("board_id"); -->
<!-- // 				} -->


			<% if(session.getAttribute("UserId")==null|| session.getAttribute("UserId").equals("guest")){%>
	<li class="log_list__item"><a href="../Login/LoginForm.jsp">로그인</a></li>
	<%} else { %>
	<li class="log_list__item"><a href="../Login/Logout.jsp" class="log_list__item">로그아웃</a></li>
	<% } %>
			</ul>
			<div class="main_visual">
				<ul class="nav_list">
					<li class="nav_list__item"><a href="#">도서관정보</a></li>
					<li class="nav_list__item"><a href="#">도서조회 / 예약</a></li>
					<li class="nav_list__item"><a href="#">도서관소식</a></li>
					<li class="nav_list__item"><a href="../Review/ReviewList.jsp">회원게시판</a></li> 
				</ul>
			</div>
		</div>
	</div>