<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보(이름+이메일/휴대폰번호)를 전달받아 MEMBER 테이블에서 검색하여 id를 반환하고,
	아이디 찾기 완료 페이지(id_find_finish.jsp)로 이동되도록 클라이언트에게 URL 주소를 전달하는 JSP 문서 --%>
	
<% 
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	String keyword, search ;

	// 전달값을 반환받아 저장
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String phone=request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
	
	
	// 이메일 입력
	if(!email.equals("")&&phone.equals("--")) {
		search="email";
		keyword=email;
		
		// 비밀번호 입력
	} else if(email.equals("")&&!phone.equals("--")) {
		search="phone";
		keyword=phone;
	} else {
		session.setAttribute("findidmessage", "이메일 또는 휴대폰 번호를 입력해 주세요.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=member&work=id_find';");
		out.println("</script>");
		return;
	}
	
	if(name.equals("")) {
		session.setAttribute("findidmessage", "이름을 입력해 주세요.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=member&work=id_find';");
		out.println("</script>");
		return;
	}
	
	MemberDTO member = MemberDAO.getDAO().selectidCategory(search, keyword, name);
	
	if(member==null) {
		out.println("<script type='text/javascript'>");
		out.println("alert('입력하신 정보로 가입 된 회원 아이디는 존재하지 않습니다.');");
		out.println("location.href='index.jsp?workgroup=member&work=id_find';");
		out.println("</script>");
		return;
	}
%>

<style type="text/css">
h2, h4 {
	margin : 0px 0px 30px;
}

.finishmessage {
	margin : 40px 0px 20px;
}

.left {
	width : 100px;
	padding : 5px 10px;
}

.hi {
	background-color: white ;
border : 1px solid black;
padding : 5px;
font-size : 15px;
}

#all {
	margin-top: 120px;
}

</style>
	
	<center>
	<div id="all">
	<div id="idsearchfinisth"><h2>고객님 아이디 찾기가 완료 되었습니다.</h2></div>
	<table>
		<tr>
			<td class="left">이름</td>
			<td>: <%=member.getName() %></td>
		</tr>
		
		<% if(search.equals("email")) { %>
		<tr>
			<td class="left">이메일</td>
			<td>: <%=member.getEmail() %></td>
		</tr>
		
		<% } else if(search.equals("phone")) { %>
		<tr>
			<td class="left">휴대폰번호</td>
			<td>: <%=member.getPhone() %></td>
		</tr>
		<% } %>
		
		<tr>
			<td class="left">아이디</td>
			<td>: <%=member.getId() %></td>
		</tr>
	</table>

	
	<div class="finishmessage"> 고객님의 아이디 찾기가 성공적으로 이루어졌습니다. 항상 고객님의<br>
		즐겁고 편리한 쇼핑을 위해 최선의 노력을 다하는 쇼핑몰이 되도록 하겠습니다.</div>
		
	<button type="button" id="loginBtn" class="hi" onclick="location.href='index.jsp?workgroup=member&work=member_login';">로그인</button>
	<button type="button" id="passwdFind" class="hi" onclick="location.href='index.jsp?workgroup=member&work=password_find';">비밀번호 찾기</button>
	</div>
	</center>
