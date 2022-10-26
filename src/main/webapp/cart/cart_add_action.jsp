<%@page import="xyz.itwill.dao.PayDAO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dao.CartDAO"%>
<%@page import="xyz.itwill.dto.CartDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.dto.PayDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_url.jspf" %>


<%
	
	String message = request.getParameter("inputMessage");
	String [] cartPayNumList = request.getParameterValues("check");
	

	for(String cartNum : cartPayNumList) {
		
		int num = Integer.parseInt(cartNum);
		
		CartDTO cart = CartDAO.getDAO().selectCartNum(num);
				
		
		int payNum = PayDAO.getDAO().selectNextPayNum();
				
		PayDTO pay = new PayDTO();
		
		pay.setOrdNo(payNum);
		pay.setMemID(loginMember.getId());
		pay.setPrdNO(cart.getProductNo());
		pay.setZipcode(loginMember.getZipcode());
		pay.setAddr1(loginMember.getAddress1());
		pay.setAddr2(loginMember.getAddress2());
		pay.setPhone(loginMember.getPhone());
		pay.setMessage(message);
		pay.setQnty(cart.getQnty());
		pay.setOrdStatus(0);
		
		PayDAO.getDAO().insertPay(pay);
		
		CartDAO.getDAO().deleteCart(cartNum);
	}
	
// cart_message_action 페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=pay&work=pay_list';");
	out.println("</script>");
%>



