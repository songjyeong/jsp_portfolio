<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/admin_check.jspf"%>

<% 
	// MEMBER 테이블에 저장된 모든 회원정보를 검색하여 반환하는 DAO 클래스의 메서드 호출
	List<MemberDTO> memberList = MemberDAO.getDAO().selectMemberList();
%>

<style type="text/css">


table {
	margin : 0 auto;
	border : 1px solid black;
	border-collapse: collapse;
}

th,td {
	border : 1px solid black;
	padding : 3px;
	text-align: center;
	font-size: 12px;
}

th {
	background-color: lightgray;
}

#removeBtn {
	padding : 10px;
	margin : 20px;
	background-color: white;
	color : black ;
}

.member_check { width : 80px; }
.member_id { width : 80px; }
.member_name { width : 80px; }
.member_phone { width : 140px; }
.member_email { width : 140px; }
.member_address { width : 300px; }
.member_status { width : 80px; }

</style>
<center><br><br>
<h2>회원목록</h2><br>
<form name="memberForm" id="memberForm">
	<table>
		<tr>
			<th><input type="checkbox" id="allCheck"></th>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대전화</th>
			<th>이메일</th>
			<th>주소</th>
			<th>상태</th>
		</tr>
		
		<%for (MemberDTO member : memberList) { %>
		<tr>
			<td class="member_check">
				<% if(member.getStatus()==9) { %>
				관리자
				<% } else { %>
					<input type="checkbox" name="checkId" value="<%=member.getId() %>" class="check">
				<% } %>
			</td>
			<td class="member_id"><%=member.getId() %></td>
			<td class="member_name"><%=member.getName() %></td>
			<td class="member_phone"><%=member.getPhone() %></td>
			<td class="member_email"><%=member.getEmail() %></td>
			<td class="member_address">[<%=member.getZipcode() %>]<%=member.getAddress1() %><%=member.getAddress2() %></td>
			<td class="member_status">
				<select class="status" name="<%=member.getId() %>">
					<option value="1" <% if(member.getStatus()==1) { %> selected="selected" <% } %> >일반회원</option>
					<option value="9" <% if(member.getStatus()==9) { %> selected="selected" <% } %> >관리자</option>
				</select>
			</td>
		</tr>
		<% } %>
	</table>
	<br>
	<p> <button type="button" id="removeBtn">선택회원삭제</button></p>

</form>
</center>


<script type="text/javascript">
$("#allCheck").change(function() {
	if($(this).is(":checked")) {
		$(".check").prop("checked", true);
	} else {
		$(".check").prop("checked", false);	
	}
});

$("#removeBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		alert("선택된 회원이 없습니다.");
		return;
	}
	
	$("#memberForm").attr("action", "index.jsp?workgroup=admin&work=member_remove_action");
	$("#memberForm").attr("method","post");
	$("#memberForm").submit();
});

$(".status").change(function() {
	var id = $(this).attr("name");
	var status= $(this).val();
	location.href="index.jsp?workgroup=admin&work=member_status_action&id="+id+"&status="+status;
});

</script>