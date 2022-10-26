<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보를 전달받아 MEMBER 테이블에 삽입하고 회원가입 완료페이지(member_join_finish.jsp)로 이동되도록
클라이언트에게 URL 주소를 전달하는 JSP 문서 --%>  

<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	// 전달값을 반환받아 저장
	String id=request.getParameter("id");
	//암호화
	String pw=Utility.encrypt(request.getParameter("pswd1"));
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String phone=request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
	
	// DTO 객체를 생성하여 반환받은 전달값으로 필드값 변경
	MemberDTO member = new MemberDTO();
	member.setId(id);
	member.setPw(pw);
	member.setName(name);
	member.setEmail(email);
	member.setPhone(phone);
	
	// MEMBER 테이블에 회원정보를 삽입하는 DAO 클래스의 메서드 호출
	MemberDAO.getDAO().insertMember(member);
	
	// 세션에 회원가입 정보 저장
		session.setAttribute("JoinMember", member);


	
	// 회원가입 완료페이지(member_join_finish.jsp)로 이동 - 자바스크립트 이용
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=member&work=member_join_finish';");
	out.println("</script>");
	
%>