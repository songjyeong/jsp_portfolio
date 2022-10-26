<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%--  
// 비로그인 사용자인 경우에, 글번호/페이지번호/검색대상/검색단어 가지고
// 로그인 페이지 이동했다가, 회원인증(로그인)되면 
// 다시 전달값 가지고 detail 페이지로 되돌아옴 (로그인 사용자만 QNA 볼 수 있음)--%>
	
<%@include file="/security/login_url.jspf" %>

<%
	if(request.getParameter("qno")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	int qno=Integer.parseInt(request.getParameter("qno"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	QnaDTO qna = QnaDAO.getDAO().selectQna(qno);
	
	if(qna==null || qna.getQstatus()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}

	
	if(qna.getQstatus()==2) {//비밀 게시글인 경우
		//비로그인 사용자이거나 로그인 사용자가 게시글 작성자 또는 관리자가 아닌 경우 에러 페이지 이동
		if(loginMember==null || !loginMember.getId().equals(qna.getQwriter()) && loginMember.getStatus()!=9) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='index.jsp?workgroup=error&work=error_400';");
			out.println("</script>");
			return;	
		}
	}
	
	ProductDTO product = ProductDAO.getDAO().selectProduct(qna.getQpno());
		
%>

<style type="text/css">
  table {
	margin: 5px auto;
    border-top: 1px solid gray;
    border-collapse: collapse;
  }
  
  th, td {
    border-bottom: 1px solid gray;
    padding: 10px;
    text-align: center;
  }
  
  .butttt {
 background-color: white ;
border : 1px solid black;
padding : 5px;
  }
  
</style>


<div id="qna_detail">
<br><br><br><br>
	<table>
		<tr>
			<th>문의 상품</th>
			<%-- 문의 상품의 상품번호로 문의 상품의 이름, 가격, 상세페이지 출력 --%>
			<td><%=product.getSname()%>/<%=product.getSoptionFirst()%>/<%=product.getSoptionSecond()%>_<%=product.getSprice() %>원</td>
		</tr>
	
		<tr>
			<th>제목</th>
			<td><%=qna.getQtitle() %></td>
		</tr>
		
		<tr>
			<th>작성자</th>
			<td><%=qna.getQwriter().substring(0,3) %><%=qna.getQwriter().substring(3).replaceAll(".", "*") %></td>
		</tr>
		
		<tr>
			<th>작성일</th>
			<td><%=qna.getQdate() %></td>
		</tr>
		
		
		<tr>
			<th>문의 내용</th>
			<td><%=qna.getQcontent().replace("\n", "<br>") %></td>
		</tr>
	
		<%-- 답변인 경우에는 qna.getQanswer 보여주기 !!!!
				답변이 달린 글인 경우, 질문글이든 답변글이든 클릭했을 때, 질문글+답글 둘 다 보내줌 --%>
		<% if (qna.getQanswer()!=null) { %>
		<tr>
			<th>답변</th>
			<td><%=qna.getQanswer() %></td>
		</tr>
		<% } %>
	</table>
</div>
<br>
<center>
<div id="qna_menu">
		<button type="button" id="listBtn" class="butttt">목록</button>
	<% if(loginMember!=null && (loginMember.getId().equals(qna.getQwriter()))) {//로그인 사용자 중 게시글 작성자인 경우 %>	
		<button type="button" id="modifyBtn" class="butttt">수정</button>	
		<button type="button" id="removeBtn" class="butttt">삭제</button>
	<% } %>
	
	<% if(loginMember.getStatus()==9) {//관리자인 경우 %>	
		<button type="button" id="replyBtn" class="butttt">답글쓰기</button>	
		<button type="button" id="removeBtn" class="butttt">삭제</button>
	<% } %>
</div>
</center>

<%-- 요청 페이지로 값을 전달하기 위한 form 태그 --%>
	<form method="post" id="menuForm">
		<%-- [수정] 및 [삭제]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="qno" value="<%=qna.getQno()%>">

		<%-- [답글]를 클릭한 경우 전달되는 값 --%>
		
		
		<%-- [수정] 및 [목록]을 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
	</form>

	<script type="text/javascript">
$("#modifyBtn").click(function() {
	$("#menuForm").attr("action","index.jsp?workgroup=qna&work=qna_modify");
	$("#menuForm").submit();
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {	
		$("#menuForm").attr("action","index.jsp?workgroup=qna&work=qna_remove_action");
		$("#menuForm").submit();
	}
});

$("#replyBtn").click(function() {
	$("#menuForm").attr("action","index.jsp?workgroup=qna&work=qna_answer");
	$("#menuForm").submit();
});

$("#listBtn").click(function() {
	$("#menuForm").attr("action","index.jsp?workgroup=qna&work=qna_list");
	$("#menuForm").submit();
});
</script>
