<%@page import="java.lang.reflect.Member"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	// 전달값을 반환받아 저장
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String id=request.getParameter("id");
	String phone=request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
	
	String search, keyword ;
	
	if(!email.equals("")&&phone.equals("--")) {
		search="email";
		keyword=email;
		
	} else if(email.equals("")&&!phone.equals("--")) {
		search="phone";
		keyword=phone;
	} else {
		session.setAttribute("findpwmessage", "이메일 또는 휴대폰 번호를 입력해 주세요.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=member&work=password_find';");
		out.println("</script>");
		return;
	}
	
	if(name.equals("")) {
		session.setAttribute("findpwmessage", "이름을 입력해 주세요.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=member&work=password_find';");
		out.println("</script>");
		return;
	}
	
	if(id.equals("")) {
		session.setAttribute("findpwmessage", "아이디를 입력해 주세요.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=member&work=password_find';");
		out.println("</script>");
		return;
	}
	
	MemberDTO member = MemberDAO.getDAO().selectpwCategory(search, keyword, name, id) ;
	
	if(member==null) {
		out.println("<script type='text/javascript'>");
		out.println("alert('입력하신 정보로 가입 된 회원 정보는 존재하지 않습니다.');");
		out.println("location.href='index.jsp?workgroup=member&work=password_find';");
		out.println("</script>");
		return;
	}
	
	
	String newPassword=Utility.newPassword();
	
	MemberDAO.getDAO().updatePw(id, Utility.encrypt(newPassword));
	
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
	margin-top: 100px;
}

</style>

	<center>
	<div id="all">
	<div id="pwsearchfinisth"><h2>고객님 임시 비밀번호가<br>
	 발급 완료 되었습니다.</h2></div>
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
		<tr>
			<td class="left">비밀번호</td>
			<td>: <%=newPassword %></td>
		</tr>
	</table>

	
	<div class="finishmessage"> 고객님의 비밀번호가 성공적으로 발송되었습니다. 항상 고객님의<br>
		즐겁고 편리한 쇼핑을 위해 최선의 노력을 다하는 쇼핑몰이 되도록 하겠습니다.</div>
		
	<button type="button" id="loginBtn" class="hi" onclick="location.href='index.jsp?workgroup=member&work=member_login';">로그인</button>
	</div>
	</center>
