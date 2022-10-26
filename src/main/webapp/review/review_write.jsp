<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<% 
int sno = Integer.parseInt(request.getParameter("sno"));
ProductDTO product = ProductDAO.getDAO().selectProduct(sno);

String sname = request.getParameter("sname");
List<String> optionList1 = ProductDAO.getDAO().selectProductOption1(sname);
List<String> optionList2 = ProductDAO.getDAO().selectProductOption2(sname);

%>

<style>
.container {
text-align : center;
}

#rating{
    display: inline-block;
    direction: rtl;
    border:0;
}
#rating legend{
    text-align: right;
}
#rating input[type=radio]{
    display: none;
}
#rating label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#rating label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#rating label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#rating input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
</style>

<div class="container">

<div class="container_inner">
<h2 align="center">후기 등록</h2>
<br>
<form action="index.jsp?workgroup=review&work=review_write_action" method="post" enctype="multipart/form-data" id="reviewform">

     <div class="form-group">
      <label for="p_name">구매한 상품:</label>
      <input type="text" class="form-control" id="sname" placeholder="Enter Title" name="sname" value= <%= product.getSname() %> readonly="readonly">
    </div>
    
    <div class="form-group">
      <label for="p_option">구매한 상품 옵션 : </label>
      
				<input type="hidden" id="soption1R" name="soption1R"/>
				<select id="soptionFirstR" onchange="soption1ChangeR(this.value);"><%  int i = 1;
				for (String option1 : optionList1) { 
				 %>
					<option value="<%= option1 %>">
					<%= option1 %>
				 	</option>
					
					<% i++;} %>
				</select>
				
				<input type="hidden" id="soption2R" name="soption2R"/>
				<select id="soptionSecondR" onchange="soption2ChangeR(this.value);"><% int j = 1;
				for (String option2 : optionList2) { 
				 %>
					<option value="<%= option2 %>">
					<%= option2 %>
					</option>
					<% j++;} %>
				</select>
    </div>
    
    
    <fieldset id="rating">
		<span class="text-bold">별점을 선택해주세요</span>
		<input type="radio" name="rstar" value="5" id="rate1"><label
			for="rate1">★</label>
		<input type="radio" name="rstar" value="4" id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="rstar" value="3" id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="rstar" value="2" id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="rstar" value="1" id="rate5"><label
			for="rate5">★</label>
	</fieldset>
    
     <div class="form-group">
      <label for="title">작성자:</label>
      <input type="text" class="form-control" id="rname" placeholder="Enter Title" name="rname" value="test1" readonly="readonly">
    </div>
    
 
     <div class="form-group">
      <label for="contents">후기 내용:</label>
      <textarea rows="20" cols=""  class="form-control" id="rcontent" placeholder="Enter Contents" name="rcontent"></textarea>
    </div>
      
	<input type="hidden" class="form-control" id="sno" placeholder="Enter Title" name="sno" value=<%= product.getSno() %>>
   
    <button type="submit">등록</button>
   
</form>
<div id="message" style="color:red;"></div>

</div>
</div>

<script type="text/javascript">
var soption1ChangeR = function(value) {
	$("#soption1R").val(value);
};

var soption2ChangeR = function(value) {
	$("#soption2R").val(value);
};

$("#rcontent").focus();

$("#reviewform").submit(function() {
	if($("#rcontent").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#rcontent").focus();
		return false;
	}
});


</script>
