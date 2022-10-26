<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_check.jspf" %>

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
		if(!loginMember.getId().equals(qna.getQwriter()) && loginMember.getStatus()!=9) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='index.jsp?workgroup=error&work=error_400';");
			out.println("</script>");
			return;			
		}
		
		List<ProductDTO> productlist = QnaDAO.getDAO().selectProductnotnullList();
		ProductDTO product = ProductDAO.getDAO().selectProduct(qna.getQpno());
		
		
%>

<style type="text/css">
.contentdiv {
	overflow : scroll ;
	width : 1196px;
	height : 440px;
	padding : 20px;
	margin : 10px;
}

table {
	margin: 5px auto;
    border-top: 1px solid gray;
    border-collapse: collapse;
  }
  
  th, td {
    border-bottom: 1px solid gray;
    padding: 10px;
  }
  
  .sel {
  	font-size: 16px;
  }
 .butttt {
 background-color: white ;
border : 1px solid black;
padding : 5px;
font-size: 20px;
  }
  
  caption {
	margin-bottom: 10px;
	margin-top: 10px;
	font-size : 20px;
	
}


</style>

<form action="index.jsp?workgroup=qna&work=qna_modify_action" method="post" id="qnaForm">
	<input type="hidden" name="qno" value="<%=qno%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="search" value="<%=search%>">
	<input type="hidden" name="keyword" value="<%=keyword%>">
	
	<table>
<caption><b>문의글 수정</b></caption>
		<tr>
			<th>상품정보</th>

			<td>
			
			<select name="productlisprint" class="sel">
				<% for( ProductDTO product2 : productlist) { %>
				<option value="<%=product2.getSno()%>" 	<% if(qna.getQpno()==product2.getSno()) { %> selected <% } %>> <%=product2.getSname()%>/<%=product2.getSoptionFirst()%>/<%=product2.getSoptionSecond()%></option> 
				<% } %>
			</select>
			
			</td>
		</tr>

		<tr>
			<th>제목</th>
			<td><input type="text" class="sel" name="subject" id="subject" size="40" placeholder="[상품] 상품관련 문의드립니다." value="<%=qna.getQtitle()%>"></td>
		</tr>	
		
		
		<tr>
			<th colspan="2">
				<textarea name="content" id="qcontent" class="contentdiv"><%=qna.getQcontent() %>
				</textarea>
			</th>
		</tr>
		
		<tr>	
			<th>비밀글설정</th>
			<td><input type="checkbox" name="secret" value="2" <% if(qna.getQstatus()==2) { %> checked="checked" <% } %>>비밀글</td>
		</tr>
		
	</table>
	<center><br>
			<button type="submit" class="butttt">수정 완료</button>
			<button type="button" class="butttt" id="resetBtn" onclick="location.href='index.jsp?workgroup=qna&work=qna_detail&qno=<%=qna.getQno() %>&pageNum=<%=pageNum %>&search=<%=search %>&keyword=<%=keyword %>';">취소</button>
</center><br>

</form>
<div id="message" style="color:red;"></div>

<script type="text/javascript">
$("#qtitle").focus();

$("#qnaForm").submit(function() {
	if($("#subject").val()=="") {
		alert("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#qcontent").val()=="") {
		alert("내용을 입력해 주세요.");
		$("#qcontent").focus();
		return false;
	}
});


</script>




