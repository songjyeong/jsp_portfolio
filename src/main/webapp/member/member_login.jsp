<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	//[로그인] 메뉴를 클릭하여 실행된 경우
	if(request.getParameter("login_state")!=null) {
		session.removeAttribute("url");
	} 


	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String id=(String)session.getAttribute("id");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
    
%>


<style type="text/css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">
* {
	font-family: Montserrat,'NanumBarunGothic', sans-serif;
	text-align : center ;
}

.inputt {
	width: 400px;
	font-size: 12px;
    height: 40px;
    line-height: 28px;
    padding: 2px 2px 2px 14px;
    border: 1 gray;
    color: #8F8F91;
}

#loginand {
	font-size: 18px;
	font-weight : bold;
	margin-bottom: 10px;
}

#login_btn {
	width: 400px;
    background-color: black;
    border: 1px solid black;
    height: 38px;
    line-height: 38px;
    margin-top: 20px;
    color: #fff;
    text-align: center;
}

#login_btn:hover {
	background-color: white;
	color: black;
}

#join_btn {
	width: 400px;
    border: 1px solid #e9e9e9;
    height: 38px;
    line-height: 38px;
    text-align: center;
    font-size : 16px;
}

#join_btn:hover {
	background-color: gray;
	color: white;
}

.atag {
	text-decoration: none;
	color: gray;
	font-size: 11px;
}

#space {
	margin-top: 130px;
}

.find {
	font-size : 15px;
}


</style>


<center>
<div id="space"></div>
<p id="loginand">LOGIN or CREATE AN ACCOUNT</p>
<form id="login" name="loginForm" action="index.jsp?workgroup=member&work=member_login_action" method="post">
	<label class="login_id" title="ID">
			<input type="text" name="id" id="id" value="<%=id %>" placeholder="ID" class="inputt"><br></label>
	<label class="login_password" title="PASSWORD">
			<input type="password" name="passwd" id="passwd" placeholder="PASSWORD" class="inputt"><br></label>
	<div id="message" style="color:red;"><%=message %></div>
	<div id="login_btn">LOG IN</div>
	<a href="index.jsp?workgroup=member&work=member_join" id="joinus" class="atag"><div id="join_btn">JOIN US</div></a>
</form>	
	
	<br>
	<div id="search">
		<a href="index.jsp?workgroup=member&work=id_find" class="atag"><span class="find">아이디찾기&nbsp;&nbsp;|&nbsp;&nbsp;</span></a>
		<a href="index.jsp?workgroup=member&work=password_find" class="atag"><span class="find">비밀번호찾기&nbsp;&nbsp;|&nbsp;&nbsp;</span></a>
		<a href="index.jsp?workgroup=#&work=#" class="atag"><span class="find">주문확인</span></a>
	</div>
</center>

<script type="text/javascript">
$("#id").focus();

$("#login_btn").click(function() {
	if($("#id").val()=="") {
		alert("아이디 항목은 필수 입력값입니다.");
		$("#id").focus();
		return;
	}
	
	if($("#passwd").val()=="") {
		alert("패스워드 항목은 필수 입력값입니다.");
		$("#passwd").focus();
		return;
	}
	
	
	//if($("#message").val!=""){
		//alert("아이디 또는 비밀번호가 일치하지 않습니다.")
		//return;
	//}
	
	$("#login").submit();
});

</script>
