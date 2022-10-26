<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- => 인증 실패 : 로그인정보 입력페이지(member_login.jsp)로 이동 --%>    
<%-- => 인증 성공 : 세션에 권한 관련 정보를 저장하고 기존 요청 페이지로 이동 - 기존 요청페이지가 
없는 경우 메인페이지(main/main_content.jsp)로 이동 --%>

<%
	// 비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	// 전달값을 반환받아 저장
	String id=request.getParameter("id");
	// 암호화
	String pw=Utility.encrypt(request.getParameter("passwd"));
	
	// 아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 검색하여 반환하는 DAO 클래스의 메서드 호출
	MemberDTO member=MemberDAO.getDAO().selectMember(id);
	
	// 1. 검색된 아이디의 회원정보가 없거나 탈퇴회원인 경우 - 아이디 인증 실패
	// 2. 전달된 비밀번호와 검색된 회원정보의 비밀번호가 같지 않은 경우 - 비밀번호 인증 실패
	// 두 경우 모두 아이디 또는 비밀번호가 일치하지 않습니다. 팝업으로 뜨게 함 (참고 사이트)
	if(member==null|| !pw.equals(member.getPw())) {
		session.setAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
		session.setAttribute("id", id);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=member&work=member_login';");
		out.println("</script>");
		return;
	}
	
	if(member.getStatus()==0) {
		session.setAttribute("message", "탈퇴회원입니다.");
		session.setAttribute("id", id);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=member&work=member_login';");
		out.println("</script>");
		return;
	}
	
	
	
	
	// 인증 성공, 세션에 권한 관련 정보(회원정보) 저장
	session.setAttribute("loginMember", MemberDAO.getDAO().selectMember(id));
	
	// 세션에 저장된 요청 페이지의 URL 주소를 반환받아 저장
	String url=(String)session.getAttribute("url");
	
	if(url==null) { // 요청 페이지의 URL 주소가 없는 경우
		// 메인페이지로 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp';");
		out.println("</script>");
	} else { // 요청 페이지의 URL 주소가 있는 경우
		session.getAttribute("url");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+url+"';");
		out.println("</script>");
	}
%>
