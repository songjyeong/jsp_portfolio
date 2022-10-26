<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	//비정상적인 요청에 대한 응답 처리


	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	ProductDTO product=AdminDAO.getDAO().selectProduct(num);
	
	//검색된 제품정보가 없는 경우 에러페이지로 이동 - 비정상적인 요청

%>

<style type="text/css">
table {
	margin: 0 auto; 
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
}

.title {
	background-color: black;
	color: white;
	text-align: center;
	width: 100px;
}

.value {
	padding: 5px;
	text-align: left;
	width: 500px;
}
</style>

<h2>제품상세정보</h2>


<form method="post">
	<% if(product.getSoptionFirst()==null&&product.getSoptionSecond()==null) { %>
	<button type="button" id="modifyBtn">상품변경</button>
	<button type="button" id="removeBtn">상품삭제</button>
	<% } else if(product.getSoptionFirst()!=null||product.getSoptionSecond()!=null) { %>
	<button type="button" id="modifyOptionBtn">옵션변경</button>
	<button type="button" id="removeOptionBtn">옵션삭제</button>
	<% } %>
	<button type="button" id="backBtn">돌아가기</button>
	
	
</form>

<table>
	<tr>
		<td class="title">제품번호</td>
		<td class="value"><%=product.getSno() %></td>
	</tr>
	<tr>
		<td class="title">제품명</td>
		<td class="value"><%=product.getSname()%></td>
	</tr>
	<% if(product.getSoptionFirst()!=null||product.getSoptionSecond()!=null) { %>
	<tr>
		<td class="title">제품옵션1</td>
		<td class="value"><%=product.getSoptionFirst() %></td>
	</tr>
	<tr>
		<td class="title">제품옵션2</td>
		<td class="value"><%=product.getSoptionSecond() %></td>
	</tr>
	<tr>
		<td class="title">제품가격</td>
		<td class="value"><%=DecimalFormat.getInstance().format(product.getSprice()) %>원</td>
	</tr>	
	<% } else if(product.getSoptionFirst()==null&&product.getSoptionSecond()==null) { %>
	<tr>
		<td class="title">대표이미지</td>
		<td class="value">
			<img src="<%=request.getContextPath()%>/product_image/<%=product.getSimg() %>" width="200">
		</td>
	</tr>
	<tr>
		<td class="title">상세이미지</td>
		<td class="value">
			<img src="<%=request.getContextPath()%>/product_image/<%=product.getSinfo() %>" width="400">
		</td>	
	</tr>
	<% } %>
</table>

	<form method="post" id="menuForm">
		<input type="hidden" name="productNum" value="<%=product.getSno()%>">
	</form>




<script type="text/javascript">
$("#modifyBtn").click(function() {
	$("#menuForm").attr("action","admin.jsp?workgroup=admin&work=product_modify_admin");
	$("#menuForm").submit();
});

$("#removeBtn").click(function() {
	if(confirm("상품을 삭제 하시겠습니까?")) {	
		$("#menuForm").attr("action","admin.jsp?workgroup=admin&work=product_remove_action_admin");
		$("#menuForm").submit();
	}
});
$("#modifyOptionBtn").click(function() {
	$("#menuForm").attr("action","admin.jsp?workgroup=admin&work=product_modify_admin");
	$("#menuForm").submit();
});
$("#removeOptionBtn").click(function() {
	if(confirm("옵션을 삭제 하시겠습니까?")) {	
		$("#menuForm").attr("action","admin.jsp?workgroup=admin&work=product_remove_action_admin");
		$("#menuForm").submit();
	}
});

$("#backBtn").click(function() {
	$("#menuForm").attr("action","admin.jsp?workgroup=admin&work=product_manager");
	$("#menuForm").submit();
});
</script>