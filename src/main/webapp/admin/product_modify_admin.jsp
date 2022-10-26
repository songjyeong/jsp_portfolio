<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%

	int num=Integer.parseInt(request.getParameter("productNum"));


	ProductDTO product=AdminDAO.getDAO().selectProduct(num);
	
%>


<style type="text/css">
#product {
	width: 800px;
	margin: 0 auto;
}

table {
	margin: 0 auto;
}

td {
	text-align: left;
}
</style>

<div id="product">
	<h2>제품변경</h2>
	
	<form action="admin.jsp?workgroup=admin&work=product_modify_action_admin" method="post"
		enctype="multipart/form-data" id="productForm">
	<input type="hidden" name="num" value="<%=product.getSno()%>">	
	<input type="hidden" name="currentImageMain" value="<%=product.getSimg()%>">	
	<input type="hidden" name="currentImageDetail" value="<%=product.getSinfo()%>">	
	<table>
		<tr>
			<td>제품명</td>
			<td>
				<input type="text" name="name" id="name" value="<%=product.getSname()%>">
			</td>
		</tr>
		<% if(product.getSoptionFirst()!=null||product.getSoptionSecond()!=null) { %>
		<tr>
			<td>옵션1</td>
			<td>
				<input type="text" name="option1" id="option1" value="<%=product.getSoptionFirst() %>">
			</td>
		</tr>
		<tr>
			<td>옵션2</td>
			<td>
				<input type="text" name="option2" id="option2" value="<%=product.getSoptionSecond() %>">
			</td>
		</tr>
		<tr>
			<td>제품가격</td>
			<td>
				<input type="text" name="price" id="price" value="<%=product.getSprice()%>">
			</td>
		</tr>
		<% } else if(product.getSoptionFirst()==null&&product.getSoptionSecond()==null) { %>
		<tr>
			<td>대표이미지</td>
			<td>
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getSimg() %>" width="200">
				<br>
				<span style="color: red;">이미지를 변경하기 않을 경우 입력하지 마세요.</span>
				<br>			
				<input type="file" name="imageMain" id="imageMain">
			</td>
		</tr>
		<tr>
			<td>상세이미지</td>
			<td>
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getSinfo() %>" width="400">
				<br>
				<span style="color: red;">이미지를 변경하기 않을 경우 입력하지 마세요.</span>
				<br>			
				<input type="file" name="imageDetail" id="imageDetail">
			</td>
		</tr>
		<% } %>
		<tr>
			<td>
				<button type="submit">제품변경</button>
			</td>
			<td>
				<button onclick="location.href='admin.jsp?workgroup=admin&work=product_manager'">돌아가기</button>
			</td>
		</tr>
	</table>	
	</form>
	
	<div id="message" style="color: red;"></div>
</div>

<script type="text/javascript">
$("#productForm").submit(function() {
	if($("#name").val()=="") {
		$("#message").text("제품명을 입력해 주세요.");
		$("#name").focus();
		return false;
	}

	if($("#price").val()=="") {
		$("#message").text("제품가격을 입력해 주세요.");
		$("#price").focus();
		return false;
	}
});
</script>