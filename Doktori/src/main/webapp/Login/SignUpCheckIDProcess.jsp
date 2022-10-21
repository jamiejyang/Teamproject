<%@page import="java.util.regex.Pattern"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignUpCheckIDProcess.jsp</title>
</head>
<body>
   <div style="text-align: center"></div>
   <h3>* 아이디 중복 확인 결과 *</h3>
<%
MemberDAO dao = new MemberDAO();

    //1) 사용가능한 아이디일 경우, 아이디 입력 폼에 넣기 위함
    String id=request.getParameter("id");
    String pattern = "^[0-9|a-z|A-Z|\s]*$";
    boolean cnt = dao.checkID(id);
    out.println("입력 ID : <strong>" + id + "</stong>");
    
    if(id.replaceAll(" ", "").equals("")){
        out.println("<p style='color: red'>아이디를 입력해주세요.</p>");
    }else if(id.length()<5){
        out.println("<p style='color: red'>아이디는 5글자 이상 입력해주세요.</p>");
        
    }else if(!Pattern.matches(pattern, id)){
        out.println("<p style='color: red'>아이디는 특수문자나 한글을 제외하고 입력해주세요.</p>");
    	
    }else if(cnt&&!id.equals("guest")){
       out.println("<p>사용 가능한 아이디입니다.</p>");
       out.println("<a href='javascript:apply(\"" + id + "\")'>[적용]</a>");
%>

   <script>

       function apply(id){
            //2) 중복확인 id를 부모창에 적용
            //부모창 opener
            opener.document.regForm.checkid.value="idCheck";
            opener.document.regForm.user_id.value=id;
            window.close(); //창닫기
        }//apply () end
        
    </script>
 <%
    }else {
       out.println("<p style='color: red'>해당 아이디는 사용하실 수 없습니다.</p>");
    }//if end
    dao.close();
 %>
 <hr>
 <a href="javascript:history.back()">[다시시도]</a>
 &nbsp; &nbsp;
 <a href="javascript:window.close()">[창닫기]</a>
 
 </body>
 </html>