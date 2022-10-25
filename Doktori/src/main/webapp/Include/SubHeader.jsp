<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("UserId") == null) {
		session.setAttribute("UserId", "guest");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOKTORI</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../Css/reset.css">
<link rel="stylesheet" href="../Css/style.css">
<script src="../Js/jquery-3.6.1.min.js"></script>
</head>
<body>
	<div class="sub_wrap">
		<div class="header">
			<h1 class="title" > <a href="../Main/Main.jsp">DOKTORI</a> </h1>
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
				<li class="log_list__item"><a href="../Login/Logout.jsp">로그아웃</a></li>
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
			</div>
		</div>
