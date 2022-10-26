<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/admin_check.jspf"%>

<%
	// 비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	String[] checkId = request.getParameterValues("checkId");
	
	for(String id: checkId) {
		MemberDAO.getDAO().deleteMember(id);
	}

	// 페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=admin&work=member_manager';");
	out.println("</script>");

%>