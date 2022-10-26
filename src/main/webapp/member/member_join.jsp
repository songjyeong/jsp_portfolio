<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%-- 회원정보를 입력받기 위한 JSP 문서 --%>
<%-- => [회원가입]을 클릭한 경우 form 태그를 이용하여 회원정보 삽입페이지(member_join_action.jsp)를 
post 방식으로 요청해 입력된 회원정보를 전달하여 페이지 이동 - 자바스크립트를 이용한 입력값 검증 --%>
<%-- => [아이디 중복 검사]를 클릭한 경우 팝업창을 이용하여 아이디 중복 검사 페이지(id_check.jsp) 요청 - 아이디 전달 --%>    
	
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">

	
<style type="text/css">

/* 레이아웃 틀 */

#join_content {
	width:700px;
}

/* 입력폼 */ 

#idCheck {
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 5px;
	border: 1px solid black;
}


input {
	font-family: Dotum, '돋움', Helvetica, sans-serif;
	width: 100%;
	height: 39px;
    vertical-align: middle;
	margin : 5px 0px 6px;
	border: 1px solid gray;
	text-align: center;
}

#mobile1, #mobile2, #mobile3 {
	width : 50px;
}

#email {
	width : 200px;
}

.label11 {
	font-size: 11.52px;
}

.error{
	padding-left:10px; 
	color:#ff0000;
	display: none;
}

/* 버튼 */
.btn_area {
	margin: 30px 0 91px;
}

#btnJoin {
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

.agreeContent {
	overflow : scroll;
	height : 152px;
	padding : 20px;
}

.Agree {
	border: 1px solid gray;
	padding : 20px;
}

.AgreeContent {
	border: 1px solid gray;
	margin : 20px;
}

#allAgree {
	width : 22px;
	height : 22px;
}

.check{
	width : 13px;
	height : 13px;
}

#join_content {
	margin-top: 50px;
}

</style>



<form action="index.jsp?workgroup=member&work=member_join_action" method="post" id="join">

<%-- 아이디 중복 검사 프로그램을 실행하여 아이디 사용 여부를 구분하기 위한 값을 저장하기 위한 입력태그 --%>
<%-- => 입력값 : 0 - 아이디 중복 검사 프로그램 미실행(입력 아이디 사용 불가능) --%>
<%-- => 입력값 : 1 - 아이디 중복 검사 프로그램 실행(입력 아이디 사용 가능) --%>
<input type="hidden" name="idCheckResult" id="idCheckResult" value="0">

	<!-- wrapper -->

		<!-- content-->
		<div id="join_content">

			<!-- ID -->
			<div>
				<label for="id" class="label11">아이디&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수">
				<span id="idCheck">아이디 중복 검사</span>
				<span id="idMsg" class="error">아이디를 입력해 주세요.</span>
				<span id="idRegMsg" class="error">대문자/공백/특수문자가 포함되었거나, 숫자로 시작 또는 숫자로만 이루어진 아이디는 사용할 수 없습니다.</span>
				<span id="idCheckMsg" class="error">아이디 중복 검사를 반드시 실행해 주세요.</span>
				<span style="float:right;"> (영문소문자/숫자, 4~16자)</span></label>
				
				<input type="text" id="id" class="int" maxlength="20" name="id"> 
			</div>

			<!-- PW1 -->
			<div>
				<label for="pswd1" class="label11">비밀번호&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수">
				<span id="pswd1Msg" class="error">비밀번호를 입력해 주세요.</span>
			<span id="pswd1RegMsg" class="error">영문 대소문자/숫자/특수문자 중 3가지 이상 조합, 8자~16자로 이루어진 비밀번호만 사용 가능합니다.</span>
			
				<span style="float:right;">(영문 대소문자/숫자/특수문자 중 3가지 이상 조합, 8자~16자)</span></label>
				<input type="password" id="pswd1" class="int" maxlength="20" name="pswd1">
			</div>

			<!-- PW2 : 비밀번호 확인 -->
			<div>
				<label for="pswd2" class="label11">비밀번호 확인&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수">
				<span id="pswd2Msg" class="error">비밀번호가 일치하지 않습니다.</span></label>
				<input type="password" id="pswd2" class="int" name="pswd2" maxlength="20">
			</div>

			<!-- NAME -->
			<div>
				<label for="name" class="label11">이름&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수">
				<span id="nameMsg" class="error">이름을 입력해 주세요.</span></label>
				<input type="text" id="name" class="int" maxlength="20" name="name">
			</div>

			<!-- MOBILE -->
			<div>
				<label for="phone" class="label11">휴대전화&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수">
				<span id="phoneMsg" class="error">휴대폰 번호를 입력해 주세요.</span>
				<span id="phoneRegMsg" class="error">유효하지 않은 휴대폰 번호입니다. 입력한 번호를 확인해 주세요.</span></label><br>
			<input type="text" name="mobile1" id="mobile1" size="4" maxlength="4">
			- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4">
			- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4">
			</div>
			
			<!-- EMAIL -->
			<div>
				<label for="email" class="label11">이메일&nbsp;<img src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수">
				<span id="emailMsg" class="error">이메일을 입력해 주세요.</span>
				<span id="emailRegMsg" class="error">유효한 이메일을 입력해 주세요.</span>
				</label><br>
	 			<input type="text" id="email" class="int" maxlength="100"  name="email">	
			</div>
			<br><br>
				<h3>전체 동의</h3><br>
			<div>
				<div class="Agree">&nbsp;&nbsp;<input type="checkbox" id="allAgree">&nbsp;&nbsp;<b>이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.</b></div>
				
				<div class="Agree">
					<span><br>&nbsp;&nbsp;[필수] 이용약관 동의</span>
					<div class="agreeContent"><%@include file="/member/agree1.jsp" %></div>
					<br><span>&nbsp;&nbsp;&nbsp;&nbsp;이용약관에 동의하십니까? 
						<input type="checkbox" name="checkAgree" id="checkAgree1" class="check" value="c1"> 동의함 </span>
				</div>
				
				<div class="Agree">
					<span><br>&nbsp;&nbsp;[필수] 개인정보 수집 및 이용 동의</span>
					<div class="agreeContent"><%@include file="/member/agree2.jsp" %></div>
					<br><span>&nbsp;&nbsp;&nbsp;&nbsp;개인정보 수집 및 이용에 동의하십니까? 
						<input type="checkbox" name="checkAgree" id="checkAgree2" class="check" value="c2"> 동의함 </span>
				</div>
				
				<div class="Agree">
					<span><br>&nbsp;&nbsp;[선택] 쇼핑정보 수신 동의</span>
					<div class="agreeContent"><%@include file="/member/agree3.jsp" %></div>
					<br><span>&nbsp;&nbsp;&nbsp;&nbsp;SMS 수신을 동의하십니까? 
						<input type="checkbox" name="checkAgreeOption" class="check" value="c3"> 동의함 </span>
				</div>
			
			</div>


			<!-- JOIN BTN-->
			<div class="btn_area">
				<button type="submit" id="btnJoin"><span>회원가입</span></button>
			</div>
		</div>
		<!-- content-->

	<!-- wrapper -->
		</form>


<script type="text/javascript">

$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display", "none");
	
	var idReg=/^[a-z]+[a-z0-9]{3,15}$/g;
	if($("#id").val()==""){
		$("#idMsg").css("display","block");
		submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display", "block");
		submitResult=false;
	} else if($("#idCheckResult").val()=="0") {
		$("#idCheckMsg").css("display","block");
		submitResult=false;
	}
	
	var pswd1Reg=/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/g;
	if($("#pswd1").val()=="") {
		$("#pswd1Msg").css("display","block");
		submitResult=false;
	} else if(!pswd1Reg.test($("#pswd1").val())) {
		$("#pswd1RegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#pswd2").val()==""||$("#pswd1").val()!=$("#pswd2").val()){
		$("#pswd2Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#name").val()==""){
		$("#nameMsg").css("display","block");
		$("#pswd1").focus();
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
	
	if($('#checkAgree1').is(":checked") == false || $('#checkAgree2').is(":checked") == false ) {
		alert("필수 약관에 동의해주세요.");
		submitResult=false;
	}
	
	return submitResult;
});

$("#idCheck").click(function() {
	$("#idMsg").css("display", "none");
	$("#idRegMsg").css("display", "none");
	
	var idReg=/^[a-z]+[a-z0-9]{3,15}$/g;
	if($("#id").val()==""){
		$("#idMsg").css("display","block");
		return;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display", "block");
		return;
	}

	window.open("<%=request.getContextPath()%>/member/id_check.jsp?id="+$("#id").val()
			,"idcheck","width=450, height=100, left=700, top=400");


});

	// 아이디 입력태그의 입력값이 변경된 경우 실행되는 이벤트 처리 명령 등록
$("#id").change(function() {
	// 아이디 중복 검사 프로그램을 미실행 상태로 변경 - 입력태그의 입력값 변경
	$("#idCheckResult").val("0");
});


	
$("#pswd1").focusout(function() {
	var focusOutPw1=true;
	var pswd1Reg=/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/g;

	$(".error").css("display", "none");

	if($("#pswd1").val()=="") {
		$("#pswd1Msg").css("display","block");
		focusOutPw1=false;
	} else if(!pswd1Reg.test($("#pswd1").val())) {
		$("#pswd1RegMsg").css("display","block");
		focusOutPw1=false;
	}
	return focusOutPw1;
});

$("#pswd2").focusout(function() {
	var focusOutPw2=true;
	$(".error").css("display", "none");

	if($("#pswd2").val()==""||$("#pswd1").val()!=$("#pswd2").val()){
		$("#pswd2Msg").css("display","block");
		focusOutPw2=false;
	}
	return focusOutPw2;
});

$("#name").focusout(function() {
	var focusOutName=true;
	$(".error").css("display", "none");

	if($("#name").val()==""){
		$("#nameMsg").css("display","block");
		$("#pswd1").focus();
		focusOutName=false;
	}
	return focusOutName;
});

$("#mobile1").focusout(function() {
	var focusOutM1=true;
	var mobile1Reg=/^01([0|1|6|7|8|9])$/g;

	$(".error").css("display", "none");

	if($("#mobile1").val()=="") {
		$("#phoneMsg").css("display", "block");
		focusOutM1=false;
	} else if(!mobile1Reg.test($("#mobile1").val())){
		$("#phoneRegMsg").css("display","block");
		focusOutM1=false;
	}
	
	return focusOutM1;
});

$("#mobile2").focusout(function() {
	var focusOutM2=true;
	var mobile2Reg=/\d{4}/;
	$(".error").css("display", "none");

	if($("#mobile2").val()=="") {
		$("#phoneMsg").css("display", "block");
		focusOutM2=false;
	} else if(!mobile2Reg.test($("#mobile2").val())){
		$("#phoneRegMsg").css("display","block");
		focusOutM2=false;
	}
	return focusOutM2;
});

$("#mobile3").focusout(function() {
	var mobile3Reg=/\d{4}/;
	var focusOutM3=true;
	$(".error").css("display", "none");

	if($("#mobile3").val()=="") {
		$("#phoneMsg").css("display", "block");
		focusOutM3=false;
	} else if(!mobile3Reg.test($("#mobile3").val())){
		$("#phoneRegMsg").css("display","block");
		focusOutM3=false;
	}
	return focusOutM3;
});

$("#email").focusout(function() {
	var focusOutEmail=true;
	$(".error").css("display", "none");

	var emailReg=/^([a-zA-z0-9._-]+@[a-zA-z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()==""){
		$("#emailMsg").css("display", "block");
		focusOutEmail=false;
	} else if(!emailReg.test($("#email").val())){
		$("#emailRegMsg").css("display","block");
		focusOutEmail=false;
	}
	
	return focusOutEmail;
});


//전체 동의
$("#allAgree").change(function() {
	if($(this).is(":checked")) {
		$(".check").prop("checked", true);
	} else {
		$(".check").prop("checked", false);	
	}
});

</script>
