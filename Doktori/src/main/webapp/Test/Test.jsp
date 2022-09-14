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
			<c:forEach var="book" items="${bookList}">
			<tr class="record">
				<td> ${book.title}</td>
				<td>
				책 레코드 키 : ${book.bookKey } <br>
				종 레코드 키 : ${book.speciesKey }<br>
				소장 도서관 : ${book.libName }<br>
				소정 도서관 : ${book.manageCode }<br>
				등록 번호 : ${book.regNo }<br>
				제어 번호 : ${book.controlNo }<br>
				청구 기호 : ${book.callNo }<br> 
				소장 자료실명 : ${book.shelfLocName }<br>
				저작자 : ${book.author }<br>
				발행자 : ${book.publisher }<br>
				발행년도 : ${book.pubYear }<br>
				ISBN : ${book.isbn }<br>
				</td>
			</tr>
			</c:forEach>
	</table>
</div>
</body>
</html>