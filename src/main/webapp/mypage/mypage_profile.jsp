<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>

<%
	// 비정상적인 요청에 대한 응답 처리
	//if(request.getMethod().equals("GET")) {
	//	out.println("<script type='text/javascript'>");
	//	out.println("location.href='index.jsp?workgroup=error&work=error_400';");
	//	out.println("</script>");
	//	return;
	//}

	// 전달값을 반환받아 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	
	// 전달된 비밀번호와 로그인 사용자의 비밀번호를 비교하여 다른 경우
	if(!passwd.equals(loginMember.getPw())) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=mypage&work=password_confirm';");
		out.println("</script>");
		return;
	}


%>
    
<style type="text/css">
table {
    border-top: 1px solid gray;
    border-collapse: collapse;
    margin-bottom: 30px;
	margin-top: 30px;
	margin: 5px auto;
  }
  th, td {
    border-bottom: 1px solid gray;
    border-left: 1px solid gray;
    padding: 10px;
  }
  th:first-child, td:first-child {
    border-left: none;
  }


.left {
	width : 160px;
	padding : 11px 0px 10px 18px;
}

.right {
	width : 1050px;
	padding : 5px 7px 4px;
	text-align: left;
	font-size: 15px;
	width : 700px;
	padding-left: 10px;
}

#postSearch {
	border: 1px solid gray;
	background-color: white;
	color : black ;
}

#btnModify, #cancel, #remove {
	padding : 15px 25px;
	border : 1px solid black;
	background-color: white;
	color : black;  
}



#btnModify:hover, #cancel:hover, #remove:hover {
	background-color: black;
	color : white;
}

.error {
	display : none;
}

#address1, #address2 {
	width : 250px;
}

input {
	font-size:14px;
}

</style>

<center>
<form action="index.jsp?workgroup=mypage&work=member_modify_action" method="post" id="modify">
<br><br>
<span style="font-weight:bold; font-size: 20px; text-align:center;">회원 정보 수정</span><br><br>
<table>
	<tr>
	<td class="left">아이디&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"></td>
	<td class="right"><input type="text" id="id" class="int" maxlength="20" name="id" readonly="readonly" value="<%=loginMember.getId()%>">&nbsp;(영문소문자/숫자, 4~16자)</td>
	</tr>
	
	<tr>
	<td class="left">비밀번호&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"></td>
	<td class="right"><input type="password" id="pswd1" class="int" maxlength="20" name="pswd1">&nbsp;(영문 대소문자/숫자/특수문자 중 3가지 이상 조합, 8~16자)</td>
	<span id="pswd1RegMsg" class="error">영문 대소문자/숫자/특수문자 중 3가지 이상 조합, 8자~16자로 이루어진 비밀번호만 사용 가능합니다.</span>
	</tr>
	
	<tr>
	<td class="left">비밀번호 확인&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"></td>
	<td class="right"><input type="password" id="pswd2" class="int" name="pswd2" maxlength="20"></td>
	<span id="pswd2Msg" class="error">비밀번호가 일치하지 않습니다.</span></label>
	</tr>
	
	<tr>
	<td class="left">이름&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"></td>
	<td class="right"><input type="text" id="name" class="int" maxlength="20" name="name" readonly="readonly" value="<%=loginMember.getName() %>"></td>
	</tr>
	
	<tr>
	<td class="left">주소&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"></td>
	<td class="right">
		<input type="text" name="zipcode" id="zipcode" class="int" size="7" readonly="readonly"
			<%if(loginMember.getZipcode()!=null)  { %> value="<%=loginMember.getZipcode()%>" <%}%>>
		<button type="button" id="postSearch">&nbsp;우편번호 ></button><br>
		
		<input type="text" id="address1" class="int" maxlength="100" name="address1" readonly="readonly"
			<%if(loginMember.getAddress1()!=null)  { %> value="<%=loginMember.getAddress1() %>" <%}%>>
			기본주소<br>
			
		<input type="text" id="address2" class="int" maxlength="100" name="address2"
			<%if(loginMember.getAddress2()!=null)  { %> value="<%=loginMember.getAddress2()%>" <%}%>
		>&nbsp;상세주소
	</td>
	</tr>

	
	<tr>
	<td class="left">휴대전화&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"></td>
	<td class="right"><input type="text" name="mobile1" id="mobile1" size="4" maxlength="4" value="<%=loginMember.getPhone().substring(0, 3)%>">
			- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4" value="<%=loginMember.getPhone().substring(4, 8)%>">
			- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4" value="<%=loginMember.getPhone().substring(9)%>"></td>
	<span id="phoneMsg" class="error">휴대폰 번호를 입력해 주세요.</span>
	<span id="phoneRegMsg" class="error">유효하지 않은 휴대폰 번호입니다. 입력한 번호를 확인해 주세요.</span>
	</tr>
	
	
	<tr>
	<td class="left">이메일&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"></td>
	<td class="right"><input type="text" id="email" class="int" maxlength="100"  name="email" value="<%=loginMember.getEmail() %>"></td>
	<span id="emailMsg" class="error">이메일을 입력해 주세요.</span>
	<span id="emailRegMsg" class="error">유효한 이메일을 입력해 주세요.</span>
	</tr>
</table>

<br><br>
	<button type="submit" id="btnModify"><span>회원정보수정</span></button>
	<button type="button" id="cancel" onclick="location.href='index.jsp?workgroup=mypage&work=mypage_main';"><span>취소</span></button>
	<button type="button" id="remove" onclick="location.href='index.jsp?workgroup=mypage&work=member_remove_action';"><span>회원탈퇴</span></button>
	
</form>
</center>


<script type="text/javascript">

$("#modify").submit(function() {
	var submitResult=true;
	
	$(".error").css("display", "none");
	
	
	var pswd1Reg=/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/g;
	if($("#pswd1").val()!="" && !pswd1Reg.test($("#pswd1").val())) {
		$("#pswd1RegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#pswd1").val()!=$("#pswd2").val()){
		$("#pswd2Msg").css("display","block");
		submitResult=false;
	}
		
	var emailReg=/^([a-zA-z0-9._-]+@[a-zA-z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()==""){
		$("#emailMsg").css("display", "block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())){
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}
	
		
	var mobile1Reg=/^01([0|1|6|7|8|9])$/g;
	var mobile2Reg=/\d{3,4}/;
	var mobile3Reg=/\d{4}/;
	if($("#mobile1").val()==""||$("#mobile2").val()==""||$("#mobile3").val()=="") {
		$("#phoneMsg").css("display", "block");
		submitResult=false;
	} else if(!mobile1Reg.test($("#mobile1").val())||
				!mobile2Reg.test($("#mobile2").val()) || !mobile3Reg.test($("#mobile3").val()) ){
		$("#phoneRegMsg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});
</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$("#postSearch").click(function() {	
    new daum.Postcode({
        oncomplete: function(data) {
        	modify.zipcode.value=data.zonecode;;
        	modify.address1.value=data.roadAddress;
        }
    }).open();
});
</script>
