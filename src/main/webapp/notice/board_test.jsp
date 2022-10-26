<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- BOARD 테이블에 게시글(새글)을 500개 저장하는 JSP 문서 - 테스트 프로그램 --%>
<%
	NoticeDTO board=new NoticeDTO();
	for(int i=1;i<=500;i++) {
		int num=NoticeDAO.getDAO().selectNextNum();
		
		board.setNno(num);
		board.setNtitle("테스트-"+i);
		board.setNcontent("게시글 연습-"+i);
		
		NoticeDAO.getDAO().insertNotice(board);
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>500개의 테스트 게시글을 저장 하였습니다.</h1>
</body>
</html>