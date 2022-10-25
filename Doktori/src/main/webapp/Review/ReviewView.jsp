<%@ include file="../Include/SubHeader.jsp"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="dao.CommentDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.PrintWriter"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   String userId = null;
   if(session.getAttribute("UserId") != null){
      userId = (String) session.getAttribute("UserId");
   }
   int num = 0;
   if (request.getParameter("num") != null){
      num = Integer.parseInt(request.getParameter("num"));
   }
   if (num == 0){
      JSFunction.alertLocation("유효하지 않은 글입니다.", "../Login/LoginForm.jsp", out);
   }
   ReviewDAO dao = new ReviewDAO();
   dao.updateReadCount(num);
   ReviewDTO dto = dao.selectView(num);//여기서 num은 bbsnum
   CommentDAO cdao = new CommentDAO();
   CommentDTO cmt = cdao.getComment(num);
   dao.close();
   
%>

<script type="text/javascript">
function deletePost(){
   var confirmed = confirm("정말로 삭제하시겠습니까?");
   if(confirmed){
      var form = document.writeFrm1;
      form.method = "post";
      form.action = "ReviewDeleteProcess.jsp";
      form.submit();
   }
}

function adminDeletePost(){
	   var confirmed = confirm("관리자 권한: 게시글을 삭제하시겠습니까?");
	   if(confirmed){
	      var form = document.writeFrm1;
	      form.method = "post";
	      form.action = "ReviewDeleteProcess.jsp";
	      form.submit();
	   }
	}
	
function nwindow(num,cmtNum){
    window.name = "commentParant";
    var url= "../Comment/CommentUpdate.jsp?&num="+num+"&cmtNum="+cmtNum;
    window.open(url,"댓글 수정하기","width=600,height=230,left=300,resizable=no");
 }
</script>
   
<link rel="stylesheet" type="text/css" href="../Css/shopping.css">
<div style="width: 1400px; margin: 0 auto;">
   <form name="writeFrm1">
      <input type="hidden" name="num" value="<%= num %>" />
      <table>
         <tr>
            <th>번호</th>
            <td><%= dto.getNum() %></td>
            <th>작성자</th>
            <td><%= dto.getId() %></td>
         </tr>
         <tr>
            <th>작성일</th>
            <td><%= dto.getWritedate() %></td>
            <th>조회수</th>
            <td><%= dto.getReadcount() %></td>
         </tr>
         <tr>
            <th>제목</th>
            <td colspan="3"><%= dto.getTitle() %></td>
         </tr>
         <tr>
            <th>내용</th>
            <td colspan="3" height="100"><%= dto.getContent().replace("\r\n", "<br/>") %></td>
         </tr>
         <tr>
            <th>첨부파일</th>
            <td colspan="3" height="100">
            	<img alt="" style="height: auto; width: 40%" src="../Uploads/<%=dto.getSfile()%>">
            </td>
         </tr>
         <tr>
            <td colspan="4" align="center">
               <%
                    if(session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())&& !session.getAttribute("UserId").toString().equals("admin")){
                    %>
                     <button class="default_btn" type="button"
                        onclick="location.href='ReviewEdit.jsp?num=<%= dto.getNum() %>';">수정하기</button>
                     <button class="default_btn" type="button" onclick="deletePost();">삭제하기</button>
               <%
                  }
                  %>
                  
                  <%
                    if(session.getAttribute("UserId").toString().equals("admin")){
                    %>
                     <button class="default_btn" type="button" onclick="adminDeletePost();">삭제하기</button>
               <%
                  }
                  %>
                
                     <button class="default_btn" type="button" onclick="location.href='ReviewList.jsp';">목록보기</button>
            </td>
          </tr>
      </table>
   </form>
   
   
    <!-- 댓글리스트 -->
   <div  align="center" >
         <p align="left"  bgcolor="beige">댓글 목록</p>
      <table style="text-align: center; border: 1px solid #dddddd" >
         <tbody>
            <%
               ArrayList<CommentDTO> list = cdao.getList(num); 
               cdao.close(); 
               
               for(int i=0; i<list.size(); i++) {
            %>
			<!-- 컨테이너 하나당 댓글 하나씩 보여줌 -->
            <tr> 
            	<td align="left" style="width:10%; font-weight: bold;"><%= list.get(i).getCmtid() %></td>   
            	<td colspan="2" align="left" style="width:20%;"> <%= list.get(i).getCmtdate().substring(0,11) + list.get(i).getCmtdate().substring(11,13) + "시" + list.get(i).getCmtdate().substring(14,16) + "분" %></td>
            	<td align="right">
					<!--  댓글 쓴사람과 지금 유저가 같으면 수정과 삭제를 가능하게 함 -->
	                <%
	                if(list.get(i).getCmtid() != null && list.get(i).getCmtid().equals(session.getAttribute("UserId")) && !userId.equals("admin")){   
	                %>
	                   <form name = "p_search">
	                      <button class="nonebg_btn" type="button" onclick="nwindow(<%=num %>,<%=list.get(i).getCmtnum()%>)">수정</button>
	                   </form>   
                       <a onclick="return confirm('댓글을 삭제하시겠습니까?')" href="../Comment/CommentDeleteProcess.jsp?num=<%=num%>&cmtNum=<%= list.get(i).getCmtnum() %>" >삭제</a>                                                   
                    <%
                    }
                    %>   
					<!-- 어드민일 경우 댓글 삭제 가능(수정은 불가) -->
                    <%
                    if(userId.equals("admin")){  
                    %>
                       <a onclick="return confirm('관리자 기능: 댓글을 삭제하시겠습니까?')" href = "../Comment/CommentDeleteProcess.jsp?num=<%=num%>&cmtNum=<%= list.get(i).getCmtnum() %>" >삭제</a>                                                   
                    <%
                    }
                    %>   
                 </td>
            </tr>
			<tr>
			   <td colspan="4" align="left">
			   	<%= list.get(i).getCmtcontent().replace("\r\n", "<br/>") %>
			   </td>
			</tr>
            <%
               }
            %>
          </tbody>
      </table>
	</div>
   
   

   <!--  댓글작성부분 폼을 넘겨주는 방식 -->
   <div  align="center" >
<!--       <div class="form-group" > -->
         <!--게시물번호를 넘긴다(bbsid) -->
         <form method="post" name="writeFrm" action="../Comment/CommentWriteProcess.jsp?num=<%=num %>">  
            <input type="hidden" name="num" value="<%=num%>" />
            <table style="text-align: center; border: 1px solid #dddddd">
               <tr>
                  <td style="width: 15%; border-bottom: none; font-weight: bold;" valign="middle">
                  <%=session.getAttribute("UserId")%>
                  </td> 
                  <td style="width: 70%; height:100px;">
                  <textarea class="form-control" style="width: 100%; height: 75px" placeholder="건강한 토론문화를 위해 상대방을 존중하는 댓글을 남겨주세요." name="cmtContent">
                  </textarea> 
                  </td>
                  <td>
                  <input class="default_btn" type="submit" value="댓글 작성">
                  </td>
               </tr>
            </table>
         </form>
<!--       </div> -->
   </div>
   
</div>
<%@ include file="../Include/Footer.jsp"%>