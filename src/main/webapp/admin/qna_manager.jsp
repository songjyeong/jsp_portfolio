<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<%
	
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
			
	
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	// 응답될 게시글 출력번호의 시작값
	int rowNum = totalQna-(pageNum-1)*pageSize;

%>


<div id="content">


	<div class="container-fluid">

		<br>
		<!-- Page Heading -->
		<h1 class="h1 mb-2 text-gray-800">Q&amp;A 관리 페이지</h1>
		<p class="mb-4">&nbsp;&nbsp;Q&amp;A CRUD</p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary"> Q&amp;A 관리 페이지ㄴ </h6>
			</div>
			<div class="card-body">
			
			
			
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>

						<tr>
							<th width="10%">NO</th>
							<th width="10%">PRODUCT</th>
							<th width="40%">SUBJECT</th>
							<th width="20%">ID</th>
							<th width="%">DATE</th>
						</tr>
						</thead>
						<% if(totalQna==0) { %>
						<tr>
							<td colspan="5">검색결과가 없습니다.</td>
						</tr>
						<% } else { %>
						<% for(QnaDTO qna : qnaList) { %>
						<tr>
							<% ProductDTO product = ProductDAO.getDAO().selectProduct(qna.getQpno()); %>
							<% if(product==null) { %>
							<% continue;} %>
							<%-- 글번호 NO --%>
							<td><%=rowNum %></td>
							<% rowNum-- ; %>
			
							<%-- PRODUCT --%>
							<td><%=product.getSname()%>/<%=product.getSoptionFirst()%></td>
			
							<%-- SUBJECT --%>
							<td class="subject">
								<% if(qna.getQanswer()!=null) {  // 답글이 있는 경우 %> 
									<span id="answerfinish">답변완료</span> 
									<% } %> 
									
								<a href="index.jsp?workgroup=qna&work=qna_detail&qno=<%=qna.getQno() %>&pageNum=<%=pageNum %>&search=<%=search %>&keyword=<%=keyword %>">
									<%=qna.getQtitle() %>
								</a>
							</td>
							
			
			
							<%-- NAME --%>
							<td><%=qna.getQwriter().substring(0,3) %>***</td>
			
							<%-- DATE --%>
							<td><%=qna.getQdate().substring(0, 10) %></td>
			
							
						</tr>
						<% } %>
					<% } %>
				</table>
					
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
						<a href="admin.jsp?workgroup=admin&work=qna_manager&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">&laquo;</a>
						<a href="admin.jsp?workgroup=admin&work=qna_manager&pageNum=<%=startPage-blockSize %>&search=<%=search%>&keyword=<%=keyword%>">&#8249;</a>
					<% } else {  // 첫번째 블럭인 경우 - 링크 미설정 %>
						<a href="#">&laquo;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8249;</a>
					<% } %>
					
					
					<% for(int i=startPage ; i<=endPage ; i++ ) { %>
							<a href="admin.jsp?workgroup=admin&work=qna_manager&pageNum=<%=i %>&search=<%=search %>&keyword=<%=keyword %>"><%=i %></a>
					<% } %>
					
					<% if(endPage!=totalPage) { // 마지막 블럭이 아닌 경우 %>
						<a href="admin.jsp?workgroup=admin&work=qna_manager&pageNum=<%=startPage+blockSize %>&search=<%=search%>&keyword=<%=keyword%>">&#8250;</a>
						<a href="admin.jsp?workgroup=admin&work=qna_manager&pageNum=<%=totalPage %>&search=<%=search%>&keyword=<%=keyword%>">&raquo;</a>
					<% } else {  // 마지막 블럭인 경우 - 링크 미설정 %>
						<a href="#">&#8250;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&raquo;</a>
					<% } %>
					<br>
					</div>
					
					<%-- 게시글 검색 기능 구현 --%>
					<br>
					<form action="admin.jsp?workgroup=admin&work=qna_manager" method="post">
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
			</div>
		</div>
	</div>
</div>


