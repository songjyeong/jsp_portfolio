<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>

<%
	//비정상적인 요청에 대한 응답 처리
	//	if(request.getMethod().equals("GET")) {
	//		out.println("<script type='text/javascript'>");
	//		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
	//		out.println("</script>");
	//		return;
	//	}

	// 아이디와 상태정보를 전달받아 MEMBER 테이블에 저장된 회원의 상태정보를 변경
	MemberDAO.getDAO().updateStatus(loginMember.getId(), 0);
	
	// 페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=member&work=member_logout_action';");
	out.println("</script>");

%>