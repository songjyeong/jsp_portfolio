<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>

<% 
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}

	String pageNum = request.getParameter("pageNum");
	
	int qno=QnaDAO.getDAO().selectNextNum();
	int qpno = Integer.parseInt(request.getParameter("productlisprint"));

	// 제목과 내용 회피문자로 변환하여 저장
	String qtitle = Utility.escapeTag(request.getParameter("subject"));
	String qcontent = Utility.escapeTag(request.getParameter("content"));
	
	int qstatus=1 ;
	// 비밀글이면 qstatus=2 ; << 이거 추가하기
	if(request.getParameter("secret")!=null) {
		qstatus=2 ;
	}
	
	
	// QnaDTO 객체를 생성하고 필드값 변경
	QnaDTO qna=new QnaDTO();
	qna.setQno(qno);
	qna.setQpno(qpno);
	qna.setQtitle(qtitle);
	qna.setQwriter(loginMember.getId());
	qna.setQcontent(qcontent);
	qna.setQstatus(qstatus);
	
	
	// 게시글을 전달받아 QNA 테이블에 삽입
	QnaDAO.getDAO().insertQna(qna);
	
	// 페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=qna&work=qna_list&pageNum="+pageNum+"';");
	out.println("</script>");
	
%>