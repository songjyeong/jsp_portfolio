<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%

	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	NoticeDTO notice = NoticeDAO.getDAO().selectNotice(num);

%>

<style type="text/css">
#board_detail {
	width: 500px;
	margin: 0 auto;
}

table {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 5px;
}

th {
	width: 100px;
	background-color: black;
	color: white; 
}

td {
	width: 400px;
}

.subject, .content {
	text-align: left;
}

.content {
	height: 100px;
	vertical-align: middle;
}

#board_menu {
	text-align: right;
	margin: 5px;
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
					<table>
						<tr>
							<th>작성일</th>
							<td>운영자</td>
						</tr>
						<tr>	
							<th>작성일</th>
							<td>
								<%=notice.getNdate() %>
							</td>
						</tr>
					
						<tr>	
							<th>제목</th>
							<td class="subject">
								<%=notice.getNtitle() %>
							</td>
						</tr>
						<tr>	
							<th>내용</th>
							<td class="content">
								<%=notice.getNcontent().replace("\n", "<br>") %>
							</td>
						</tr>
					</table>
					
					<div id="board_menu">
						<button type="button" id="modifyBtn">글변경</button>	
						<button type="button" id="removeBtn">글삭제</button>
						<button type="button" id="listBtn">글목록</button>	
					</div>
					
					<form method="post" id="menuForm">
						<input type="hidden" name="num" value="<%=notice.getNno()%>">
						
						<input type="hidden" name="pageNum" value="<%=pageNum%>">
						<input type="hidden" name="search" value="<%=search%>">
						<input type="hidden" name="keyword" value="<%=keyword%>">
					</form>
				
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

$("#modifyBtn").click(function() {
	$("#menuForm").attr("action","admin.jsp?workgroup=admin&work=notice_modify_admin");
	$("#menuForm").submit();
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {	
		$("#menuForm").attr("action","admin.jsp?workgroup=admin&work=notice_remove_action_admin");
		$("#menuForm").submit();
	}
});

$("#listBtn").click(function() {
	$("#menuForm").attr("action","admin.jsp?workgroup=admin&work=notice_manager");
	$("#menuForm").submit();
});
</script>
