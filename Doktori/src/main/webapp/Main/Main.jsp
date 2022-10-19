<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOKTORI</title>
<link rel="stylesheet" href="../Css/reset.css">
<link rel="stylesheet" href="../Css/style.css">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>
<body>
	<div class="main_wrap">
		<div class="header">
			<h1 class="title">DOKTORI</h1>
			<ul class="log_list">
				<%
				if (session.getAttribute("UserId") == null || session.getAttribute("UserId").equals("guest")) {
				%>
				<li class="log_list__item"><a href="../Login/SignUp.jsp">회원가입</a></li>
				<%
				} else if (session.getAttribute("UserId").equals("admin")) {
				%>
				
				<li class="log_list__item"><a href="../MyPage/AdminPage.jsp">회원정보확인</a></li>
				<%
				} else {
				%>

				<li class="log_list__item"><a href="../MyPage/Mypage.jsp">마이페이지</a></li>
				<%
				}
				%>


				<%
				if (session.getAttribute("UserId") == null || session.getAttribute("UserId").equals("guest")) {
				%>
				<li class="log_list__item"><a href="../Login/LoginForm.jsp">로그인</a></li>
				<%
				} else {
				%>
				<li class="log_list__item"><a href="../Login/Logout.jsp"
					class="log_list__item">로그아웃</a></li>
				<%
				}
				%>
			</ul>
			<div class="main_visual">
				<ul class="nav_list">

					<li class="nav_list__item"><a href="../LibInfo/LibInfoMain.jsp">도서관정보</a></li>
					<li class="nav_list__item"><a href="../BookSearch/BookList.jsp">도서조회 / 예약</a></li>
					<li class="nav_list__item nav_list__item--hasSub">
						<a href="#">도서관소식</a>
						<div class="list_wrap">
							<ul class="item_list">
								<li class="item_list__item">
									<a href="../Notice/NoticeList.jsp">공지사항</a>
								</li>
								<li class="item_list__item">
									<a href="../Faq/Faq.jsp">FAQ</a>
								</li>
								<li class="item_list__item">
									<a href="../Suggest/SuggestList.jsp">건의사항</a>
								</li>
							</ul>
						</div>
					</li>
					<li class="nav_list__item"><a href="../Review/ReviewList.jsp">회원게시판</a></li>
				</ul>
				<div class="form_area">
					<form action="../BookSearch/BookSearchProcess.jsp">
						<input type="hidden" name="searchField" value="title">
						<input class="search_area" type="text" name="searchWord">
						<button type="submit" class="search_button">
							<span class="blind">찾기</span>
						</button>
					</form>
				</div>
			</div>
		</div>
		<div class="main_contents">
			<div class="inner">
				<div class="slide_wrap">
					<h2 class="slide_title">오늘의 추천도서</h2>
					<!-- Slider main container -->
					<div class="swiper">
						<!-- Additional required wrapper -->
						<div class="swiper-wrapper">
							<!-- Slides -->
							<div class="swiper-slide">
<!-- 									도서 찾기  -->
								<a href="../BookSearch/BookSearchProcess.jsp?searchField=title&searchWord=이오덕"> <img src="../Images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../Images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../Images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../Images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../Images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../Images/book.jpg" alt="원피스">
								</a>
							</div>
						</div>
					</div>
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
				</div>
				<div class="info_wrap">
					<div class="notice_area">
						<ul class="notice_list">
							<li class="notice_list__item notice_list__item--first">오늘의
								리뷰</li>
							<li class="notice_list__item">게시글<span class="number">1</span></li>
							<li class="notice_list__item">공지사항</li>
						</ul>
						<ul class="notice_list">
							<li class="notice_list__item notice_list__item--first">오늘의
								리뷰</li>
							<li class="notice_list__item">게시글<span class="number">1</span></li>
							<li class="notice_list__item">공지사항</li>
						</ul>
						<ul class="notice_list">
							<li class="notice_list__item notice_list__item--first">오늘의
								리뷰</li>
							<li class="notice_list__item">게시글<span class="number">1</span></li>
							<li class="notice_list__item">공지사항</li>
						</ul>
					</div>
				</div>
			</div>
<%@ include file="../Include/Footer.jsp" %>