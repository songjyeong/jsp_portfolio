<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}

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

<style type="text/css">
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
	border: 1px solid black;
	border-collapse: collapse;
}

th {
	border: 1px solid black;
	background-color: black; 
	color: white; 
}

td {
	border: 1px solid black;
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
</style>

<div id="board_list">
	<div id="board_title">
		<p>공지사항</p>
		<table>
			<tr>
				<th width="100">번호</th>
				<th width="500">제목</th>
				<th width="200">작성일</th>
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
					<a href="index.jsp?workgroup=notice&work=notice_detail&num=<%=notice.getNno() %>&pageNum=<%=pageNum %>&search=<%=search%>&keyword=<%=keyword%>">
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
		</table>
		
	<%
		int blockSize=5;
	
		int startPage=(pageNum-1)/blockSize*blockSize+1;

		int endPage=startPage+blockSize-1;
		
		if(endPage>totalPage) {
			endPage=totalPage;
		}
	%>	
	
	<% if(startPage>blockSize) { %>
		<a href="index.jsp?workgroup=notice&work=notice_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
		<a href="index.jsp?workgroup=notice&work=notice_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } else { %>
		[처음][이전]
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) { %>
			<a href="index.jsp?workgroup=notice&work=notice_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
		<% } else { %>
			[<%=i %>]
		<% } %>
	<% } %>
	
	<% if(endPage!=totalPage) { %>
		<a href="index.jsp?workgroup=notice&work=notice_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
		<a href="index.jsp?workgroup=notice&work=notice_list&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
	<% } else {  %>
		[다음][마지막]
	<% } %>
	
	<form action="index.jsp?workgroup=notice&work=notice_list" method="post">
		<select name="search">
			<option value="ntitle" selected="selected">&nbsp;제목&nbsp;</option>
			<option value="ncontent">&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword">
		<button type="submit">검색</button>
	</form>
	</div>
</div>