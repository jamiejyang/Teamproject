<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>
<body>
	<div class="main_wrap">
		<div class="header">
			<h1 class="title">DOKTORI</h1>
			<ul class="log_list">
				<li class="log_list__item"><a href="#">회원가입</a></li>
				<li class="log_list__item"><a href="#">로그인</a></li>
			</ul>
			<div class="main_visual">
				<ul class="nav_list">
					<li class="nav_list__item"><a href="#">도서관정보</a></li>
					<li class="nav_list__item"><a href="#">도서조회 / 예약</a></li>
					<li class="nav_list__item"><a href="#">도서관소식</a></li>
					<li class="nav_list__item"><a href="#">회원게시판</a></li>
				</ul>
				<div class="form_area">
					<form action="">
						<input class="search_area" type="text">
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
								<a href="#"> <img src="../images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../images/book.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#"> <img src="../images/book.jpg" alt="원피스">
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
			<div class="footer">
				<div class="inner">
					<ul class="footer_list">
						<li class="footer_list__item">대표자: 양은정, 구경미, 윤세윤, 박준혁</li>
						<li class="footer_list__item">상호명: 그린컴퓨터 아카데미 성남</li>
						<li class="footer_list__item">대표주소: 경기도 성남시 분당구 돌마로 46 KR 3층
							305호</li>
						<li class="footer_list__item">연락처: 031-712-7447</li>
						<li class="footer_list__item footer_list__item--bold">© 2022
							Green Computer Academy Seongnam</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- Swiper JS -->
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
		var swiper = new Swiper(".swiper", {
			slidesPerView : 3,
			spaceBetween : 30,
			freeMode : true,
			slidesPerView : 5,
			autoHeight : true,
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
			loop : true,
		});
	</script>
</body>
</html>