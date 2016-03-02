<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
UserinfoDoc userinfodoc = (UserinfoDoc)request.getSession().getAttribute("userinfoDoc");
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>红心医院后台管理系统</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="<%=basePath %>css/bootstrap.css">
<link rel="stylesheet" href="<%=basePath %>css/bootstrap-responsive.css">
<link rel="stylesheet" href="<%=basePath %>css/jquery.fancybox.css">
<link rel="stylesheet" href="<%=basePath %>css/style.css">
</head>
<body>
<div class="style-toggler">
	<img src="<%=basePath %>img/icons/fugue/color.png" alt="" class='tip' title="Toggle style-switcher" data-placement="right">
</div>					
<div class="style-switcher">
	<h3>Pattern-switcher</h3>
	<ul class='pattern'>
		<li>
			<a href="javascript:void" class='default'>Default</a>
		</li>
		<li>
			<a href="javascript:void" class='dark'>Dark wood</a>
		</li>
		<li><a href="javascript:void" class='light'>Light</a></li>
		<li><a href="javascript:void" class='wood'>Wood</a></li>
		<li><a href="javascript:void" class='retina-wood'>Retina-wood</a></li>
		<li><a href="javascript:void" class='linen'>Linen</a></li>
		<li><a href="javascript:void" class='paper'>Paper</a></li>
	</ul>
</div>


<div class="topbar">
	<div class="container-fluid">
		<a href="javascript:void" class='company'>红心医院后台管理系统</a>
		<ul class='mini'>
			<%--  <li>
			 <img src="<%=path%>/upload/<%=userinfodoc.getDimageFileName() %>" height="40px" width="60px" />
			 </li> --%>
		<li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">当前用户：<%=userinfodoc.getDname() %><b class="caret"></b></a>
        <ul class="dropdown-menu">
          <li><a href="gerenzhonxin.jsp"><img alt="" src='<%=basePath %>img/icons/essen/16/business-contact.png'>个人中心</a></li>
          <li><a href="tuichuUserinfoDoc.action"><img alt="" src='<%=basePath %>img/icons/essen/16/sign-out.png'>安全退出</a></li>
        </ul>
      </li>
		</ul>
	</div>
</div>


<div class="main">
	<div class="container-fluid">
	<div class="navi">
		<ul class='main-nav'>
			<li class='active'>
				<a href="<%=basePath %>admin/main.jsp" class='light'>
					<div class="ico"><i class="icon-home icon-white"></i></div>
					主页
				</a>
			</li>
			
			<%
			for(int i = 0;i<listall.size();i++){	
			
				if(listall.get(i).getPid()==4) {
				%>
				
			<li>
				<a href="#" class='light toggle-collapsed'>
					<div class="ico"></div>
					<%=listall.get(i).getPname()%>
					<img src="img/toggle-subnav-down.png" alt="">
				</a>
				<ul class='collapsed-nav closed'>
				<%
					
				for(int j = 0;j<listall.size();j++) {
					if(listall.get(j).getPid()==listall.get(i).getMid()) {
					%>
					
					<li>
						<a href="<%=listall.get(j).getPurl()%>">
							<%=listall.get(j).getPname() %>
						</a>
					</li>
					
				
					<%
					}
				
				}
				 %>
				</ul>
			</li>
				<%
				}
			%>
			
			
			
			<%
			}
			
			 %>
			
			
			
           
	</div>
	<div class="content">
			<div class="row-fluid">
				<div class="span12">
					<div class="box">
						<div class="box-head">
							<h3>统计模块</h3>
						</div>
						<div class="box-content">
							<ul class="quicktasks">
								<li>
									<a href="<%=basePath %>/admin/sysjsp/occupation_statistics_show.jsp" method="post" target="show_detail">
										<img src="<%=basePath %>img/icons/essen/32/shipping.png" alt="">
										<span>
										按专家统计预约人数
										</span>
									</a>
								</li>
								
								<li>
									<a href="<%=basePath %>/admin/sysjsp/dateoccupation_statistics_show.jsp" method="post" target="show_detail">
										<img src="<%=basePath %>img/icons/essen/32/shipping.png" alt="">
										<span>
										按日期统计预约人数
										</span>
									</a>
								</li>
								
								<li>
									<a href="<%=basePath %>/admin/sysjsp/keshioccupation_statistics_show.jsp" method="post" target="show_detail">
										<img src="<%=basePath %>img/icons/essen/32/shipping.png" alt="">
										<span>
										按科室统计预约人数
										</span>
									</a>
								</li>
								
							</ul>
							</div>
					</div>
					</div>
			</div>
			
	
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="border_Bg">
				<tr>
					<td height="470">
						<iframe width="100%" height="100%" scrolling="no" frameborder="0" name="show_detail" ></iframe>
					</td>
				</tr>
			</table>
	</div>
			
	</div>


<script src="<%=basePath %>js/jquery.js"></script>
<script src="<%=basePath %>js/less.js"></script>
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/jquery.peity.js"></script>
<script src="<%=basePath %>js/jquery.fancybox.js"></script>
<script src="<%=basePath %>js/jquery.flot.js"></script>
<script src="<%=basePath %>js/jquery.color.js"></script>
<script src="<%=basePath %>js/jquery.flot.resize.js"></script>
<script src="<%=basePath %>js/jquery.cookie.js"></script>
<script src="<%=basePath %>js/jquery.cookie.js"></script>
<script src="<%=basePath %>js/custom.js"></script><script src="<%=basePath %>js/demo.js"></script>
</body>
</html>