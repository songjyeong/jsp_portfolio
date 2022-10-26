<%@page import="xyz.itwill.dto.PayDTO"%>
<%@page import="xyz.itwill.dao.PayDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<% 

	String payMessage = request.getParameter("inputMessage");


	
	
	PayDTO pay = new PayDTO();
	pay.setMessage(payMessage);
	
// 	PayDAO.getDAO().updateMessage(pay);


// pay_complete 페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=pay&work=pay_complete';");
	out.println("</script>");
	
	
%>