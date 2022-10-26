<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.PayDAO"%>
<%@page import="xyz.itwill.dto.PayDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	
	List<PayDTO> payList = AdminDAO.getDAO().selectPayAllList();

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
	<h1>결제 관리 페이지</h1>
	
	
	<form name="payForm" id="memberForm">
		<table>
			<tr>
				<th><input type="checkbox" id="allCheck"></th>
				<th width="100">주문번호</th>
				<th width="100">주문자ID</th>
				<th width="100">제품번호</th>
				<th width="200">제품이름</th>
				<th width="100">결제상태</th>
			</tr>
			
			<% for(PayDTO pay:payList) { %>
			<% ProductDTO product=ProductDAO.getDAO().selectProduct(pay.getPrdNO()); %>
			<tr>
				<td>
					<input type="checkbox" name="checkNum" value="<%=pay.getOrdNo() %>" class="check">
				</td>
				<td class="pay_ordNo"><%=pay.getOrdNo() %></td>
				<td class="pay_memberId"><%=pay.getMemID() %></td>
				<td class="pay_prdNo"><%=pay.getPrdNO() %></td>
				<td class="pay_prdName"><%=product.getSname() %></td>
				<% if(pay.getOrdStatus()==0) { %>
				<td>미결제</td>				
				<% } else if(pay.getOrdStatus()==1){ %>
				<td>결제완료</td>
				<% } else if(pay.getOrdStatus()==2){ %>
				<td>배송중</td>
				<% } else if(pay.getOrdStatus()==3){ %>
				<td>배송완료</td>
				<% } else if(pay.getOrdStatus()==5){ %>
				<td>결제취소</td>
				<% } %>
				
				
				
			</tr>
				
			<% } %>
		</table>
	
		<input type="hidden" id="status" name="status">
			
		<button type="button" id="payEndBtn">결제완료</button>
		<button type="button" id="readyBtn">배송준비</button>
		<button type="button" id="goingBtn">배송중</button>
		<button type="button" id="pickUpeBtn">배송완료</button>
		<button type="button" id="cancleBtn">결제취소</button>
		<button type="button" id="removeBtn">내역완전삭제</button>
		<div id="message" style="color: red;"></div>
	</form>
	
</div>


<script type="text/javascript">
$("#allCheck").change(function() {
	if($(this).is(":checked")) {
		$(".check").prop("checked",true);
	} else {
		$(".check").prop("checked",false);
	}
});


$("#payEndBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 회원이 하나도 없습니다.");
		return;
	}
	$("#status").val(1);
	$("#memberForm").attr("action","admin.jsp?workgroup=admin&work=pay_modify_action");
	$("#memberForm").attr("method","post");
	$("#memberForm").submit();
});
$("#readyBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 회원이 하나도 없습니다.");
		return;
	}
	$("#status").val(2);
	$("#memberForm").attr("action","admin.jsp?workgroup=admin&work=pay_modify_action");
	$("#memberForm").attr("method","post");
	$("#memberForm").submit();
});
$("#goingBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 회원이 하나도 없습니다.");
		return;
	}
	
	$("#status").val(3);
	$("#memberForm").attr("action","admin.jsp?workgroup=admin&work=pay_modify_action");
	$("#memberForm").attr("method","post");
	$("#memberForm").submit();
});
$("#pickUpeBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 회원이 하나도 없습니다.");
		return;
	}
	
	$("#status").val(4);
	$("#memberForm").attr("action","admin.jsp?workgroup=admin&work=pay_modify_action");
	$("#memberForm").attr("method","post");
	$("#memberForm").submit();
});
$("#cancleBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 회원이 하나도 없습니다.");
		return;
	}
	
	$("#status").val(5);
	$("#memberForm").attr("action","admin.jsp?workgroup=admin&work=pay_modify_action");
	$("#memberForm").attr("method","post");
	$("#memberForm").submit();
});
$("#removeBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 회원이 하나도 없습니다.");
		return;
	}
	
	$("#status").val(6);
	$("#memberForm").attr("action","admin.jsp?workgroup=admin&work=pay_modify_action");
	$("#memberForm").attr("method","post");
	$("#memberForm").submit();
});
</script>