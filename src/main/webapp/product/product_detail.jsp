<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%--

이미지를 호출하여 img라고 되어있는곳에 출력

subject라는 곳에 상품명 값 출력

price에 상품 가격 출력

option이 있으면 옵션에 value를 넣어서 값이 나오도록 출력

cart를 누르면 해당 제품의 수량 / 제품의 옵션에 따른 제품번호를 카트에 저장 action 만들기
확인은 oracle sql에서 확인

review는 따로 파일을 만들어 드릴게요

--%>
<%	request.setCharacterEncoding("UTF-8");
	int sno = Integer.parseInt(request.getParameter("sno"));
	ProductDTO product = ProductDAO.getDAO().selectProduct(sno);
	
	String sname = request.getParameter("sname");
	List<String> optionList1 = ProductDAO.getDAO().selectProductOption1(sname);
	List<String> optionList2 = ProductDAO.getDAO().selectProductOption2(sname);
 	
	
	String rsearch = request.getParameter("rsearch");
	if (rsearch == null) {
		rsearch = "";
	}

	String rkeyword = request.getParameter("sname");
	if (rkeyword == null) {
		rkeyword = "";
	}

	int rpageNum = 1;
	if (request.getParameter("rpageNum") != null) {
		rpageNum = Integer.parseInt(request.getParameter("rpageNum"));
	}

	int rpageSize = 10;

	int totalReview = ReviewDAO.getDAO().selectReviewCount(rsearch, rkeyword);

	int rtotalPage = (int) Math.ceil((double) totalReview / rpageSize);

	if (rpageNum <= 0 || rpageNum > rtotalPage) {
		rpageNum = 1;
	}

	int rstartRow = (rpageNum - 1) * rpageSize + 1;
	int rendRow = rpageNum * rpageSize;

	if (rendRow > totalReview) {
		rendRow = totalReview;
	}
	
	List<ReviewDTO> reviewList = ReviewDAO.getDAO().selectReviewList(rstartRow, rendRow, rsearch, rkeyword);
	
	int rrowNum = totalReview - (rpageNum - 1) * rpageSize;
	%>



<div style="height:auto; max-width:1000px;">
	<form method="post" id="productForm">
		<div style="display:flex">
			<div style="flex:1">
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getSimg()%>" style="width: 70%">
			</div>
			<div style="flex:1">
				<div style=" "><%= product.getSname() %></div>
				<input type = "hidden" id="productName" name="productName" value="<%= product.getSname() %>">
				<div>
					<input type = "hidden" id="priceResult" name="priceResult" value="<%= product.getSprice() %>">
					<p><%= product.getSprice() %>원</p>
				</div>
				<div style=" ">total_price
					<input type="hidden" id="totalPrice" name="totalPrice">
					<p class="totalPrice"></p>
				</div>
				<div>
					<p>수량</p>
					<button type="button" id="sub">-</button>
					<input id="result" name="result" type="number" class="qt" value="1" size="3">
					<button type="button" id="add">+</button>
				</div>
				<div>
					<p>옵션1</p>
					<input type="hidden" id="soption1V" name="soption1V">
					<select id="soptionFirst" onchange="soption1Change(this.value);">
						<option selected value="0">선택하시오</option>
						<%int i = 1; for (String option1 : optionList1) { %>
						<option value="<%=option1 %>">
						<%= option1 %>
					 	</option>
						<% i++;} %>
					</select>
				</div>				
				<div>
<!-- 				<p>옵션1</p> -->
<!-- 				<input type="hidden" id="soption1V" name="soption1V"> -->
<!-- 				<select id="soptionFirst" onchange="soption1Change(this.value);"> -->
<!-- 					<option selected>선택하시오</option> -->
<%-- 						<%int i = 1; for (String option1 : optionList1) { %> --%>
<%-- 						<option value="<%=option1 %>"> --%>
<%-- 						<%= option1 %> --%>
<!-- 					 	</option> -->
<%-- 						<% i++;} %> --%>
<!-- 					</select> -->
				</div>
				<div>
					<p>옵션2</p>
					<input type="hidden" id="soption2V" name="soption2V">
					<select id="soptionSecond" onchange="soption2Change(this.value);">
					<option selected>선택하시오</option>

						<% int j=1; %>
						<% for (String option2 : optionList2) { %>
						<option value="<%= option2 %>">
						<%= option2 %>
						</option>
						<% j++;} %>
					</select>
				</div>
			</div>
		</div>
		<div style="text-align:center;">
			<input type="hidden" name="count"  value="1" id="ct">
			<input type="hidden" name="sno" value="<%= product.getSno() %>" id="pn">
			<button type="button" id="cartBtn">cart</button>
		
			<input type="hidden" name="count"  value="1" id="ct">
			<input type="hidden" name="sno" value="<%= product.getSno() %>" id="pn">
			<button type="button" id="payBtn">pay</button>
		
		</div>
	</form>
	
	
	<!-- content -->
	<div style="text-align:center;">
		<button onclick="reviewFuc()">review</button>
		<button onclick="detailwFuc()">detail</button>
		<button onclick="qnawFuc()">qna</button>
		<button onclick="guideFuc()">shop&nbsp;guide</button>
	</div>
	
	<div>
		<form method="post" id="reviewForm">
			<div id="review">
				<h3>review</h3>
					<!-- 리뷰테이블에서 관련된 상품코드들을 검색하고 for 값을 이용해서 출력  -->
				<% if(totalReview == 0) { %>
				<div>해당 리뷰가 없습니다.</div>
				<% } else { %>
					<% for(ReviewDTO review : reviewList) { %>
					<% ProductDTO productR = ProductDAO.getDAO().selectProduct(review.getSno()); %>
					<div class="review" style="border: 1px solid gray; height: calc(100%/<%=reviewList.size() %>);">
						<div >
							<%= product.getSname() %> <%= productR.getSoptionFirst() %> <%=productR.getSoptionSecond() %>
						</div>
				
						<div> 
							<div style="float : left">
								<% for(int p = 0; p < review.getRrating(); p++) {%>
								★ 
								<% } %>
							</div>
							<div style="float : right"><%= review.getRdate() %></div>
						</div>
						<br>
						<span style="float : right"><%= review.getRname() %></span>
						<div><%= review.getRcontent() %></div>		
					</div>
					<% } %>
				<% } %>
				<div style="text-align: right;">
					<button type="button"
					onclick="location.href='index.jsp?workgroup=review&work=review_write&sno=<%= product.getSno()%>&sname=<%= product.getSname() %>';">
					WRITE</button>
				</div>

				<% 
					int blockSize=10;
					int startPage=(rpageNum-1)/blockSize*blockSize+1;
					int endPage=startPage+blockSize-1 ;
					if(endPage>rtotalPage) {
						endPage=rtotalPage;
					}
				
				%>
				<div style="text-align : center;">
					<% if(startPage>blockSize) { // 첫번째 블럭이 아닌 경우 %>
						<a href="index.jsp?workgroup=product&work=product_detail&sno=<%= product.getSno() %>&sname=<%= product.getSname() %>&rpageNum=1&rsearch=<%=rsearch%>&rkeyword=<%=rkeyword%>">[처음]</a>
						<a href="index.jsp?workgroup=product&work=product_detail&sno=<%= product.getSno() %>&sname=<%= product.getSname() %>&rpageNum=<%=startPage-blockSize %>&rsearch=<%=rsearch%>&rkeyword=<%=rkeyword%>">[이전]</a>
					<% } else {  // 첫번째 블럭인 경우 - 링크 미설정 %>
						[처음][이전]
					<% } %>
			
					<% for(int k=startPage ; k<=endPage ; k++ ) { %>
						<a href="index.jsp?workgroup=product&work=product_detail&sno=<%= product.getSno() %>&sname=<%= product.getSname() %>&rpageNum=<%=k %>&rsearch=<%=rsearch %>&rkeyword=<%=rkeyword %>">
							[<%=k %>]
						</a>
					<% } %>
					<% if(endPage!=rtotalPage) { // 마지막 블럭이 아닌 경우 %>
						<a href="index.jsp?workgroup=product&work=product_detail&sno=<%= product.getSno() %>&sname=<%= product.getSname() %>&rpageNum=<%=startPage+blockSize %>&rsearch=<%=rsearch%>&rkeyword=<%=rkeyword%>">[다음]</a>
						<a href="index.jsp?workgroup=product&work=product_detail&sno=<%= product.getSno() %>&sname=<%= product.getSname() %>&rpageNum=<%=rtotalPage %>&rsearch=<%=rsearch%>&rkeyword=<%=rkeyword%>">[마지막]</a>
					<% } else {  // 마지막 블럭인 경우 - 링크 미설정 %>
						[다음][마지막]
					<% } %>
		
				</div>
			</div>
		</form>
	</div>
	<div id="detail">
		<img src="<%=request.getContextPath()%>/product_image/<%= product.getSinfo() %>" width="100%">
	</div>
	<div id="qna">
		<jsp:include page="../qna/qna_list.jsp"/>
	</div>
	<div id="shopGuide">
		<h1>shop guide</h1>
		<h3>Payment Info</h3>
		<h5>계좌이체</h5>
		<div>
	<pre> 
	시스탬내에서 5-10분 간격으로 자동입금확인이 진행되고 있습니다.
	 동명이인이 있는경우 / 중복주문서를 넣어주신 경우 / 입금자명과 실제 입금자명이 다른경우 / 자동으로 확인되지 않습니다.
	</pre>
		</div>
		<div>
			<h1>Delivery Info</h1>
	<pre> 
	배송 방법 : 택배
	배송 지역 : 제주도 및 도서산간 제외한 전지역
	배송 비용 : 3,000원
	배송 기간 : 2일 ~ 3일
	
	배송 안내 : - 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.
	- 고객님께서 주문하신 상품은 결제 확인 후 출고됩니다. 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.
	</pre>
		</div>
		<div>
			<h3>Exchange Info</h3>
			<h5>다음에 해당하는 교환/반품 신청은 처리가 어려울 수 있으니 양해 부탁드립니다.</h5>
	<pre> 
	-소비자에게 책임 있는 사유로 상품이 멸실 또는 훼손된 경우
	 (포장지 훼손으로 인해 재판매가 불가능한 상품의 경우, 단순 변심에 의한 반품이 어렵습니다.)
	 -고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 감소한 경우
	 -제품 수령일로부터 7일이 지난 경우
	</pre>
		</div>
	</div>
</div>

<script type="text/javascript">

var soption1Change = function(value) {
	$("#soption1V").val(value);
};

var soption2Change = function(value) {
	$("#soption2V").val(value);
};

var qnty=1;
var price=$("#priceResult").val();
$("#totalPrice").val(qnty*price);
$(".totalPrice").text(qnty*price);

$("#result").val(qnty);

$("#add").click(function() {
	qnty++;
	$("#result").val(qnty);
	$("#totalPrice").val(qnty*price);
	$(".totalPrice").text(qnty*price);
});

$("#sub").click(function() {
	qnty--;
	$("#result").val(qnty);
	$("#totalPrice").val(qnty*price);
	$(".totalPrice").text(qnty*price);

});
//여기는 초기값

	$('#review').show();
	$('#detail').hide();
	$('#qna').hide();
	$('#shopGuide').hide();

//누를 시 변경부분


function reviewFuc() {
	$('#review').show();
	$('#detail').hide();
	$('#qna').hide();
	$('#shopGuide').hide();
}
function detailwFuc() {
	$('#review').hide();
	$('#detail').show();
	$('#qna').hide();
	$('#shopGuide').hide();
}
function qnawFuc() {
	$('#review').hide();
	$('#detail').hide();
	$('#qna').show();
	$('#shopGuide').hide();
}
function guideFuc() {
	$('#review').hide();
	$('#detail').hide();
	$('#qna').hide();
	$('#shopGuide').show();
}


/* $(".rpageBtn").click(function() {
	$("#reviewForm").attr("action");
	$("#reviewForm").submit(); 
});  */


$("#cartBtn").click(function() {
	$("#productForm").attr("action","index.jsp?workgroup=product&work=product_cart_add_action");
	$("#productForm").submit();
});
	
$("#payBtn").click(function() {
	$("#productForm").attr("action","index.jsp?workgroup=product&work=product_pay_action");
	$("#productForm").submit();
});
</script>