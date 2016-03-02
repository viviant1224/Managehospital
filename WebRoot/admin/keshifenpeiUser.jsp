<%@ page language="java" import="java.util.*" import="cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserinfoDoc userinfodoc = (UserinfoDoc)request.getSession().getAttribute("userinfoDoc");
Set<UserinfoDoc> haveUser = (Set<UserinfoDoc>)request.getAttribute("haveUser");
System.out.println(haveUser.size());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>分配用户</title>
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
   <script type="text/javascript">
  	//表单验证
  	
  	</script>
  </head>
  
  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=basePath %>js/bootstrap.min.js"></script>
  
  <body>
   <nav class="nav  navbar-inverse" role="navigation">
    
	<div class="navbar-header">
		
    <ul class="nav navbar-nav navbar-right">
      <li><a href="javascript:void"><img src="<%=path%>/upload/<%=userinfodoc.getDimageFileName() %>" height="30px" width="30px" /></a></li>
      <li><a href="javascript:void">当前用户：<%=userinfodoc.getDname() %></a></li>
      <li><a href="javascript:void">当前页面：查看科室拥有的用户</a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>


<div class="jumbotron">
					<div class="container" align="center">
						<%
						if(haveUser!=null&&haveUser.size()!=0){
						for(UserinfoDoc user:haveUser) {
						%>
						 <div class="col-xs-4">
								   <div class="row">
								  <div class="col-lg-6">
								    <div class="input-group">
								      <span class="input-group-addon">
								      </span>
								      <input type="text" value="<%=user.getDname()%>"class="form-control" disabled>
								    </div>
								  </div>
			  						</div>
						</div>
						<%
						} 
						} else {
						%>
						暂未分配人员
						<%
						}
						%>
					
  
 					</div>
</div>
  </body>
</html>
