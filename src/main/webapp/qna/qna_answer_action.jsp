<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/admin_check.jspf" %>

<% 
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}

	String pageNum=request.getParameter("pageNum");
	int qno=Integer.parseInt(request.getParameter("qno"));
	

	// 답변 내용 회피문자로 변환하여 저장
	String qanswer = Utility.escapeTag(request.getParameter("answer"));
	
	// 게시글을 전달받아 QNA 테이블에 삽입
	QnaDAO.getDAO().updateQanswer(qno, qanswer);
	
	// 페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=qna&work=qna_detail&pageNum="+pageNum+"&qno="+qno+"';");
	out.println("</script>");
	
%>