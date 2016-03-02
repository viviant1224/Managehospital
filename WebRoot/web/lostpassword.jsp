<%@ page language="java" import="java.util.*" import="cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>找回密码</title>
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" media="screen">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="<%=basePath %>js/jquery.js"></script>
	<script src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
	<script src="<%=basePath%>/js/form_valid.js" charset="utf-8"></script>
<script src="<%=basePath %>js/imagePreview.js"></script>
   <script type="text/javascript">
 		function checkcardnum() {
 		var cardnum = document.getElementById("cardnum").value;
 		if(cardnum.trim()=="") {
 		alert("请输入您的医保卡号");
 		return false;
 		}
 		if(isNaN(cardnum)) {
 		alert("请输入正确的医保卡号");
 		return false;
 		} else {
 		return true;
 		}
 		}
  	</script>
  </head>
  
  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=basePath %>js/bootstrap.min.js"></script>
  
  <body>
  <nav class="nav  navbar-inverse" role="navigation">
    
	<div class="navbar-header">
		
    <ul class="nav navbar-nav navbar-right">
      <li><a href="javascript:void" onClick="Sign()" class="current" >当前页面：找回密码</a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>
  
<div class="jumbotron">
	<div class="container" align="center">
		<form action="findpasswordPatient.action" method="post" onsubmit="return checkcardnum()">
		<table>
			<tr>
			<td width="300px">
			医保卡号：<input type="text" id="cardnum" onBlur="checkcardnum()" name="patient.id" class="form-control" placeholder="cardnum">
			</td>
			</tr>
			<tr>
			<td>
			<div class="control-group">
							密保问题：<select class="form-control" name="patient.pquestion">
							  <option>你的小学名字是什么？</option>
							  <option>你父亲的生日是多少？</option>
							  <option>你母亲的生日是多少？</option>
							</select>
			</div>
			</td>
			</tr>
			<tr>
			<td>
			答案：<input type="text" name="patient.panswer" class="form-control" placeholder="answer">
			</td>
			</tr>
			<tr>
			<td align="right">
			<input type="submit" class="btn btn-primary" value="提交" />
			</td>
			</tr>
		</table>
		
		</form>
	</div>
</div>
  </body>
</html>
