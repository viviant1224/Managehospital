<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>红心医院后台管理系统</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="<%=basePath %>css/bootstrap.css">
<link rel="stylesheet" href="<%=basePath %>css/jquery.fancybox.css">
<link rel="stylesheet" href="<%=basePath %>css/error.css">

</head>
<body class='b_error'>
	<div class="error_page">
		<div class="desc">
			<h3>${message}</h3>
		</div>
		<div class="error">
		
		</div>
	</div>
<script src="js/jquery.js"></script>
<script src="js/jquery.fitText.js"></script>
<script src="js/error.js"></script>
</body>
</html>