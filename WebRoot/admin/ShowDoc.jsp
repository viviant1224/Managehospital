<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%@ page import="cn.com.shxt.beans.*" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
PageBean pageBean = (PageBean)request.getAttribute("pageBean");
List<UserinfoDoc> userlist = null;
if(pageBean!=null) {
userlist = (List<UserinfoDoc>)pageBean.getList();
} else {
userlist = (List<UserinfoDoc>)request.getAttribute("userlist");
}
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
<script type="text/javascript">

 
 function delete_(id) {
		window.location.href="deleteUserinfoDoc.action?id="+id;
 }

	
	function updateUser(uid) {
		
		str = window.showModalDialog('updateUserinfoDoc.action?id='+uid+'&'+ Math.random(), '', 'dialogWidth:800px;dialogHeight:700px');
		if (str == 'OK') {
				winReload();
		}
		
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
		<a href="<%=basePath %>main.jsp" class='company'>红心医院后台管理系统</a>
		
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
				<a href="<%=basePath%>admin/main.jsp" class='light'>
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
							<h3>查看所有专家</h3>
							<ul class='nav nav-tabs'>
				<li class='active'>
					<form action="searUserSearch.action" class="navbar-form navbar-left" role="search">
			        <input type="text" name="searchUser" class="form-control" placeholder="Search">
			      <button type="submit" class="btn btn-default"><img alt="" src='<%=basePath %>img/icons/essen/16/zoom.png'>Submit</button>
			    </form>
				</li>
				</ul>
						</div>
						<div class="box-content box-nomargin">
							<div class="alert alert-info alert-block">
								<a class="close" data-dismiss="alert" href="#">×</a>
  								<h4 class="alert-heading">点击操作</h4>
  								预约时间可以点击查看，通过修改可以更改专家的预约时间。
							</div>
							<table class='table table-striped table-media table-bordered'>
								<thead>
									<tr>
										<th><b>编号</b></th>
										<th><b>头像</b></th>
										<th><b>姓名</b></th>
										<th><b>密码</b></th>
										<th><b>电话</b></th>
										<th><b>生日</b></th>
										<th><b>所属科室</b></th>
										<th><b>预约时间</b></th>
										<th><b>角色</b></th>
										<th colspan="2"><b>操作</b></th>
									</tr>
								</thead>
								<tbody>
								 <%
  									if(userlist.size()!=0&&userlist!=null) {
  										for(int i = 0;i<userlist.size();i++) {
								  	%>	
								  	<tr>
										<td><%=userlist.get(i).getId() %></td>
										<td class='table-image'>
											<a href="<%=path%>/upload/<%=userlist.get(i).getDimageFileName()%>" class='preview fancy'><img src="<%=path%>/upload/<%=userlist.get(i).getDimageFileName()%>" height="80px" width="80px" alt="" title="专家头像"></a>
										</td>
										<td><%=userlist.get(i).getDname() %></td>
										<td><%=userlist.get(i).getPassword()%></td>
										<td><%=userlist.get(i).getDtel()%></td>
										<td><%=userlist.get(i).getDbirthday() %></td>
										
															<%
					  	Keshi keshi = userlist.get(i).getKeshi();
					  	if(keshi==null) {
					  	%>
					  	 <td>暂无</td>
					  	<%
					  	} else {
					  	%>
					  	 <td><%=keshi.getKname() %></td>
					  	<%
					  	}
					  
					   %>
					  
					  
					 
					  <td>
					  	  <div class="btn-group">
					  	    <%
					  Set<YuyueTime> week = userlist.get(i).getWeek();
					  if(week.size()==0) {
					  %>
					   <button type="button" class="btn btn-default"><font color="#FF0000">暂无分配</font></button>
					   <%
					  } else {
					  %>
					    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">点击查看</button>
					  <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
					  <%
					  	for(YuyueTime time:week) {
					  	%>
					  <li><%=time.getWeek()%></li>
					  	<%
					  	}
					   %>
					  <%
					  }
					   %>
					 
					  </div>
					  </td>
					  <%
					  Set<Roleinfo> roleSet = userlist.get(i).getRoleinfo();
					  if(roleSet.size()==0||roleSet==null) {
					  %>
					  <td>暂未分配角色</td>
					  <%
					  } else{
					  %>
					  <td>
					  <% 
					  for(Roleinfo role:roleSet) {
					  %>
					  <%=role.getRname() %>
					  <%
					  }
					  %>
					  </td>
					  <%
					  }
					   %>
					  
					  <td>
					    
					     <button class="btn btn-primary" data-toggle="modal" data-target="#myModal<%=userlist.get(i).getId() %>">
					  删除
						</button>
						
						 <button class="btn btn-success" onclick="updateUser('<%=userlist.get(i).getId()%>')" >
					 修改
						</button>
					    
					    </td>
									</tr>
									
									 <!-- Modal 删除的模态窗口-->
<div class="modal fade" id="myModal<%=userlist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">专家删除</h4>
      	</div>
      <div class="modal-body">
     确定删除姓名为：<%=userlist.get(i).getDname() %>编号为：<%=userlist.get(i).getId() %>的专家？
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="delete_('<%=userlist.get(i).getId()%>')">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
									
								  		<%
								  		}
								  		} else {
								  		%>
								  		<h1>暂无数据</h1>
								  		<%
								  		}
								  	%>
								</tbody>
							</table>
							<%
if(pageBean!=null) {
%>
<ul class="pagination" align="right">
<li><s:a href="showallUserinfoDoc.action?pageBean.firstPage=0&pageBean.pageButton=0">首页 </s:a></li>
  	
	<s:if test="%{#request.pageBean.pageNum!=1}">
	<li><a href="showallUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=1">上一页  </a></li>
	</s:if>
	
	
	<s:if test="%{#request.pageBean.maxPageNum!=#request.pageBean.pageNum}">
	<li><a href="showallUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=2">下一页  </a></li>
	</s:if>
	
	
<li><a href="showallUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=3">尾 页</a></li>

 共<font color="red">
 <s:property value="pageBean.maxNum"/></font>
 条记录,共
 <font color="red"><s:property value="pageBean.maxPageNum"/></font>
 页,当前为第<font color="red"><s:property value="pageBean.pageNum"/></font>页
</ul>
<%
}
 %>
						</div>
					</div>
				</div>
			</div>
		</div>	
	
	
	
	<%-- <div class="content">
		<div class="row-fluid">
			<div class="span12">
				<div class="box">
					<div class="box-head tabs">
						<h3>查看所有专家</h3>
				<ul class='nav nav-tabs'>
				<li class='active'>
					<form action="searUserSearch.action" class="navbar-form navbar-left" role="search">
			        <input type="text" name="searchUser" class="form-control" placeholder="Search">
			      <button type="submit" class="btn btn-default">Submit</button>
			    </form>
				</li>
				</ul>
					</div>
								<div class="jumbotron">


<div id="div" class="table">
<table class="table table-responsive" width="680px" align="center">
  <tr class="success">
   <td width="80px"><b>编号</b></td>
   <td width="150px"><b>头像</b></td>
  <td width="100px"><b>姓名</b></td>
  <td width="100px"><b>密码</b></td>
  <td width="200px"><b>电话</b></td>
  <td width="100px"><b>生日</b></td>
  <td width="100px"><b>所属科室</b></td>
  <td width="100px"><b>预约时间</b></td>
  <td width="200px"><b>角色</b></td>
  <td width="200px" colspan="2"><b>操作</b></td>
  </tr>
  <%
  if(userlist.size()!=0&&userlist!=null) {
  		for(int i = 0;i<userlist.size();i++) {
  	%>
  	<tr class="success">
  <td width="80px"><b><%=userlist.get(i).getId() %></b></td>
   <td width="150px"><img src="<%=path%>/upload/<%=userlist.get(i).getDimageFileName()%>" height="80px" width="80px" /></td>
  <td width="100px"><b><%=userlist.get(i).getDname() %></b></td>
  <td width="100px"><b><%=userlist.get(i).getPassword()%></b></td>
  <td width="200px"><b><%=userlist.get(i).getDtel()%></b></td>
  <td width="100px"><b><%=userlist.get(i).getDbirthday() %></b></td>
  <%
  	Keshi keshi = userlist.get(i).getKeshi();
  	if(keshi==null) {
  	%>
  	 <td width="100px"><b>暂无</b></td>
  	<%
  	} else {
  	%>
  	 <td width="100px"><b><%=keshi.getKname() %></b></td>
  	<%
  	}
  
   %>
  
  
 
  <td width="100px">
  	  <div class="btn-group">
  	    <%
  Set<YuyueTime> week = userlist.get(i).getWeek();
  if(week.size()==0) {
  %>
   <button type="button" class="btn btn-default"><font color="#FF0000">暂无分配</font></button>
   <%
  } else {
  %>
    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">点击查看</button>
  <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" role="menu">
  <%
  	for(YuyueTime time:week) {
  	%>
  <li><%=time.getWeek()%></li>
  	<%
  	}
   %>
  <%
  }
   %>
 
  </div>
  </td>
  <%
  Set<Roleinfo> roleSet = userlist.get(i).getRoleinfo();
  if(roleSet.size()==0||roleSet==null) {
  %>
  <td width="200px"><b>暂未分配角色</b></td>
  <%
  } else{
  %>
  <td width="200px">
  <% 
  for(Roleinfo role:roleSet) {
  %>
   <b><%=role.getRname() %></b>
  <%
  }
  %>
  </td>
  <%
  }
   %>
  
  <td width="200px">
    
     <button class="btn btn-primary" data-toggle="modal" data-target="#myModal<%=userlist.get(i).getId() %>">
  删除
	</button>
	
	 <button class="btn btn-success" onclick="updateUser('<%=userlist.get(i).getId()%>')" >
 修改
	</button>
    
    </td>
  </tr>
  
    <!-- Modal 删除的模态窗口-->
<div class="modal fade" id="myModal<%=userlist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">专家删除</h4>
      	</div>
      <div class="modal-body">
     确定删除姓名为：<%=userlist.get(i).getDname() %>编号为：<%=userlist.get(i).getId() %>的专家？
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="delete_('<%=userlist.get(i).getId()%>')">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
		
		
  	
  	<%
  	}
  
  } else {
  %>
  
  暂无数据
  <%
  }
  
  	
   %>

</table>
<%
if(pageBean!=null) {
%>
<ul class="pagination" align="right">
<li><s:a href="showallUserinfoDoc.action?pageBean.firstPage=0&pageBean.pageButton=0">首页 </s:a></li>
  	
	<s:if test="%{#request.pageBean.pageNum!=1}">
	<li><a href="showallUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=1">上一页  </a></li>
	</s:if>
	
	
	<s:if test="%{#request.pageBean.maxPageNum!=#request.pageBean.pageNum}">
	<li><a href="showallUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=2">下一页  </a></li>
	</s:if>
	
	
<li><a href="showallUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=3">尾 页</a></li>

 共<font color="red">
 <s:property value="pageBean.maxNum"/></font>
 条记录,共
 <font color="red"><s:property value="pageBean.maxPageNum"/></font>
 页,当前为第<font color="red"><s:property value="pageBean.pageNum"/></font>页
</ul>
<%
}
 %>
</div>

</div>
				</div>
			</div>
		</div>
	</div>		 --%>
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