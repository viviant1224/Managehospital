<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'fufei.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	 <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" media="screen">
	<script src="<%=basePath %>js/jquery.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script>
	function winClose() {

		//关闭之前先刷新父窗口，实现数据的更新
		window.opener.location.reload();
		var fangshi ="";
		//关闭窗口
		window.opener = null;
		var object = document.getElementsByName("zhifu");
		
		
		  for ( var  i = 0 ;i < object.length;i ++ ){
		  if(object[i].checked) {
		  fangshi=object[i].value;
		  }
	 	}
		window.returnValue=fangshi;
		window.open("", "_self");
		window.close();
	}
	
	</script>

  </head>
  
  <body>
  <div class="jumbotron">
  <form action="">
  <h2>缴费方式：</h2>
    <div class="radio">
  <label>
    <input type="radio" name="zhifu" id="wangshang" value="wangshang" >
    	网上支付
  </label>
</div>
<div class="radio">
  <label>
    <input type="radio" name="zhifu" id="zhanghu" value="zhanghu" checked>
   		从账户里面支付
  </label>
</div>
<a class="btn btn-primary" onclick="winClose()">确认支付</a>
</form>
</div>
  </body>
</html>
