<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 아이디를 전달받아 MEMBER 테이블에 저장된 기존 회원의 아이디와 비교하여 중복 유무를 
클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 아이디 미중복 : 아이디 사용 가능 메세지 - [아이디 사용]를 클릭한 경우 부모창 입력태그의 입력값 변경 --%>    
<%-- => 아이디 중복 : 아이디 사용 불가능 메세지 - 아이디를 입력받아 현재 페이지를 재요청 --%>

<%
	// 비정상적인 요청에 대한 응답 처리
	if(request.getParameter("id")==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => null 반환 : 전달된 아이디의 회원정보 미검색 - 아이디 미중복(아이디 사용 가능)
	// => MemberDTO 객체 반환 : 전달된 아이디의 회원정보 검색 - 아이디 중복(아이디 사용 불가능)
	MemberDTO member=MemberDAO.getDAO().selectMember(id);
%>
    
<style type="text/css">
.abcde {
	text-align: center;
	margin-top: 30px;
}

.id { 
	font-weight: bold;
	color: red; 
}

#yesok {
	background-color: white;
	color : black ; 
	border : 1px solid black;  
}

</style>

	<% if(member==null) { // 전달받은 아이디가 중복되지 않은 경우 %>
		<div class="abcde"> 입력된 <span class="id">[<%=id %>]</span>는 사용 가능한 아이디입니다.</div>
		<div class="abcde">
			<button type="button" onclick="selectId()" id="yesok">아이디 사용</button>
		</div>
		
		<script type="text/javascript">
		function selectId() {
			opener.join.id.value="<%=id%>";
			opener.join.idCheckResult.value="1";
			window.close();
		}
		</script>
		
	<% } else {  // 전달받은 아이디가 중복된 경우 %>
		<div id="message"  class="abcde">
			입력된 <span class="id">[<%=id %>]</span>는 이미 사용중인 아이디입니다.<br>
			다른 아이디를 입력하고 [확인] 버튼을 눌러주세요.
		</div>
		
		<div class="abcde">
			<form name="checkForm">
				<input type="text" name="id">
				<button type="button" onclick="idCheck();">확인</button>
			</form>
		</div>
		
		<script type="text/javascript">
		function idCheck() {
			var id=checkForm.id.value ;
			
			if(id==""){
				document.getElementById("message").innerHTML="아이디를 입력해 주세요.";
				document.getElementById("message").style="color:red";
				return;
			}
			
			var idReg=/^[a-z]+[a-z0-9]{3,15}$/g;
			if(!idReg.test(id)) {
				document.getElementById("message").innerHTML="아이디는 영문소문자/숫자, 4~16자로 입력해 주세요. 공백, 특수문자, 숫자로 시작, 숫자로만 이루어진 아이디는 사용 불가능합니다.";
				document.getElementById("message").style="color:red";
				return;
			}
			
			checkForm.submit();
		}
		
		</script>
	<% } %>
