<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

String search=request.getParameter("productSearch");
List<ProductDTO> productList=null;
if(search!=null){
	productList = ProductDAO.getDAO().selectNullSearchProductList(search);	
} else {
	productList = ProductDAO.getDAO().selectNullProductList();	
}

%>

<style>
.productImg {
display : block;
margin-left : auto;
margin-right : auto;
width : 50%;
}


</style>

<div>
		<% for(int i=0; i<productList.size(); i+=3) { %>
		<div style=" max-width:2000px; margin:auto; height:500px; display:flex;">
			<% for(int j=0;j<3;j++) {%>
				<% if(productList.size()<=i+j) {break;} %>
				<% ProductDTO product=productList.get(i+j); %>
				<div class="product" style="width: calc(100%/3); height: 500px; ">
					<div onclick="location.href='index.jsp?workgroup=product&work=product_detail&sno=<%=product.getSno()%>&sname=<%=product.getSname()%>';"> 
					<img class="productImg"
						src="<%=request.getContextPath()%>/img/<%=product.getSimg()%>"
						style="width: 50%;">
					</div>
					<div style="font-size: 14px; text-align: center;"><%=product.getSname()%></div>
					<div style="text-align: center;">
						<%=DecimalFormat.getInstance().format(product.getSprice())%>원
					</div>
				</div>
				<% } %>
			</div>
		<% } %>

	<% if(productList.size()<=0) { %>
	<h1 style="text-align: center;">검색결과가 없습니다</h1>
	<% } %>
</div>
