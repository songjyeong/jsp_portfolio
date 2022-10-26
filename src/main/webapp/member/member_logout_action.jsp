<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그아웃 처리 후 로그인정보 입력페이지(member_login.jsp)로 이동하기
위한 정보를 클라이언트에게 전달하는 JSP 문서 --%>

<% 
	session.invalidate();

	// 로그인 페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=member&work=member_login';");
	out.println("</script>");
%>