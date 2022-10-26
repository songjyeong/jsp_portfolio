<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%


	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값과 업로드 처리된 파일명을 반환받아 저장
	int num=Integer.parseInt(multipartRequest.getParameter("num"));
	String currentImageMain=multipartRequest.getParameter("currentImageMain");
	String currentImageDetail=multipartRequest.getParameter("currentImageDetail");
	String name=multipartRequest.getParameter("name");
	String imageMain=multipartRequest.getFilesystemName("imageMain");
	String imageDetail=multipartRequest.getFilesystemName("imageDetail");
	int price=Integer.parseInt(multipartRequest.getParameter("price"));
	
	//DTO 객체를 생성하여 전달값(파일명)을 이용하여 필드값 변경
	ProductDTO product=new ProductDTO();
	product.setSno(num);
	product.setSname(name);
	if(imageMain==null) {//전달된 대표이미지 파일이 없는 경우
		product.setSimg(currentImageMain);
	} else {//전달된 대표이미지 파일이 있는 경우
		product.setSimg(imageMain);
		//서버 디렉토리에 저장된 기존 제품의 대표이미지 파일을 삭제 처리
		new File(saveDirectory, currentImageMain).delete();
	}
	if(imageDetail==null) {//전달된 상세이미지 파일이 없는 경우
		product.setSinfo(currentImageDetail);
	} else {//전달된 상세이미지 파일이 있는 경우
		product.setSinfo(imageDetail);
		//서버 디렉토리에 저장된 기존 제품의 상세이미지 파일을 삭제 처리
		new File(saveDirectory, currentImageDetail).delete();
	}
	product.setSprice(price);	
	
	//제품정보를 전달받아 PRODUCT 테이블에 저장된 제품정보를 변경하는 DAO 클래스의 메소드 호출
	AdminDAO.getDAO().updateProduct(product);	
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='admin.jsp?workgroup=admin&work=product_detail_admin&num="+product.getSno()+"';");
	out.println("</script>");
%>