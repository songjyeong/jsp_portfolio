<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.PayDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/security/login_url.jspf" %>
    
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
    
     PayDTO pay = new PayDTO();
     pay.setQnty(samount);
     pay.setPrdNO(sno);
     pay.setMemID(loginMember.getId());
     pay.setAddr1(loginMember.getAddress1());
     pay.setAddr2(loginMember.getAddress2());
     pay.setMessage(null);
     pay.setOrdStatus(0);
     pay.setPhone(loginMember.getPhone());
     pay.setZipcode(loginMember.getZipcode());
     
     ProductDAO.getDAO().insertProductPay(pay);
 	
 	out.println("<script type='text/javascript'>");
 	out.println("location.href='index.jsp?workgroup=pay&work=pay_list';");
 	out.println("</script>");

    
%>