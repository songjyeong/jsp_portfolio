<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>

<%
	List<ProductDTO> productlist = QnaDAO.getDAO().selectProductnotnullList();

	// 새글 : board_list.jsp 문서에 의해 요청한 경우 - 전달값 : X    
	// 답글 : board_detail.jsp 문서에 의해 요청한 경우 - 전달값 : O >> 부모글(pageNum, qno)
	
	//전달값을 반환받아 저장 - 전달값이 없는 경우(새글인 경우) 초기값 저장
	String pageNum="1";
	
	// 이거 어떻게 수정할지 생각 !!!!!!!!!!!!!!!!!!!!!
	//if(request.getParameter("ref")!=null) {//전달값이 있는 경우(답글인 경우)
	//	pageNum=request.getParameter("pageNum");
	//	pageNum=request.getParameter("qno");
	// }


%>



<style type="text/css">
.contentdiv {
	overflow : scroll ;
	width : 1196px;
	height : 440px;
	padding : 20px;
	margin : 10px;
}

table {
	margin: 5px auto;
    border-top: 1px solid gray;
    border-collapse: collapse;
  }
  
  th, td {
    border-bottom: 1px solid gray;
    padding: 10px;
  }
  
  .sel {
  	font-size: 16px;
  }
 .butttt {
 background-color: white ;
border : 1px solid black;
padding : 5px;
font-size: 20px;
  }

</style>


<form action="index.jsp?workgroup=qna&work=qna_write_action" method="post" id="qnaForm">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr>
			<th>상품정보</th>

			<td>
			<select name="productlisprint" class="sel">
				<% for( ProductDTO product : productlist) { %>
				<option value="<%=product.getSno()%>"><%=product.getSname()%>/<%=product.getSoptionFirst()%>/<%=product.getSoptionSecond()%></option> 
				<% } %>
			</select>
			</td>
		</tr>

		<tr>
			<th>제목</th>
			<td><input type="text" class="sel" name="subject" id="subject" size="40" placeholder="[상품] 상품관련 문의드립니다." value="[상품] 상품관련 문의드립니다."></td>
		</tr>	
		
		
		<tr>
			<th colspan="2">
				<textarea name="content" id="qcontent" class="contentdiv">
				</textarea>
			</th>
		</tr>
		
		<tr>	
			<th>비밀글설정</th>
			<td><input type="checkbox" name="secret" value="2" checked="checked">비밀글</td>
		</tr>
		
	</table>

<center><br>
			<button type="submit" class="butttt">등록</button>
			<button type="button" class="butttt" id="resetBtn" onclick="location.href='index.jsp?workgroup=qna&work=qna_list';">취소</button>
			</center>
</form>

<div id="message" style="color:red;"></div>


<script type="text/javascript">
$("#qtitle").focus();

$("#qnaForm").submit(function() {
	if($("#subject").val()=="") {
		alert("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#qcontent").val()=="") {
		alert("내용을 입력해 주세요.");
		$("#qcontent").focus();
		return false;
	}
});


</script>