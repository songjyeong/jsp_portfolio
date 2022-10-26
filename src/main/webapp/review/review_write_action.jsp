<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/security/login_check.jspf" %>
    
<%
String saveDirectory=request.getServletContext().getRealPath("/product_image");
MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
		, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
  System.out.println(request.getParameter("rstar"));
    
int rrating = Integer.parseInt(multipartRequest.getParameter("rstar"));
String rcontent = multipartRequest.getParameter("rcontent");
int sno = Integer.parseInt(multipartRequest.getParameter("sno"));
String soption_1 = multipartRequest.getParameter("soption1R");
String soption_2 = multipartRequest.getParameter("soption2R");
String sname = multipartRequest.getParameter("sname");


ProductDTO product = ProductDAO.getDAO().selectProductBySoptionSname(soption_1, soption_2, sname);

     ReviewDTO review = new ReviewDTO();
     review.setRname(loginMember.getId());
     review.setRrating(rrating);
     review.setRcontent(rcontent);
     review.setSno(product.getSno());
     
     ReviewDAO.getDAO().insertReview(review);
     System.out.println("aaaa"+review.getRcontent());
 	
 	out.println("<script type='text/javascript'>");
 	out.println("location.href='index.jsp';");
 	out.println("</script>");

    
%>
    