<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String pageNum="1";
%>

<style type="text/css">
table {
	margin: 0 auto;
}

th {
	width: 70px;
	font-weight: normal;
}

td {
	text-align: left;
}
</style>

<div id="content">
	<div class="container-fluid">
		<br>
		<!-- Page Heading -->
		<h1 class="h1 mb-2 text-gray-800">공지사항 관리 페이지</h1>
		<p class="mb-4">&nbsp;&nbsp;공지사항 CRUD</p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
				
					<h2>새글 쓰기</h2>
					
					<form action="admin.jsp?workgroup=admin&work=notice_add_action_admin" method="post" id="boardForm">
						<input type="hidden" name="pageNum" value="<%=pageNum%>">
						<table>
							<tr>
								<th>제목</th>
								<td>
									<input type="text" name="subject" id="subject" size="40">
								</td>	
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<textarea rows="7" cols="60" name="content" id="board_content"></textarea>
								</td>	
							</tr>
							<tr>
								<th colspan="2">
									<button type="submit">글저장</button>
									<button type="reset" id="resetBtn">다시쓰기</button>
								</th>
							</tr>
						</table>
					</form>
					<div id="message" style="color: red;"></div>
					
					
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#board_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#board_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");
});
</script>