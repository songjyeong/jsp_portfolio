<%@page import="java.lang.reflect.Member"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.dto.PayDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.CartDAO"%>
<%@page import="xyz.itwill.dto.CartDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_url.jspf" %>


<%

String memberId = loginMember.getId();



int totalCart = CartDAO.getDAO().selectCartCount(memberId);


List<CartDTO> cartList = CartDAO.getDAO().selectCartMemberList(memberId);

%>

<style type = "text/css">

.inputMessage {
	width: 600px;
	height: 50px;
}


</style>

<h3 align = "center"><%=loginMember.getName() %>님의 장바구니</h3>
<br>
<div>
		<form id="cartForm" method="post">

		<table border="1" style="text-align:center;">
			<tr>
				<th><input type = "checkbox" id = "allProductCheck"></th>
				<th width="200">이름</th>
				<th width="100">수량</th>
				<th width="100">옵션1</th>
				<th width="100">옵션2</th>
				<th width="100">가격</th>
				
			</tr>
			
			<%-- 장바구니가 비어 있는 경우 --%>
			<% if(totalCart == 0) { %>
			<tr>
				<td colspan = "5">
				<% out.println("장바구니가 비어 있습니다."); %>
				</td>
			</tr>

			<%-- 해당 계정의 장바구니에 담긴 상품 리스트 --%>
			<% } else { %>
				<% for(CartDTO cart : cartList) { %>
					<% int prd_no = cart.getProductNo(); %>
					
					<% int qnty = cart.getQnty(); %>
					
					<% ProductDTO product = ProductDAO.getDAO().selectProduct(prd_no); %>
				<tr>
					<td>
						<input type = "checkbox" name = "check" value = "<%= cart.getCartNo() %>" class = "check">
						<input type="hidden" name="cartPayNumList" value="<%=cart.getCartNo() %>">
					</td>
					<td class = "product_name"><%= product.getSname() %></td>
					<td class = "quantity"><%= qnty %>개</td>
					<td class = "product_option1"><%= product.getSoptionFirst() %></td>
					<td class = "product_option2"><%= product.getSoptionSecond() %></td>
					<td class = "product_price"><%= DecimalFormat.getInstance().format(product.getSprice()) %>원</td>
				</tr>
				<% } %>
			<% } %>	
		</table>
		<div style="text-align:center;">
			<h2>요청사항 입력</h2>
			<div style="text-align:center;">
				<div style="text-align:center;">
				<input type="text" name="inputMessage" class="inputMessage">
				</div>
			</div>
			
		</div>
		<div id="nochecked" style="text-align:center;">
			<button type = "button" id = "submitBtn">주문결제</button>
		</div>
		</form>
				
		

		
</div>

<script type="text/javascript">

$("#allProductCheck").change(function() {
	if($(this).is(":checked")) {
		$(".check").prop("checked",true);
	} else {
		$(".check").prop("checked",false);
	}
});

	
$("#submitBtn").click(function() {
	if($(".check").filter(":checked").length == 0) {
		$("#nochecked").text();
        alert('상품을 선택하세요.');
		return;
	}
	$("#cartForm").attr("action","index.jsp?workgroup=cart&work=cart_add_action");
	$("#cartForm").submit();
});
</script>
