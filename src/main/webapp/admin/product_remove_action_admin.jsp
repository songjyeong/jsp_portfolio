<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	
	int prdno=Integer.parseInt(request.getParameter("productNum"));
	
	ProductDTO product= AdminDAO.getDAO().selectProduct(prdno);

	if(product.getSoptionFirst()==null&&product.getSoptionSecond()==null) {
		List<ProductDTO> productList=AdminDAO.getDAO().selectProductNameList(product.getSname());
		for(ProductDTO prd:productList) {
			//아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 삭제하는 DAO 클래스의 메소드 호출
			AdminDAO.getDAO().deleteProduct(prd);
		}
	} else {
		AdminDAO.getDAO().deleteProduct(product);
	}

	//배열에 저장된 요소를 하나씩 반복적으로 제공받아 일괄처리

	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='admin.jsp?workgroup=admin&work=product_manager';");
	out.println("</script>");

%>