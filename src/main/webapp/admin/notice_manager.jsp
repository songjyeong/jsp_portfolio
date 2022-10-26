<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
// 	System.out.println("search="+search);
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
// 	System.out.println("keyword="+keyword);
	
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=10;
	
	int totalNotice=NoticeDAO.getDAO().selectNoticeCount(search, keyword);
	
	int totalPage=(int)Math.ceil((double)totalNotice/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalNotice) {
		endRow=totalNotice;
	}
	
	List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectNoticeList(startRow, endRow, search, keyword);
	
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	int rowNum=totalNotice-(pageNum-1)*pageSize;
	
%>


<div id="content">


	<div class="container-fluid">

		<br>
		<!-- Page Heading -->
		<h1 class="h1 mb-2 text-gray-800">공지사항 관리 페이지</h1>
		<p class="mb-4">&nbsp;&nbsp;공지사항 CRUD</p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
			</div>
			<div class="card-body">
			
				<div style="text-align: right;">
					<button type="button" onclick="location.href='admin.jsp?workgroup=admin&work=notice_add_admin';">
						글쓰기
					</button>
				</div>
			
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th width="25%">번호</th>
								<th width="50%">제목</th>
								<th width="25%">작성일</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Tiger Nixon</td>
								<td>System Architect</td>
								<td>Edinburgh</td>
							</tr>
							
							<% if(totalNotice==0) { %>
							<tr>
								<td colspan="5">검색된 게시글이 하나도 없습니다.</td>
							</tr>
							<% } else { %>
								<% for(NoticeDTO notice:noticeList) { %>
								<tr>
									<td><%=rowNum %></td>
									<% rowNum--; %>
					
									<td class="subject">
										<a href="admin.jsp?workgroup=admin&work=notice_detail_admin&num=<%=notice.getNno() %>&pageNum=<%=pageNum %>&search=<%=search%>&keyword=<%=keyword%>">
											<%=notice.getNtitle() %>
										</a>
									</td>
									<td>
									<% if(currentDate.equals(notice.getNdate().substring(0, 10))) { %>
										<%=notice.getNdate().substring(11) %>
									<% } else { %>
										<%=notice.getNdate() %>
									<% } %>
									</td>
								</tr>
								<% } %>
							<% } %>
						</tbody>
					</table>
					<%
						int blockSize = 5;
	
						int startPage = (pageNum - 1) / blockSize * blockSize + 1;
	
						int endPage = startPage + blockSize - 1;
	
						if (endPage > totalPage) {
							endPage = totalPage;
						}
					%>
					
					<% if(startPage>blockSize) { %>
						<a href="admin.jsp?workgroup=admin&work=notice_manager&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
						<a href="admin.jsp?workgroup=admin&work=notice_manager&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
					<% } else { %>
						[처음][이전]
					<% } %>
					
					<% for(int i=startPage;i<=endPage;i++) { %>
						<% if(pageNum!=i) { %>
							<a href="admin.jsp?workgroup=admin&work=notice_manager&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
						<% } else { %>
							[<%=i %>]
						<% } %>
					<% } %>
					
					<% if(endPage!=totalPage) { %>
						<a href="admin.jsp?workgroup=admin&work=notice_manager&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
						<a href="admin.jsp?workgroup=admin&work=notice_manager&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
					<% } else {  %>
						[다음][마지막]
					<% } %>
					
					<form action="admin.jsp?workgroup=admin&work=notice_manager" method="post">
						<select name="search">
							<option value="ntitle" selected="selected">&nbsp;제목&nbsp;</option>
							<option value="ncontent">&nbsp;내용&nbsp;</option>
						</select>
						<input type="text" name="keyword">
						<button type="submit">검색</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


