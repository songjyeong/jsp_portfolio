<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>

<% 

	
	// 비정상적인 요청에 대한 응답 처리
	if(request.getParameter("qno")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	int qno=Integer.parseInt(request.getParameter("qno"));
	String pageNum = request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	QnaDTO qna = QnaDAO.getDAO().selectQna(qno);
	
	if(qna==null||qna.getQstatus()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}
	
	if(!loginMember.getId().equals(qna.getQwriter()) && loginMember.getStatus()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}
	
	QnaDAO.getDAO().updateStatus(qno, 0);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=qna&work=qna_list&qno="+qno
			+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");	
	
%>