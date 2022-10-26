<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String search = request.getParameter("search");
if (search == null) {
	search = "";
}

String keyword = request.getParameter("keyword");
if (keyword == null) {
	keyword = "";
}

int pageNum = 1;
if (request.getParameter("pageNum") != null) {
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}

int pageSize = 10;

int totalReview = ReviewDAO.getDAO().selectReviewCount(search, keyword);

int totalPage = (int) Math.ceil((double) totalReview / pageSize);

if (pageNum <= 0 || pageNum > totalPage) {
	pageNum = 1;
}

int startRow = (pageNum - 1) * pageSize + 1;
int endRow = pageNum * pageSize;

if (endRow > totalReview) {
	endRow = totalReview;
}

int rowNum = totalReview - (pageNum - 1) * pageSize;

String sname = request.getParameter("sname");
int sno = Integer.parseInt(request.getParameter("sno"));

List<ReviewDTO> reviewList = ReviewDAO.getDAO().selectReviewBySname(sname);
ProductDTO product = ProductDAO.getDAO().selectProduct(sno);

%>

<% if(totalReview == 0) { %>

<div>해당 리뷰가 없습니다.</div>

<% } else {
		for (ReviewDTO review : reviewList) {
		%>
<div class="review"
	style="border: 1px solid gray; height: calc(100%/<%=reviewList.size() %>);">
<%-- 	<div><%= review.getRtitle() %></div> --%>

	<div>
<%-- 		<div style="float: left"><%= review.getRtitle() %></div> --%>
		<div style="float: right"><%= review.getRdate() %></div>
	</div>
	<br>

	<div><%= review.getRcontent() %></div>
</div>
<% }
		} %>

<div style="text-align: right;">
	<button type="button"
		onclick="location.href='index.jsp?workgroup=review&work=review_write&sno=<%= product.getSno()%>';">
		WRITE</button>
</div>

<% 
			int blockSize=10;
			int startPage=(pageNum-1)/blockSize*blockSize+1;
			int endPage=startPage+blockSize-1 ;
			if(endPage>totalPage) {
				endPage=totalPage;
			}
		
		%>

		<% if(startPage>blockSize) { // 첫번째 블럭이 아닌 경우 %>
			<a href="index.jsp?workgroup=review&work=review_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
			<a href="index.jsp?workgroup=review&work=review_list&pageNum=<%=startPage-blockSize %>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
		<% } else {  // 첫번째 블럭인 경우 - 링크 미설정 %>
			[처음][이전]
		<% } %>
		
		<% for(int i=startPage ; i<=endPage ; i++ ) { %>
				<a href="index.jsp?workgroup=review&work=review_list&pageNum=<%=i %>&search=<%=search %>&keyword=<%=keyword %>">[<%=i %>]</a>
		<% } %>
		
		<% if(endPage!=totalPage) { // 마지막 블럭이 아닌 경우 %>
			<a href="index.jsp?workgroup=review&work=review_list&pageNum=<%=startPage+blockSize %>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
			<a href="index.jsp?workgroup=review&work=review_list&pageNum=<%=totalPage %>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
		<% } else {  // 마지막 블럭인 경우 - 링크 미설정 %>
			[다음][마지막]
		<% } %>