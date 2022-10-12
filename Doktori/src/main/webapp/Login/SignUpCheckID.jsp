<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>SignUpCheckID.jsp</title>
</head>
<body>
   <div style="text-align: center">
   <h3>* 아이디 중복확인 *</h3>
    <form method="post" action="SignUpCheckIDProcess.jsp" onsubmit="return blankCheck(this)">
    아이디 : <input type="text" name="id" maxlength="10" autofocus value="<%=request.getParameter("user_id")%>">
    <input type="submit" value="중복확인">
    </form>
    </div>
    
    <script>
    function blankCheck(f){
       var id=f.id.value;
        id=id.trim();
        if(id.length<5){
           alert("아이디는 5자 이상 입력해주십시오.");
           if 
           return false;
        }//if end
        return true;
    }//blankCheck() end
    </script>
 </body>
 </html>