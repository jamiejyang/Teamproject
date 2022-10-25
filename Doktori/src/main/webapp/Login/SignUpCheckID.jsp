<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>SignUpCheckID.jsp</title>
</head>
<link rel="stylesheet" href="../Css/style.css">
<body>
   <div style="text-align: center">
   <h3> 아이디 중복확인 </h3>
    <form method="post" action="SignUpCheckIDProcess.jsp">
    아이디 : <input type="text" name="id" maxlength="10" autofocus value="<%=request.getParameter("user_id")%>">
    <input type="submit"  class="default_btn" value="중복확인">
    </form>
    </div>
 </body>
 </html>