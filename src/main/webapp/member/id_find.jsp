<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	String findidmessage=(String)session.getAttribute("findidmessage");
	if(findidmessage==""||findidmessage==null) {
		findidmessage="";
	} else {
		session.removeAttribute("findidmessage");
	}
	
%>

<style>
input {
	margin: 10px 0px 20px;
}

.check, div, p, span {
	font-size : 20px;
}

input {
	height: 30px;
	text-align: center;
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

	<center>
	<p style="margin-top:100px;"><b>아이디 찾기</b></p>
	<form action="index.jsp?workgroup=member&work=id_find_action" method="post" id="findid">
				<input type="radio" id="ckBoxEmail" checked="checked" name="check" onchange="is_checked()" class="check"><span>&nbsp;이메일</span> 
				&nbsp;&nbsp;&nbsp;<input type="radio" id="ckBoxPhone"  name="check" onchange="is_checked()" class="check"><span>&nbsp;휴대폰번호</span>
				
				<div>
				<img src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png"> 이름<br>
				<input type="text" id="name" name="name">
				<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
				</div>

				<div id="checkemail">
				<img src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png">
					이메일로 찾기<br>
				<input type="text" id="email" name="email">
				<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
				<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
				</div>
				
				<div id="checkphone">
				<img src="http://img.echosting.cafe24.com/skin/base/common/ico_arrow.png">
					휴대폰 번호로 찾기<br>
				<span id="phoneMsg" class="error">휴대폰 번호를 입력해 주세요.</span>
				<span id="phoneRegMsg" class="error">유효하지 않은 휴대폰 번호입니다. 입력한 번호를 확인해 주세요.</span>
			
				<input type="text" name="mobile1" id="mobile1" size="4" maxlength="4">
				- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4">
				- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4">
				</div>
			<div><%=findidmessage %></div>
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

// 누르면 변경됨
function is_checked() {
	// 이메일로 찾기 누르면
	if($('input[id=ckBoxEmail]').is(':checked')) {
		$('#checkemail').show();
		$('#checkphone').hide();
		
		$("#mobile1").val("");
		$("#mobile2").val("");
		$("#mobile3").val("");
		
		$("#findid").submit(function() {
			
			var submitResult=true;
			
			$(".error").css("display", "none");
			
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

	// 휴대폰 번호로 찾기 누르면
	} else if ($('input[id=ckBoxPhone]').is(':checked')) {
		$('#checkphone').show();
		$('#checkemail').hide();
		
		$("#email").val("");
		
		$("#findid").submit(function() {
			var submitResult=true;
			
			$(".error").css("display", "none");
			
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
