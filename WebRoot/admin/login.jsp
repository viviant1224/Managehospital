<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>登录界面</title>
<meta name="description" content="">

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<link rel="stylesheet" href="<%= basePath%>css/bootstrap.css">
<link rel="stylesheet" href="<%= basePath%>css/jquery.fancybox.css">
<link rel="stylesheet" href="<%= basePath%>css/login.css">
</head>
<script src="<%= basePath%>js/jquery.js"></script>
<script src="<%= basePath%>js/jquery.validate.min.js"></script>
<script src="<%= basePath%>js/jquery.metadata.js"></script>
<script src="<%= basePath%>js/error.js"></script>
<body class='login_body'>
	<div class="wrap">
		<h2>红心医院后台管理系统</h2>
		<h4>登录界面</h4>
		<form action="../loginAction.action"  autocomplete="off" method="post" class="validate">
		<div class="login">
			<div class="email">
				<label for="user">用户编号</label><div class="email-input"><div class="control-group"><div class="input-prepend"><span class="add-on"><i class="icon-envelope"></i></span><input type="text" id="usercode" name="loginusername" class="{required:true}"></div></div></div>
			</div>
			<div class="pw">
				<label for="pw">密码</label><div class="pw-input"><div class="control-group"><div class="input-prepend"><span class="add-on"><i class="icon-lock"></i></span><input type="password" id="password" name="loginpassword" class='{required:true}'></div></div></div>
			</div>
			
		</div>
		<div class="submit">
			<button class="btn btn-red5">登录</button>
		</div>
		<div class="login social">
			<div class="btn-row">
				<a href="#" class="btn btn-social btn-twitter"><img src="<%= basePath%>img/twitter.png" alt="">Sign in with Twitter</a>
				<a href="#" class="btn btn-social btn-fb"><img src="<%= basePath%>img/facebook.png" alt="">Sign in with Facebook</a>
			</div>
			<div class="btn-row">
				<a href="#" class="btn btn-social btn-dr"><img src="<%= basePath%>img/dribble.png" alt="">Sign in with Dribble</a>
				<a href="#" class="btn btn-social btn-fo"><img src="<%= basePath%>img/forrst.png" alt="">Sign in with Forrst</a>
			</div>
		</div>
		</form>
		<div class="social-shadow-hider"></div>
		<div class="social-toggle">
		</div>
	</div>

</body>
</html>