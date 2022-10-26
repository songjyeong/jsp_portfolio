<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}	
	

	String[] numList=request.getParameterValues("checkNum");
	String status=request.getParameter("status");
	
	for(String num : numList) {
		AdminDAO.getDAO().updatePay(num, status);
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='admin.jsp?workgroup=admin&work=pay_manager';");
	out.println("</script>");	
%>