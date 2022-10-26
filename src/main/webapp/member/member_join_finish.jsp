<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberDTO JoinMember=(MemberDTO)session.getAttribute("JoinMember");
	String id=JoinMember.getId();
	String name=JoinMember.getName();
	String email=JoinMember.getEmail();
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<style>
p {
	margin-bottom: 30px;
	text-align: center;
}

table {
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 50px;
	font-size : 17px;
}

#gomain {
	display: block;
	border: 1px solid #dfdfdf;
	width: 250px;
	padding: 20px 50px;
	border: 0;
	margin: 0 auto;
	cursor: pointer;
	color: #fff;
	background-color: black;
	box-sizing: border-box;
	transform: translateY(1px);
	transition: all 0.3s;
}
</style>

<body>


	<p style="margin-top : 120px;"><b>회원가입이 완료 되었습니다.</b></p>
	<table>
		<tr>
			<td class="leftcell"><img
				src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png">
				아이디</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><%=id %></td>
		</tr>

		<tr>
			<td class="leftcell"><img
				src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png">
				이름</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><%=name %></td>
		</tr>

		<tr>
			<td class="leftcell"><img
				src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png">
				이메일</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><%=email %></td>
		</tr>
	</table>

	<div class="btn_area">
		<button type="button" id="gomain" onclick="location.href='index.jsp';">
			<span>메인으로 이동</span>
		</button>
	</div>

</body>
</html>