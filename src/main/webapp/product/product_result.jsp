<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	int num = Integer.parseInt(request.getParameter("result"));
	int total = Integer.parseInt(request.getParameter("totalPrice"));
%>

<div>
<%=num %>
<br>
<%=total %>

</div>
