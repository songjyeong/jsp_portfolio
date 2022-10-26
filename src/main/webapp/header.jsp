<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	String context=request.getContextPath();
// 	System.out.println("ContextPath = "+context);

	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

	String url = request.getRequestURL().toString();
	request.setAttribute("url", url);
	
	String workgroup=request.getParameter("workgroup");
	String work=request.getParameter("work");


%>
<style type="text/css">

.main_menu {
	max-width:2000px;
	position:fixed;
	top:0;
	width:100%;
}

.ulNav {
	border:none;
  list-style-type: none;
  margin: 0;
  padding: 0;
  background-color: #f1f1f1;

}
.liNav a {
  display: block;
  color: #000;
  padding: 8px 16px;
  text-decoration: none;
}
/* Change the link color on hover */
.liNav a:hover {
  background-color: #555;
  color: white;
}

.sidenav {
    height: 100%;
    width: 0;
    position: fixed;
    z-index: 3;
    top: 0;
    left: 0;
    background-color: white;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
}

.sidenav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #818181;
    display: block;
    transition: 0.3s;
}

.sidenav a:hover {
    color: #f1f1f1;
}

.sidenav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
}


</style>

<div class="main_menu" style="display: flex; text-align: center; z-index: 2;" id="main_menu_script">
	<div style="flex: 1;">
	<button onclick="openNav()"
		style="border: none; color: inherit; 
		background-color: inherit;">
		<h1>☰</h1></button>
	</div>
	<div style="flex: 3; cursor: pointer;" onclick="location.href ='index.jsp'"><h1>YUMYUMYUM</h1></div>
	
	<% if(loginMember==null) { %>
	<div style="flex: 1;  cursor:pointer;" onclick="location.href ='index.jsp?workgroup=member&work=member_login&login_state=1';"><h1>login</h1></div>
	<% } else { %>
	<div style="flex: 1;  cursor:pointer;" onclick="location.href ='index.jsp?workgroup=member&work=member_logout_action';"><h1>logout</h1></div>
	<% } %>
</div>

<div id="mySidenav" class="sidenav">
	<div>
		<p>search</p>
		<form action="index.jsp?workgroup=product&work=product_list" method="post">
			<input type="text" name="productSearch">
			<button type="submit">search</button>	
		</form>
	</div>

	<ul class="ulNav">
		<li class="liNav"><a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a></li>
		<% if(loginMember==null) { %>
			<li class="liNav"><a href="index.jsp?workgroup=member&work=member_join">Join</a></li>
		<% } else { %>
			<li class="liNav"><a><%=loginMember.getName() %>님 welcome</a></li>
			<% if(loginMember.getStatus()!=9) { %>
			<li class="liNav"><a href="index.jsp?workgroup=mypage&work=mypage_main">MyPage</a></li>
			<% }else if(loginMember!=null&&loginMember.getStatus()==9) {  %>
			<li class="liNav"><a href="admin.jsp">ADMIN</a></li>
			<% } %>
		<% } %>
		<li class="liNav"><a href="index.jsp?workgroup=company&work=company_list">Brand</a></li>
		<li class="liNav"><a href="index.jsp?workgroup=product&work=product_list">Product</a></li>
		<li class="liNav"><a href="index.jsp?workgroup=notice&work=notice_list">Notice</a></li>
		<li class="liNav"><a href="index.jsp?workgroup=qna&work=qna_list">Q&amp;A</a></li>
	</ul>

</div>

<input type="hidden" id="workgroup" value="<%=workgroup%>">
<input type="hidden" id="work" value="<%=work%>">

<script type="text/javascript">


	
	function openNav() {
	    document.getElementById("mySidenav").style.width = "250px";
	}

	function closeNav() {
	    document.getElementById("mySidenav").style.width = "0";
	}

	if($("#workgroup").val()!=null&&($("#work").val()!=null)) {
 		document.getElementById("main_menu_script").style.position = "static";
	}
	
	
</script>		
