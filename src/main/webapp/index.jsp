<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	String workgroup=request.getParameter("workgroup");
	if(workgroup==null) workgroup="main";
	
	String work=request.getParameter("work");
	if(work==null) work="main_content";
	
	String contentPath=workgroup+"/"+work+".jsp";
	

 	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>YUMYUMYUM</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">

<style type="text/css">

* {
	margin:0px auto;
	padding: 0px;
	font-family: Montserrat,'NanumBarunGothic', sans-serif;

}

a {
	text-decoration-line : none;
	color : black; 
}

.header {
	max-width:2000px;
}

.mainContent {
	max-width:2000px;
	padding-bottom: 800px;
	
}

.footer_scroll {

	max-width:1500px;
	width:100%;
	
	height: 200px;
	position : relative;

	padding:40px;
}

.footDiv {
	max-width:2000px;

  background: #F5F6CE;
  color: #DF7401;
  font-family: sans-serif;
  height:400px;
 	position : relative;
	transform : translateY(-100%);

}

footer ul {
  list-style: none;
  display: block;
  float: left;
  
}
footer h3 {
  font-weight: 100;
  margin-bottom: 0;
}
.pink{color: pink;}
.red{color: red;}
.orange{color: orange;}
.green{color: green;
}

.companyImg {
	margin-left:auto;
	margin-right:auto;
}

</style>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>


<body>
	<div id="header"  class="header">
		<jsp:include page="header.jsp"/>
	</div>
	
	<div id="mainContent" class="mainContent">
		<jsp:include page="<%=contentPath %>"/>		
	</div>
	<div class="footDiv">
	<footer class="footer_scroll" id="footer_script">
		<jsp:include page="footer.jsp"/>
	</footer>
	</div>
	
	<script type="text/javascript">
// 	if($('#content').height() > 700) {
// 		$('#footer_script').attr('class','footer_scroll');
// 	} else {
// 		$('#footer_script').attr('class','footer_not_scroll');
// 	}
	</script>
</body>
</html>