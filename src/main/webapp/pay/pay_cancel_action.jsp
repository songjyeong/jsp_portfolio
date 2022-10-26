<%@page import="xyz.itwill.dao.PayDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>


<%

if(request.getMethod().equals("GET")) {
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=error&work=error_400';");
	out.println("</script>");
	return;			
}

String[] checkNum=request.getParameterValues("checkNum");

for(String num:checkNum) {
	PayDAO.getDAO().cancelPay(num);
}

//페이지 이동
out.println("<script type='text/javascript'>");
out.println("location.href='index.jsp?workgroup=mypage&work=order_page';");
out.println("</script>");
%>

%>
