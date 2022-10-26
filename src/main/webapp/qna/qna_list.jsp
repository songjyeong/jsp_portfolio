<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 검색대상과 검색단어를 반환받아 저장
	String search=request.getParameter("search");
	if(search==null){
		search="";
	} 
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}


	int pageNum=1; // 페이지번호
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=15;
	
	int totalQna = QnaDAO.getDAO().selectQnaCount(search, keyword);
	
	int totalPage = (int)Math.ceil((double) totalQna/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	
	int startRow=(pageNum-1)*pageSize+1;
	int endRow = pageNum*pageSize ;
	
	if(endRow>totalQna) {
		endRow=totalQna ;
	}
	
	List<QnaDTO> qnaList = QnaDAO.getDAO().selectQnaList(startRow, endRow, search, keyword);
			
	MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
	
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	// 응답될 게시글 출력번호의 시작값
	int rowNum = totalQna-(pageNum-1)*pageSize;
	
			
%>

<style type="text/css">
* {
	font-family: Montserrat,'NanumBarunGothic', sans-serif;
}
#board_list {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#board_title {
	font-size: 1.2em;
	font-weight: bold;
}



  table {
	margin: 5px auto;
    width: 100%;
    border-top: 1px solid gray;
    border-collapse: collapse;
  }
  
  th, td {
    border-bottom: 1px solid gray;
    padding: 10px;
    text-align: center;
  }
  
  

.subject {
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#board_list a:hover {
	text-decoration: none;
	color: red;
}

.secret, .remove {
	background-color: black;
	color: white;
	font-size: 14px;
	border: 1px solid black;
	border-radius: 4px;
}

#answerfinish {
	background-color: gray;
	color: white;
	font-size: 14px;
	border: 1px solid black;
	border-radius: 4px;

}

a {
	text-decoration-line : none;
	color : black; 
}

.nanana {
background-color: white ;
border : 1px solid black;
padding : 5px;
}

.sel {
  	font-size: 15px;
  }
  
  .pagination {
  display: inline-block;
}

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
}


</style>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">

<div id="board_list" >
		<h2>Q &amp; A</h2>
		
		<br>

		<table>
			<tr>
				<th width="100">NO</th>
				<th width="500">PRODUCT</th>
				<th width="600">SUBJECT</th>
				<th width="100">ID</th>
				<th width="200">DATE</th>
			</tr>

			<% if(totalQna==0) { %>
			<tr>
				<td colspan="5">검색결과가 없습니다.</td>
			</tr>
			<% } else { %>
			<% for(QnaDTO qna : qnaList) { %>
			<tr>
			<%-- PRODUCT --%>
				<% ProductDTO product = ProductDAO.getDAO().selectProduct(qna.getQpno()); %>
				<% if(product==null) { %>
				<% continue;} %>
				<%-- 글번호 NO --%>
				<td><%=rowNum %></td>
				<% rowNum-- ; %>

				
				<td><%=product.getSname()%>/<%=product.getSoptionFirst()%></td>

				<%-- SUBJECT --%>
				<td class="subject">
					<% if(qna.getQanswer()!=null) {  // 답글이 있는 경우 %> 
						<span id="answerfinish">답변완료</span> 
						<% } %> 
						
					<% if(qna.getQstatus()==1) {  // 일반글인 경우 %>
					<a href="index.jsp?workgroup=qna&work=qna_detail&qno=<%=qna.getQno() %>&pageNum=<%=pageNum %>&search=<%=search %>&keyword=<%=keyword %>">
						<%=qna.getQtitle() %>
					</a>
				 <% } else if(qna.getQstatus()==2) { // 비밀글인 경우 %> 
				 <img src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_lock.gif" alt="비밀글"> 
				 	<% if (loginMember!=null  && (loginMember.getId().equals(qna.getQwriter())
						|| loginMember.getStatus()==9 )) { %> 
						<a href="index.jsp?workgroup=qna&work=qna_detail&qno=<%=qna.getQno() %>&pageNum=<%=pageNum %>&search=<%=search %>&keyword=<%=keyword %>">
							<%=qna.getQtitle() %>
						</a> 
					<% }  else { %> 
						작성자 또는 관리자만 확인 가능합니다. 
					<% } %> 
				
				<% } else if(qna.getQstatus()==0) { // 삭제글인 경우 %>
					<span class="remove">삭제글</span> 
					작성자 또는 관리자에 의해 삭제된 게시글입니다. 
				<% } %>
				</td>


			<% if(qna.getQstatus()!=0 ) {  // 삭제 게시글이 아닌 경우 %>
				<%-- NAME --%>
				<td><%=qna.getQwriter().substring(0,3) %>***</td>

				<%-- DATE --%>
				<td><%=qna.getQdate().substring(0, 10) %></td>

			<% } else {  // 삭제 게시글인 경우 %>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			<% } %>
			</tr>
			<% } %>
		<% } %>
	</table>

		<% if(loginMember!=null) {   // 로그인 사용자인 경우 %>
		<div style="text-align: right;">
			<button type="button"
				onclick="location.href='index.jsp?workgroup=qna&work=qna_write';" class="nanana">WRITE</button>
		</div>
		<% } %>
		
		<%-- 페이지 번호 출력 : 클릭 이벤트에 의한 링크 설정 - 블럭화 처리 --%>
		<% 
			int blockSize=5;
			int startPage=(pageNum-1)/blockSize*blockSize+1;
			int endPage=startPage+blockSize-1 ;
			if(endPage>totalPage) {
				endPage=totalPage;
			}
		
		%>
		
		<div class="pagination">
		<br>
		<% if(startPage>blockSize) { // 첫번째 블럭이 아닌 경우 %>
			<a href="index.jsp?workgroup=qna&work=qna_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">&laquo;</a>
			<a href="index.jsp?workgroup=qna&work=qna_list&pageNum=<%=startPage-blockSize %>&search=<%=search%>&keyword=<%=keyword%>">&#8249;</a>
		<% } else {  // 첫번째 블럭인 경우 - 링크 미설정 %>
			<a href="#">&laquo;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8249;</a>
		<% } %>
		
		
		<% for(int i=startPage ; i<=endPage ; i++ ) { %>
				<a href="index.jsp?workgroup=qna&work=qna_list&pageNum=<%=i %>&search=<%=search %>&keyword=<%=keyword %>"><%=i %></a>
		<% } %>
		
		<% if(endPage!=totalPage) { // 마지막 블럭이 아닌 경우 %>
			<a href="index.jsp?workgroup=qna&work=qna_list&pageNum=<%=startPage+blockSize %>&search=<%=search%>&keyword=<%=keyword%>">&#8250;</a>
			<a href="index.jsp?workgroup=qna&work=qna_list&pageNum=<%=totalPage %>&search=<%=search%>&keyword=<%=keyword%>">&raquo;</a>
		<% } else {  // 마지막 블럭인 경우 - 링크 미설정 %>
			<a href="#">&#8250;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&raquo;</a>
		<% } %>
		<br>
		</div>
		
		<%-- 게시글 검색 기능 구현 --%>
		<br>
		<form action="index.jsp?workgroup=qna&work=qna_list" method="post">
			<select name="search" class="sel">
				<option value="qwriter">&nbsp;글쓴이&nbsp;</option>
				<option value="qtitle" selected="selected">&nbsp;제목&nbsp;</option>
				<option value="qcontent">&nbsp;내용&nbsp;</option>
			</select>
			<input type="text" name="keyword" class="sel">
			<button type="submit" class="nanana">Search</button>
		</form>
		<br><br>
		
</div>