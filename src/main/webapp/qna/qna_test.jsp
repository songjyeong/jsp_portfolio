<%@page import="java.util.Random"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- BOARD 테이블에 게시글(새글)을 500개 저장하는 JSP 문서 - 테스트 프로그램 --%>
<%
	QnaDTO qna=new QnaDTO();
	Random random=new Random();

	for(int i=150;i<=300;i++) {
		
		
		
		qna.setQno(i);
		qna.setQpno(random.nextInt(12)+1);
		qna.setQtitle("테스트-"+i);
		qna.setQwriter("asdfasdfsadfsdf");
		qna.setQcontent("게시글 연습-"+i);
		int j=i%4;
		System.out.println(j);

		if(j==0) {
			qna.setQanswer("답변 연습"+i);
		} else {
			qna.setQanswer(null);
		}
		qna.setQstatus(random.nextInt(3));
		
		
		
		
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