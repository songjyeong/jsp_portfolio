<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="/security/login_check.jspf" %>

<%
	String message=(String)session.getAttribute("message");
	if(message!=null) {
		session.removeAttribute("message");
	} else { message=" " ;}
	
%>

<style type="text/css">
#allconfirm {
	margin-top: 100px;
}

#writefinish {
	margin : 20px;
	background-color: white;
	color : black;
	border : 1px solid black;
	padding : 10px;
}
</style>

<center>
<div id="allconfirm">
<p><b>비밀번호를 입력해 주세요.</b></p><br>
<form method="post" name="passwordForm">
	<input type="password" name="passwd" style="text-align:center; font-size:20px;"><br>
	<button type="button" onclick="submitCheck();" id="writefinish">입력완료</button>
</form>
<p id="message" style="color: red;"><%=message %></p>
</div>
</center>


<script type="text/javascript">
passwdForm.passwd.focus();

function submitCheck() {
	if(passwordForm.passwd.value=="") {
		document.getElementById("message").innerHTML="비밀번호를 입력해 주세요.";
		passwordForm.passwd.focus();
		return;
	}
	
	passwordForm.action="index.jsp?workgroup=mypage&work=mypage_profile";
	passwordForm.submit();
}

</script>