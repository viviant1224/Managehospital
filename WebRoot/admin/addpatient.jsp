<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%@ page import="cn.com.shxt.beans.*" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
UserinfoDoc userinfodoc = (UserinfoDoc)request.getSession().getAttribute("userinfoDoc");
List<YuyueTime> yuyueTimelist = (List<YuyueTime>)request.getAttribute("yuyueTimelist");
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
<script type="text/javascript">
function  checkYuyuenum() {
		var yuyunum = document.getElementById("yuyunum").value;
		if(yuyunum.trim()=="") {
		document.getElementById("checkyuyuenum").innerHTML="<font color = 'red'>"+"预约号不能为空"+"</font>";
			a = false;
		}else if(isNaN(yuyunum)){
			document.getElementById("checkyuyuenum").innerHTML="<font color = 'red'>"+"预约号输入有错"+"</font>";
			a = false;
			}else {
				ajaxYuyuenum();
			}
		}
function createHttpRequest() {
			var xmlHttpRequest; 
			if(window.XMLHttpRequest) {
			xmlHttpRequest= new XMLHttpRequest();
			
			} else if(window.ActiveXObject) {
			xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
			}
			return xmlHttpRequest;
		}
	var xmlHttpReq = null;
	//验证是否输入预约号合法性
	function ajaxYuyuenum(){
		var yuyunum = document.getElementById("yuyunum").value;
		xmlHttpReq = createHttpRequest();
		xmlHttpReq.onreadystatechange=rollbackYuyuenum;
		xmlHttpReq.open("post","addPaforYuyuenumZhuanjia.action",true);
		xmlHttpReq.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    	 xmlHttpReq.send("yuyunum="+yuyunum+"&"+new Date().getMilliseconds());
	}
	
	function rollbackYuyuenum() {
		if(xmlHttpReq.readyState==4) {
			if(xmlHttpReq.status==200) {
			info= xmlHttpReq.responseText;
			if(info==1) {
			document.getElementById("checkyuyuenum").innerHTML="<font color = 'red'>"+"该预约号不存在"+"</font>";
			a = false;
			} else if(info == 2) {
			document.getElementById("checkyuyuenum").innerHTML="<font color = 'red'>"+"该预约号已经失效"+"</font>";
			a =  false;
			}  else if(info == 3) {
			document.getElementById("checkyuyuenum").innerHTML="<font color = 'red'>"+"该预约号已经生效"+"</font>";
			a = false;
			} else if(info == 4) {
			document.getElementById("checkyuyuenum").innerHTML="<font color = 'red'>"+"该预约号不属于您所管"+"</font>";
			a = false;
			}else if(info == 5){
			document.getElementById("checkyuyuenum").innerHTML="<font color = 'green'>"+"该预约号可用"+"</font>";
			a = true;
			}
			}
		}
	}
	function checksub() {
	return a; 
	}
 </script>
</head>
<body>
<div class="style-toggler">
	<img src="<%=basePath %>img/icons/fugue/color.png" alt="" class='tip' title="Toggle style-switcher" data-placement="right">
</div>					
<div class="style-switcher">
	<h3>Pattern-switcher</h3>
	<ul class='pattern'>
		<li>
			<a href="#" class='default'>Default</a>
		</li>
		<li>
			<a href="#" class='dark'>Dark wood</a>
		</li>
		<li><a href="#" class='light'>Light</a></li>
		<li><a href="#" class='wood'>Wood</a></li>
		<li><a href="#" class='retina-wood'>Retina-wood</a></li>
		<li><a href="#" class='linen'>Linen</a></li>
		<li><a href="#" class='paper'>Paper</a></li>
	</ul>
</div>
<div class="topbar">
	<div class="container-fluid">
		<a href="<%=basePath %>admin/main.jsp" class='company'>红心医院后台管理系统</a>
		<form action="#">
			<input type="text" value="Search here...">
		</form>
		<ul class='mini'>
			<%-- <li>
			 <img src="<%=path%>/upload/<%=userinfodoc.getDimageFileName() %>" height="30px" width="60px" />
			</li> --%>
			<li class="dropdown">
        <a href="javascript:void" class="dropdown-toggle" data-toggle="dropdown">当前用户：<%=userinfodoc.getDname() %><b class="caret"></b></a>
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
									<div class="box-head tabs">
										<h3>添加病人</h3>
									</div>
									
									
<div class="jumbotron">
<form action="addPaZhuanjia.action" method="post" onsubmit="return checksub()">
	请输入用户的预约号：<input type="text" id="yuyunum" name="yuyunum" onblur="checkYuyuenum()" /> 
					<label id="checkyuyuenum"></label>
	<button class="btn btn-primary" type="submit">
  	确定添加
	</button>
</form>
</div>
				</div>
			</div>
		</div>
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