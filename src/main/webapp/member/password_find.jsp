<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String findpwmessage=(String)session.getAttribute("findpwmessage");
	if(findpwmessage==""||findpwmessage==null) {
		findpwmessage="";
	} else {
		session.removeAttribute("findpwmessage");
	}
	
%>

<style>
p {
	margin-bottom: 30px;
	text-align: center;
	margin-top:100px;
	font-size : 20px;
}

input {
	margin:5px;
}

.error {
	display : none;
}

#gomain {
	background-color: white ;
	border : 1px solid black;
	padding : 5px;
	font-size : 15px;
	margin-top:30px;
	cursor:pointer;
}

</style>



	<p><b>비밀번호 찾기</b></p>
<center>
	<form action="index.jsp?workgroup=member&work=password_find_action" method="post" id="findpassword">
		<input type="radio" id="ckBoxEmail" value="checkemail" checked="checked" name="check" onchange="is_checked()" class="check"><span>이메일</span> 
		<input type="radio" id="ckBoxPhone" value="checkphone" name="check" onchange="is_checked()" class="check"><span>휴대폰번호</span>
		<br><br>
		<img src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png">
			아이디
		<div id="idMsg" class="error">아이디를 입력해 주세요.</div>
		<br><input type="text" id="id" name="id"><br>
		<br>

		<img src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png">
			이름
		<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
		<br><input type="text" id="name" name="name"><br>
		<br>
			
		<div id="checkemail">
			<img src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png"> 이메일로 찾기
			<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
			<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
			<br><input type="text" id="email" name="email"><br>
		</div>
		
		<div id="checkphone">
			<img src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png">
				휴대폰 번호로 찾기
			<span id="phoneMsg" class="error">휴대폰 번호를 입력해 주세요.</span>
			<span id="phoneRegMsg" class="error">유효하지 않은 휴대폰 번호입니다. 입력한 번호를 확인해 주세요.</span>
			<br><input type="text" name="mobile1" id="mobile1" size="4" maxlength="4">
			- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4">
			- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4"><br>
		</div>
			<div><%=findpwmessage %></div>
		<div class="btn_area">
			<button type="submit" id="gomain" name="gomain">
				<span>확인</span>
			</button>
		</div>
	</form>
</center>

	
<script type="text/javascript">

// 초기값
$('#checkemail').show();
$('#checkphone').hide();

function is_checked() {
	// 이메일로 찾기 누르면
if($('input[id=ckBoxEmail]').is(':checked')) {
		$('#checkemail').show();
		$('#checkphone').hide(); 
		
		$("#mobile1").val("");
		$("#mobile2").val("");
		$("#mobile3").val("");
		
$("#findpassword").submit(function() {
			
			var submitResult=true;
			
			$(".error").css("display", "none");
			
			var idReg=/^[a-z]+[a-z0-9]{3,15}$/g;
			if($("#id").val()==""){
				$("#idMsg").css("display","block");
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
			
			if($("#name").val()==""){
				$("#nameMsg").css("display","block");
				submitResult=false;
			}
			
			return submitResult;
		});
//휴대폰 번호로 찾기 누르면
} else if ($('input[id=ckBoxPhone]').is(':checked')) {
	$('#checkphone').show();
	$('#checkemail').hide(); 
	
	$("#email").val("");
	
	$("#findpassword").submit(function() {
		var submitResult=true;
		
		$(".error").css("display", "none");
		
		var idReg=/^[a-z]+[a-z0-9]{3,15}$/g;
		if($("#id").val()==""){
			$("#idMsg").css("display","block");
			submitResult=false;
		} 
		
		var mobile1Reg=/^01([0|1|6|7|8|9])$/g;
		var mobile2Reg=/\d{4}/;
		var mobile3Reg=/\d{4}/;
		if($("#mobile1").val()==""||$("#mobile2").val()==""||$("#mobile3").val()=="") {
			$("#phoneMsg").css("display", "block");
			submitResult=false;
		} else if(!mobile1Reg.test($("#mobile1").val())||
					!mobile2Reg.test($("#mobile2").val()) || !mobile3Reg.test($("#mobile3").val()) ){
			$("#phoneRegMsg").css("display","block");
			submitResult=false;
		}
		
		if($("#name").val()==""){
			$("#nameMsg").css("display","block");
			submitResult=false;
		}
		
		return submitResult;
	});
	
	}
}


</script>