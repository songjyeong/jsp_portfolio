<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

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
	<h2>제품등록</h2>
	
	<form action="admin.jsp?workgroup=admin&work=product_add_action_admin" method="post"
		enctype="multipart/form-data" id="productForm">
	<table border="1">
		<tr>
			<td>카테고리</td>	
		</tr>
		<tr>
			<td>제품명</td>
			<td>
				<input type="text" name="name" id="name">
			</td>
		</tr>
		<tr id="option">
			<td>
				<button type="button" id="optAddBtn">옵션추가</button>
			</td>
			<td>
				<input type="hidden" id="optionCount" name="optionCount" value="0">
			</td>
		</tr>
		<tr id="delete">
			<td>
				<button type="button" id="optDeleteBtn">옵션삭제</button>
			</td>
			<td>
			</td>
		</tr>

		<tr id="trPrice">
			<td>가격</td>
			<td> 
				<input type="text" name="price" id="price">
			</td>
		</tr>
		<tr>
			<td>대표이미지</td>
			<td>
				<input type="file" name="imageMain" id="imageMain">
			</td>
		</tr>
		<tr>
			<td>상세이미지</td>
			<td>
				<input type="file" name="imageDetail" id="imageDetail">
			</td>
		</tr>
		<tr>
			<td>
				<button type="submit">제품등록</button>
			</td>
		</tr>
	</table>	
	</form>
	
	<div id="message" style="color: red;"></div>
</div>

<script type="text/javascript">
// $("#productForm").submit(function() {
// 	if($("#name").val()=="") {
// 		$("#message").text("제품명을 입력해 주세요.");
// 		$("#name").focus();
// 		return false;
// 	}
	
// 	if($("#imageMain").val()=="") {
// 		$("#message").text("대표이미지를 입력해 주세요.");
// 		$("#imageMain").focus();
// 		return false;
// 	}
	
// 	if($("#imageDetail").val()=="") {
// 		$("#message").text("상세이미지를 입력해 주세요.");
// 		$("#imageDetail").focus();
// 		return false;
// 	}

// 	if($("#price").val()=="") {
// 		$("#message").text("제품가격을 입력해 주세요.");
// 		$("#price").focus();
// 		return false;
// 	}
// });

var i=0;
var j=1;

$("#optAddBtn").click(function() {
	if(i<=0) {i=0;}
	i++;
	$("#option").after("<tr id='optDetail1'><td>"+(i)+
			"_옵션_1</td><td> <input type='text' "+
			"name='optionInput["+i+"]' id='option1Name'>"+
			"</td></tr><tr id='optDetail2'><td>"+(i)+
			"_옵션_2</td><td> <input type='text' name='optionInput["+i+"]'"+
			" id='option2Name'></td></tr><tr id='optPrice'><td>"+(i)+
			"_가격</td><td><input type='text' "+
			"name='optionInput["+i+"]' id='price'></td></tr>");
	$("#trPrice").remove();
	$('input[id=optionCount]').attr('value',i);
});



$("#optDeleteBtn").click(function() {
	$("#optDetail1").remove();
	$("#optDetail2").remove();
	$("#optPrice").remove();
	i--;
	if(i==0) {j=0;}
	if(j==0) {
		j=1;
		$("#delete").after("<tr id='trPrice'><td>가격</td><td><input type='text' name='price' id='price'></td></tr>");
	}
	$('input[id=optionCount]').attr('value',i);
});



</script>



