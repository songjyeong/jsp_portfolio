<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.PayDAO"%>
<%@page import="xyz.itwill.dto.PayDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf" %>


<%
	

	List<PayDTO> payList=PayDAO.getDAO().selectPayMember(loginMember.getId());

%>

<style type="text/css">
table {
	margin: 0 auto;
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 3px;
	text-align: center;
	font-size: 12px;
}

th {
	background-color: black;
	color: white; 
}

.member_check { width: 80px; }
.member_id { width: 80px; }
.member_name { width: 80px; }
.member_email { width: 140px; }
.member_mobile { width: 140px; }
.member_address { width: 300px; }
.member_join { width: 150px; }
.member_login { width: 150px; }
.member_status { width: 80px; }
</style>



<div id="content" style="text-align:center;">
	<br>
	<h1><%=loginMember.getName() %>님의 주문 페이지</h1>
	
	
	<form name="payForm" id="payForm">
		<table>
			<tr>
				<th><input type="checkbox" id="allCheck"></th>
				<th width="100">주문번호</th>
				<th width="200">제품이름</th>
				<th width="100">제품수량</th>
				<th width="100">옵션1</th>
				<th width="100">옵션2</th>
				<th width="200">가격</th>
				<th width="100">결제상태</th>
			</tr>
			
			<% for(PayDTO pay:payList) { %>
			<% ProductDTO product=ProductDAO.getDAO().selectProduct(pay.getPrdNO()); %>
			<tr>
				<td>
					<input type="checkbox" name="checkNum" value="<%=pay.getOrdNo() %>" class="check">
				</td>
				<td class="pay_prdNo"><%=pay.getPrdNO() %></td>
				<td class="pay_prdName"><%=product.getSname() %></td>
				<td class="pay_prdName"><%=pay.getQnty() %></td>
				<td class="product_option1"><%=product.getSoptionFirst()%></td>
				<td class="product_option2"><%=product.getSoptionSecond()%></td>
				<td class = "product_price"><%= DecimalFormat.getInstance().format(product.getSprice()) %>원</td>
				
				
				<% if(pay.getOrdStatus()==0) { %>
				<td>미결제</td>				
				<% } else if(pay.getOrdStatus()==1){ %>
				<td>결제완료</td>
				<% } else if(pay.getOrdStatus()==2){ %>
				<td>배송준비</td>
				<% } else if(pay.getOrdStatus()==3){ %>
				<td>배송중</td>
				<% } else if(pay.getOrdStatus()==4){ %>
				<td>배송완료</td>
				<% } else if(pay.getOrdStatus()==5){ %>
				<td>결제취소</td>
				<% } %>
				
				
				
			</tr>
				
			<% } %>
		</table>

		<div id="message" style="color: red;"></div>
	</form>
			<button type="button" id="cancleBtn">결제취소</button>
	
</div>


<script type="text/javascript">
$("#allCheck").change(function() {
	if($(this).is(":checked")) {
		$(".check").prop("checked",true);
	} else {
		$(".check").prop("checked",false);
	}
});


$("#cancleBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 메뉴가 하나도 없습니다.");
		return;
	}
	
	$("#payForm").attr("action","index.jsp?workgroup=pay&work=pay_cancel_action");
	$("#payForm").attr("method","post");
	$("#payForm").submit();
});
</script>