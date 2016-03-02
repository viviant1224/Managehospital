<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Neat Admin Template</title>
<meta name="description" content="">

<meta name="viewport" content="width=device-width">

<link rel="stylesheet" href="<%=basePath %>/css/bootstrap.css">
<link rel="stylesheet" href="<%=basePath %>/css/jquery.fancybox.css">
<link rel="stylesheet" href="<%=basePath %>/css/error.css">
</head>
<body class='b_error'>
	<div class="error_page">
		<div class="desc">
			对不起，您还没有注册，
		</div>
		<div class="error">
			403
		</div>
	</div>
<script src="<%=basePath %>/js/jquery.js"></script>
<script src="<%=basePath %>/js/jquery.fitText.js"></script>
<script src="<%=basePath %>/js/error.js"></script>
</body>
</html>