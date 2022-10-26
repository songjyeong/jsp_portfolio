<%@page import="oracle.jdbc.oracore.Util"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
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

	// 전달값을 반환받아 저장
	String id=request.getParameter("id");
	
	//암호화
	String pw=request.getParameter("pswd1");

	// 비밀번호 전달값이 없는 경우
	if(pw==null || pw.equals("")) {
		pw=loginMember.getPw();  // 비밀번호 기존 비밀번호로 유지
	} else {
		pw=Utility.encrypt(pw);
	}
	
	
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String phone=request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
		// 주소
	String zipcode=request.getParameter("zipcode");
	String address1=request.getParameter("address1");
	String address2=request.getParameter("address2");
	if(address2==null||address2.equals("")) {
		address2="";
	} else {
		address2=Utility.stripTag(request.getParameter("address2"));
	}
	
	
	// DTO 객체를 생성하여 반환받은 전달값으로 필드값 변경
	MemberDTO member = new MemberDTO();
	member.setId(id);
	member.setPw(pw);
	member.setName(name);
	member.setEmail(email);
	member.setPhone(phone);
	member.setZipcode(zipcode);
	member.setAddress1(address1);
	member.setAddress2(address2);
	
	// MEMBER 테이블에 회원정보를 삽입하는 DAO 클래스의 메서드 호출
	MemberDAO.getDAO().updateMember(member);
	
	// 세션에 회원가입 정보 저장
		session.setAttribute("loginMember", MemberDAO.getDAO().selectMember(id));


	
	// 마이페이지-프로필(mypage_profile.jsp)로 이동 - 자바스크립트 이용
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=mypage&work=mypage_main';");
	out.println("</script>");
	
%>