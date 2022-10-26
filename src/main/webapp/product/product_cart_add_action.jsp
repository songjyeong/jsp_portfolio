<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.CartDTO"%>
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
    
	String sname = request.getParameter("productName");
	String soption_1 = request.getParameter("soption1V");
	String soption_2 = request.getParameter("soption2V");
	
	ProductDTO product = ProductDAO.getDAO().selectProductBySoptionSname(soption_1, soption_2, sname);
	
	int samount=Integer.parseInt(request.getParameter("result"));
	int sno = product.getSno();
    
     CartDTO cart = new CartDTO();
     cart.setQnty(samount);
     cart.setProductNo(sno);
     cart.setMemberID(loginMember.getId());
     
     
     ProductDAO.getDAO().insertProductCart(cart);
 	
 	out.println("<script type='text/javascript'>");
 	out.println("location.href='index.jsp?workgroup=cart&work=cart_list';");
 	out.println("</script>");

    
%>
