<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/admin_check.jspf" %>

<%
	if(request.getParameter("qno")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	//전달값을 반환받아 저장
	int qno=Integer.parseInt(request.getParameter("qno"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");

	//글번호를 전달받아 QNA 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	QnaDTO qna=QnaDAO.getDAO().selectQna(qno);
	
	//검색된 게시글이 없거나 삭제된 게시글인 경우 에러 페이지로 이동 - 비정상적 요청
		if(qna==null || qna.getQstatus()==0) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='index.jsp?workgroup=error&work=error_400';");
			out.println("</script>");
			return;		
		}	
		
		//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 에러 페이지로 이동 - 비정상적 요청
		if(loginMember.getStatus()!=9) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='index.jsp?workgroup=error&work=error_400';");
			out.println("</script>");
			return;			
		}
		
		List<ProductDTO> productlist = QnaDAO.getDAO().selectProductnotnullList();
		ProductDTO product = ProductDAO.getDAO().selectProduct(qna.getQpno());
%>

<style type="text/css">
#answer {
	overflow : scroll ;
	width : 500px;
	height : 200px;
	padding : 20px;
	margin : 10px;
}

  table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    border-left: 1px solid #444444;
    padding: 10px;
  }
  th:first-child, td:first-child {
    border-left: none;
  }
  
caption {
	margin-bottom: 10px;
	margin-top: 10px;
	font-size : 15px;
}

.answerr {
	border : none;
}

#answerr {
	border : none;
	margin-right: 690px;
}

#qanswerwrite {
background-color: white ;
border : 1px solid black;
padding : 5px;
}


</style>

<div id="qna_detail">
<br>
	<table>
	<caption>고객 문의 내용</caption>
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
	</table>
</div>


<form action="index.jsp?workgroup=qna&work=qna_answer_action" method="post" id="qanswerForm">
		<input type="hidden" name="qno" value="<%=qna.getQno()%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
		
		<table id="answerr">
		<tr class="answerr">
			<th class="answerr">답변 작성</th>
			<td class="answerr">
				<textarea name="answer" id="answer">
				</textarea>
			</td>
		</tr>
		</table>
<center>
<button type="submit" id="qanswerwrite">
답변 작성 완료</button>
</center>
</form>


	
<script type="text/javascript">
$("#qanswerForm").submit(function() {
	if($("#answer").val()=="") {
		alert("답변을 입력해 주세요.");
		$("#answer").focus();
		return false;
	});


</script>

