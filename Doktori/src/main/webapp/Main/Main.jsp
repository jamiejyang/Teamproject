<%@page import="dto.ReviewDTO"%>
<%@page import="dto.SuggestDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dao.SuggestDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.NoticeDAO"%>
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	NoticeDAO ndao = new NoticeDAO();
	List<NoticeDTO> noticeLists = ndao.MainList();

	SuggestDAO sdao = new SuggestDAO();
	List<SuggestDTO> suggestLists= sdao.MainList();
	
	ReviewDAO rdao = new ReviewDAO();
	List<ReviewDTO> reviewLists= rdao.MainList();
	
	%>
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
			<h1 class="title"> <a href="Main.jsp"> <img alt="DOKTORI" src="../Images/doktori.png" style="width: 300px;"></a> </h1>
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
								<a href="../BookSearch/BookSearchProcess.jsp?searchField=title&searchWord=서랍에 저녁을 넣어 두었다"> <img src="../BookImg/서랍에저녁을넣어두었다.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="../BookSearch/BookSearchProcess.jsp?searchField=title&searchWord=보건교사 안은영"> <img src="../BookImg/보건교사안은영.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="../BookSearch/BookSearchProcess.jsp?searchField=title&searchWord=내게 무해한 사람"> <img src="../BookImg/내게무해한사람.jpg" alt="무해행..">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="../BookSearch/BookSearchProcess.jsp?searchField=title&searchWord=덧니가 보고 싶어"> <img src="../BookImg/덧니가보고싶어.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="../BookSearch/BookSearchProcess.jsp?searchField=title&searchWord=이만큼 가까이"> <img src="../BookImg/이만큼가까이.jpg" alt="원피스">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="../BookSearch/BookSearchProcess.jsp?searchField=title&searchWord=밝은 밤"> <img src="../BookImg/밝은밤.jpg" alt="원피스">
								</a>
							</div>
						</div>
					</div>
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
				</div>
				<div class="info_wrap">
					<div class="notice_area">
						<ul class="notice_list" style="width: 250px;">
							<li class="notice_list__item notice_list__item--first" >공지사항</li>
							<%for(NoticeDTO ndto : noticeLists ){
								%>
							<li class="notice_list__item" style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
							 <a href="../Notice/NoticeView.jsp?num=<%=ndto.getNum()%>">
								<%=ndto.getTitle() %>
							 </a> 
							</li>
							<%
							}
							ndao.close();
							%>
<!-- 							<li class="notice_list__item">이게 필요한가</li> -->
						</ul>
						
						<ul class="notice_list">
							<li class="notice_list__item notice_list__item--first">건의사항</li>
							<%for(SuggestDTO sdto : suggestLists ){
								%>
							<li class="notice_list__item" style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
							 <a href="../Suggest/SuggestView.jsp?num=<%=sdto.getNum()%>">
								<%=sdto.getTitle() %>
							 </a> 
							</li>
							<%
							}
							sdao.close();
							%>
						</ul>
						
						<ul class="notice_list" style="width: 250px;">
							<li class="notice_list__item notice_list__item--first">회원 게시판</li>
							<%for(ReviewDTO rdto : reviewLists ){
								%>
							<li class="notice_list__item" style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
							 <a href="../Review/ReviewView.jsp?num=<%=rdto.getNum()%>">
								<%=rdto.getTitle() %>
							 </a> 
							</li>
							<%
							}
							rdao.close();
							%>
						</ul>
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
<%@ include file="../Include/Footer.jsp" %>