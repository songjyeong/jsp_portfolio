<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	System.out.println("saveDirectory = "+saveDirectory);

	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
		, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());

	int size=Integer.parseInt(multipartRequest.getParameter("optionCount"));

	String name=multipartRequest.getParameter("name");
	String imageMain=multipartRequest.getFilesystemName("imageMain");
	String imageDetail=multipartRequest.getFilesystemName("imageDetail");

	if(size<=0) {
		int price=Integer.parseInt(multipartRequest.getParameter("price"));
		
		ProductDTO product=new ProductDTO();
		
		product.setSname(name);
		product.setSimg(imageMain);
		product.setSinfo(imageDetail);
		product.setSoptionFirst(null);
		product.setSoptionSecond(null);
		product.setSprice(price);
		
		int rows=AdminDAO.getDAO().insertProduct(product);
		if(rows<=0) {
			new File(saveDirectory, imageMain).delete();
			new File(saveDirectory, imageDetail).delete();
		}
	} else {
		for(int i=1;i<=size;i++) {
			String[] optionList=multipartRequest.getParameterValues("optionInput["+i+"]");
			
			ProductDTO product=new ProductDTO();
			
			product.setSname(name);
			product.setSimg(imageMain);
			product.setSinfo(imageDetail);
			product.setSoptionFirst(optionList[0]);
			product.setSoptionSecond(optionList[1]);
			product.setSprice(Integer.parseInt(optionList[2]));
			
			int rows=AdminDAO.getDAO().insertProduct(product);
			if(rows<=0) {
				new File(saveDirectory, imageMain).delete();
				new File(saveDirectory, imageDetail).delete();
			}
		}
		ProductDTO product=new ProductDTO();
		
		product.setSname(name);
		product.setSimg(imageMain);
		product.setSinfo(imageDetail);
		product.setSoptionFirst(null);
		product.setSoptionSecond(null);
		product.setSprice(0);
		
		int rows=AdminDAO.getDAO().insertProduct(product);
		if(rows<=0) {
			new File(saveDirectory, imageMain).delete();
			new File(saveDirectory, imageDetail).delete();
		}
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='admin.jsp?workgroup=admin&work=product_manager';");
	out.println("</script>");
%>





