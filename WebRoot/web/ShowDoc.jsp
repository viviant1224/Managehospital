<%@ page language="java" import="java.util.*" import="cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="cn.com.shxt.dao.Dao" %>
<%@ page import="cn.com.shxt.dao.bean.DaoBean" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserinfoDoc userinfo = (UserinfoDoc)request.getAttribute("userinfo");
Keshi keshi_ = userinfo.getKeshi();
String kname_ = keshi_.getKname();
int did = userinfo.getId();
String dname = userinfo.getDname();
Patient patient = (Patient)request.getSession().getAttribute("patient");
String pname = "";
int pid = -1;
if(patient==null) {
pname="";
pid=0;
} else {
pname = patient.getPname();
pid = patient.getId();
}
Date date = new Date();
Date date2 = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Dao dao = new DaoBean();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>查看专家信息</title>
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
   <script type="text/javascript">
  	 function Sign() {
		str = window.showModalDialog('<%=basePath%>initProvincePatient.action', '', 'dialogWidth:800px;dialogHeight:700px');
		if (str == 'OK') {
				winReload();
		}
	}
	 function aa(date) {
	 var yuyuepid = document.getElementById("yuyuepid").value;
	  if(yuyuepid==0) {
			 alert("请先登录后再进行预约");
			 return;
			 }
	 if (confirm("您确定预约?")) {
	 		
		 	str = window.showModalDialog('<%=basePath%>web/fufei.jsp', '', 'dialogWidth:400px;dialogHeight:300px');
			if (str == 'zhanghu') {
			window.location.href = "/Managehospital/yuyuePatient.action?zhifu=zhanghu&kname=<%=kname_%>&orderdate="+date+"&did=<%=did%>&pid=<%=pid%>&pname=<%=pname%>&dname=<%=dname%>";
			} else if(str == 'wangshang'){
			window.location.href = "/Managehospital/yuyuePatient.action?zhifu=wangshang&kname=<%=kname_%>&orderdate="+date+"&did=<%=did%>&pid=<%=pid%>&pname=<%=pname%>&dname=<%=dname%>";
			}
			
			} else {
				return;
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
      <%
      if(patient==null) {
      %>
       <li><a href="javascript:void">当前页面：    专家详情查看和预约
       <li><a href="javascript:void">您还未登录，不能预约。</a></li>
           <li><a href="javascript:void" onClick="Sign()" class="current" >注册</a></li>
             <li><a href="javascript:void" data-toggle="modal" data-target="#myModalAdd">登录</a></li>
      <%
      } else{
     %>
          <li><a href="javascript:void">当前页面：    专家详情查看和预约
       <li><a href="javascript:void"><img src="<%=path%>/upload/<%=patient.getPimageFileName() %>" height="30px" width="30px" /></a></li>
     <li><a href="javascript:void">当前用户：    <%=patient.getPname()%>
  
     <%
      }
       %>
      </a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>
<div class="jumbotron">
					<div class="container" align="center">
						<form action="changeUsinfoDoc.action" method="post" onsubmit="return validForm()" id="saveUserinfoForm"  enctype="multipart/form-data">
						<table>
						<input type="hidden" value="<%=pid %>" id = "yuyuepid">
				<tr>
				<td width="500px">
					<div class="control-group">
							<label for="uname" class="control-label" onclick="aa()">姓名</label>
							<div class="controls">
							&nbsp;&nbsp;&nbsp;&nbsp;${userinfo.dname}
							<input type="hidden" value="${userinfo.id}">
							</div>
					</div>
				</td>
				<td width="500px">
					<div class="control-group">
							<label for="uname" class="control-label">出生日期</label>
							<div class="controls">
							&nbsp;&nbsp;&nbsp;&nbsp;${userinfo.dbirthday}
							</div>
					</div>
				</td>
				</tr>
				<tr>
					<td rowspan="2">
					<div class="control-group">
						<label for="check2" class="control-label">预约时间</label>
						<div class="controls">
							
						<%
							Set<YuyueTime> week = userinfo.getWeek();
							for(YuyueTime yuyue:week) {
							%>
							&nbsp;&nbsp;&nbsp;&nbsp;<%=yuyue.getWeek()%>&nbsp;&nbsp;&nbsp;&nbsp;
							<%
							}
						 %>
						</div>
					</div>
					<div class="control-group">
								<label for="pw3" class="control-label">预约操作</label>
								<div class="controls">
								时间：
<table border="1" cellpadding="0" >
								<tr height="100px">
								<%
									int nowweek = date.getDay();
									System.out.println(nowweek);
									if(nowweek==0) {
									%>
									<td width="100px">星期日
								<br><%=sdf.format(date) %>
								<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==0) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期一
								<br><%
								date.setDate(date.getDate());
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==1) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期二
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==2) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期三
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==3) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期四
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==4) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期五
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==5) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期六
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==6) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
									<% 
									} else if(nowweek==1){
									%>
									<td width="100px">星期一
								<%
								date.setDate(date.getDate());
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==1) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期二
								<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==2) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期三
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==3) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期四
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==4) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期五
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==5) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期六
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==6) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期日
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==0) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
									<%
									} else if(nowweek==2) {
									%>
									<td width="100px">星期二
								<%
								date.setDate(date.getDate());
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==2) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期三
								<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==3) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期四
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==4) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期五
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==5) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期六
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==6) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期日
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==0) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期一
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==1) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
									
									<%
									} else if(nowweek==3){
									%>
									<td width="100px">星期三
								<%
								date.setDate(date.getDate());
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==3) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期四
								<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==4) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期五
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==5) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期六
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==6) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期日
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==0) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期一
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==1) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期二
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==2) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
									<%
									} else if(nowweek==4) {
									%>
									<td width="100px">星期四
								<%
								date.setDate(date.getDate());
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==4) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期五
								<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==5) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期六
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==6) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期日
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==0) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期一
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==1) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期二
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==2) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期三
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==3) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
									<%
									} else if(nowweek==5){
									%>
									<td width="100px">星期五
								<%
								date.setDate(date.getDate());
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==5) {
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()>1) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期六
								<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==6) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期日
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==0) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期一
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==1) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期二
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==2) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期三
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==3) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期四
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==4) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
									<%
									} else if(nowweek==6){
									%>
									<td width="100px">星期六
								<%
								date.setDate(date.getDate());
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==6) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期日
								<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==0) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期一
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==1) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期二
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==2) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期三
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==3) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期四
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==4) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
								<td width="100px">星期五
									<br><%
								date.setDate(date.getDate()+1);
								 %><%= sdf.format(date) %>
								 		<br>
						<%
							for(YuyueTime yuyue:week) {
							if(yuyue.getWeekid()==5) {
							
							List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo where orderstate='预约中' and orderdate='"+sdf.format(date)+"' and did='"+did+"'");
								if(orderlist.size()==2) {
								%>
							<a type="button"  class="btn btn-Warning">约满</a>
								<%
								} else {
								%>
								<a type="button" onclick="aa('<%=sdf.format(date) %>')" class="btn btn-primary">预约</a>
								<%
								}
							}
							}
						 %>
								</td>
									<%
									}
								 %>
								
								
								
								</table>
								
								</div>
						</div>
					</td>
					<td>
					<div class="control-group">
								<label for="uname" class="control-label">电话</label>
								<div class="controls">
								&nbsp;&nbsp;&nbsp;&nbsp;${userinfo.dtel}
								</div>
						</div>
					</td>
				</tr>
				<tr>
					
					<td>
					<div class="control-group">
								<label for="sela" class="control-label">科室</label>
								<div class="controls">
								<%
									Keshi keshi = userinfo.getKeshi();
								 %>
								&nbsp;&nbsp;&nbsp;&nbsp;<%=keshi.getKname() %>
								</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
								<label for="pw4" class="control-label">专家详情</label>
<textarea class="form-control" rows="10" cols="12" name="userinfo1.info" disabled>&nbsp;&nbsp;&nbsp;&nbsp;${userinfo.info}</textarea>
								</div>
					</td>
					<td>
					
				  		 <div id="imagePreview" >
				  		 <div id="preview">
					     <img id="imghead" src="<%=basePath%>upload/${userinfo.dimageFileName}" width="200px" height="200px" border=0 />
						 </div>
				  		 </div>
					</td>
				</tr>

<tr>
	<td>
	
	</td>
	<td>
	<button class="btn btn-success" data-toggle="modal" data-target="#myModalliucheng">预约流程</button>
	</td>
	</tr>
</table>
</form>
 					</div>
				</div>
				
				<!-- Modal 登录用户-->
<div class="modal fade" id="myModalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      <form action="LoginPatient.action" method="post">
        <h4 class="modal-title" id="myModalLabel">用户登录</h4>
      	</div>
      <div class="modal-body">
      <div class="control-group">
							<label for="uname" class="control-label">医保卡号</label>
							<div class="controls">
								<input type="text" placeholder="cardnum" class="form-control" name="patient.id"  class='required'>
							</div>
							
							<label for="uname" class="control-label">密码</label>
							<div class="controls">
								<input type="password" placeholder="password" class="form-control" name="patient.password"  class='required'>
							</div>
	</div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" >登录</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
      </form>
     
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
			
			
			<!-- Modal 预约流程说明-->
<div class="modal fade" id="myModalliucheng" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      <form action="LoginPatient.action" method="post">
        <h4 class="modal-title" id="myModalLabel">红心医院网上预约流程</h4>
      	</div>
      <div class="modal-body">
    <div class="jumbotron">
    &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;<font color="red">欢迎来到红心医院预约网站，以下为预约流程的操作及注意事项：</font>
    <br>
     <br><font color="blue">1.关于预约：</font>您必须注册登录后才能预约。
     <br><font color="blue">2.预约时间：</font>最早可提前一周预约。
    <br><font color="blue">3.预约专家：</font>每人最多限预约一名专家，每个专家在当天预约时间内最多所预约的人数为2人。
     <br><font color="blue">4.预约操作：</font>通过点击专家，查看详细专家，并且可以预约。预约时需要缴费。
     成功后，将给你一个预约成功的挂号。凭借该挂号，可以去红心医院在当天时间就诊。如果没有准时赴约，将取消您的预约，如有改约等特殊情况
     请致电：135xxxx-xxxx。
     <br><font color="blue">5.缴费方式：</font>1.网银支付  2.账号支付。
    </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal"><font size="+1"> 已经阅读</font></button>
      </div>
      </form>
     
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->	
  </body>
</html>
