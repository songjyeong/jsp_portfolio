<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<ProductDTO> allList = AdminDAO.getDAO().selectProductAllList();
	List<ProductDTO> maintList = AdminDAO.getDAO().selectProductMainList();
	List<ProductDTO> optiontList = AdminDAO.getDAO().selectProductOptionList();
%>

<style>
.prdClass {
	display:none;
}
</style>

<div id="content">
	<br>
	<h1>상품 관리 페이지</h1>
	<button type="button" id="allBtn">전체보기</button>
	<button type="button" id="mainBtn">상품</button>
	<button type="button" id="optionBtn">옵션</button>
	<button type="button" id="addBtn">상품추가</button>
	<div id="productAll" class="prdClass">
		<% for(int i=0; i<allList.size(); i+=3) { %>
		<div style="border:1px solid black; max-width:2000px; margin:auto; height:500px; display:flex;">
			<% for(int j=0;j<3;j++) {%>
				<% if(allList.size()<=i+j) {break;} %>
				<% ProductDTO product=allList.get(i+j); %>
				<% if(product.getSoptionFirst()==null&&product.getSoptionSecond()==null) { %>
				<div style="width:calc(100%/3); border:1px solid black; height:100%" onclick="location.href='admin.jsp?workgroup=admin&work=product_detail_admin&num=<%=product.getSno()%>';">
					<img src="<%=request.getContextPath()%>/product_image/<%=product.getSimg() %>" style="width:50%;">
					<p>상품명 : <%=product.getSname() %> </p>
					<br>
					<p>메인상품</p>
				</div>
				<% } else { %>
				<div style="width:calc(100%/3); border:1px solid black; height:100%" onclick="location.href='admin.jsp?workgroup=admin&work=product_detail_admin&num=<%=product.getSno()%>';">
					<img src="<%=request.getContextPath()%>/product_image/<%=product.getSimg() %>" style="width:50%;">
					<p>상품명 : <%=product.getSname() %> </p>
					<p>옵션</p>
					<p><%=product.getSoptionFirst() %> / <%=product.getSoptionSecond() %></p>
					<p>가격 : <%=DecimalFormat.getInstance().format(product.getSprice()) %>원</p>
					<p></p>
				</div>
				<% } %>
			<% } %>
		</div>
		<% } %>
	</div>
	<div id="productMain" class="prdClass">
		<% for(int i=0; i<maintList.size(); i+=3) { %>
		<div style="border:1px solid black; max-width:2000px; margin:auto; height:500px; display:flex;">
			<% for(int j=0;j<3;j++) {%>
				<% if(maintList.size()<=i+j) {break;} %>
				<% ProductDTO product=maintList.get(i+j); %>
				<div style="width:calc(100%/3); border:1px solid black; height:100%" onclick="location.href='admin.jsp?workgroup=admin&work=product_detail_admin&num=<%=product.getSno()%>';">
					<img src="<%=request.getContextPath()%>/product_image/<%=product.getSimg() %>" style="width:50%;">
					<p>상품명 : <%=product.getSname() %> </p>
					<br>
					<p>메인상품</p>
				</div>
			<% } %>
		</div>
		<% } %>
	</div>
	<div id="productOption" class="prdClass">
		<% for(int i=0; i<optiontList.size(); i+=3) { %>
		<div style="border:1px solid black; max-width:2000px; margin:auto; height:500px; display:flex;">
			<% for(int j=0;j<3;j++) {%>
				<% if(optiontList.size()<=i+j) {break;} %>
				<% ProductDTO product=optiontList.get(i+j); %>
				<div style="width:calc(100%/3); border:1px solid black; height:100%" onclick="location.href='admin.jsp?workgroup=admin&work=product_detail_admin&num=<%=product.getSno()%>';">
					<img src="<%=request.getContextPath()%>/product_image/<%=product.getSimg() %>" style="width:50%;">
					<p>상품명 : <%=product.getSname() %> </p>
					<p>옵션</p>
					<p><%=product.getSoptionFirst() %> / <%=product.getSoptionSecond() %></p>
					<p>가격 : <%=DecimalFormat.getInstance().format(product.getSprice()) %>원</p>
					<p></p>
				</div>
			<% } %>
		</div>
		<% } %>
	</div>
</div>
<script type="text/javascript">

$(".prdClass").css("display","none");
$("#productMain").css("display","block");


$("#allBtn").click(function() {
	$("#productAll").css("display","block");
	$("#productMain").css("display","none");
	$("#productOption").css("display","none");
});
$("#mainBtn").click(function() {
	$("#productAll").css("display","none");
	$("#productMain").css("display","block");
	$("#productOption").css("display","none");
});
$("#optionBtn").click(function() {
	$("#productAll").css("display","none");
	$("#productMain").css("display","none");
	$("#productOption").css("display","block");
});

$("#addBtn").click(function() {
	location.href='admin.jsp?workgroup=admin&work=product_add_admin';
});
</script>