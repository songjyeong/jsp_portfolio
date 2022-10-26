<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf" %>

<%-- 마이페이지 메인화면 --%>
<style type="text/css">

.contentt {
	font-size : 15px;
	padding : 0px 20px;
	color : gray;
	cursor: pointer;
	margin-top: 30px;
}

.title {
	font-size : 20px;
	cursor: pointer;
}

.mypage {
	padding : 40px 0px;
}

.aaa {
	text-decoration: none;
	color : black;
}

#Allcon {
	margin-top: 50px;
}


</style>



<center>
<div id="Allcon">
<div id="order" class="mypage">
	<a href="index.jsp?workgroup=mypage&work=order_page" class="aaa">
	<strong class="title">ORDER<br><br></strong>
	<span class="contentt">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다<br></span>
	</a>
</div>

<div id="profile" class="mypage">
	<a href="index.jsp?workgroup=mypage&work=password_confirm" class="aaa">
	<strong class="title">PROFILE<br><br></strong>
	<span class="contentt">회원이신 고객님의 개인정보를 관리하는 공간입니다.<br>
		개인정보를 최신 정보로 유지하시면 보다 간편히 쇼핑을 즐기실 수 있습니다.</span>
	</a>
</div>

<div id="board" class="mypage">
	<a href="index.jsp?workgroup=mypage&work=board_page" class="aaa">
	<strong class="title">BOARD<br><br></strong>
	<span class="contentt">고객님께서 작성하신 게시물을 관리하는 공간입니다.<br>
		고객님께서 작성하신 글을 한눈에 관리하실 수 있습니다.</span>
	</a>
</div>
</div>

</center>