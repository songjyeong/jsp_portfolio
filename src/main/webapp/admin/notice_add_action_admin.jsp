<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}

	String pageNum=request.getParameter("pageNum");

	
	String subject=Utility.escapeTag(request.getParameter("subject"));
	String content=Utility.escapeTag(request.getParameter("content"));
	
	int num=NoticeDAO.getDAO().selectNextNum();
	
	NoticeDTO notice=new NoticeDTO();
	
	notice.setNno(num);
	notice.setNtitle(subject);
	notice.setNcontent(content);
	
	NoticeDAO.getDAO().insertNotice(notice);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='admin.jsp?workgroup=admin&work=notice_manager&pageNum="+pageNum+"';");
	out.println("</script>");
%>