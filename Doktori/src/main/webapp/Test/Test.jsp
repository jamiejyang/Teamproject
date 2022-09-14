<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB table</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
</head>
<body>

<div align="center">
<h1> 테이블 테스트</h1>
	<table style="border: 1;">
			<tr>
				<th style="width: 30%;">책 이름</th>
				<th>책 정보</th>
			</tr>
			<c:forEach var="booklist" items="${bookList}"></c:forEach>
			<tr class="record">
				<td> ${booklist.title}</td>
<!-- 				<td> -->
<!-- 				책 레코드 키 : <br> -->
<!-- 				종 레코드 키 :<br> -->
<!-- 				소장 도서관 : <br> -->
<!-- 				소정 도서관 : <br> -->
<!-- 				등록 번호 : <br> -->
<!-- 				제어 번호 : <br> -->
<!-- 				청구 기호 : <br>  -->
<!-- 				소장 자료실명 : <br> -->
<!-- 				표제 : <br> -->
<!-- 				저작자 : <br> -->
<!-- 				발행자 : <br> -->
<!-- 				발행년도 : <br> -->
<!-- 				ISBN : <br> -->
<!-- 				</td> -->
			</tr>
	</table>
</div>
</body>
</html>