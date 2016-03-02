<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%@ page import="cn.com.shxt.beans.*" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
PageBean pageBean = (PageBean)request.getAttribute("pageBean");
List<Powerinfo> powerlist = null;
if(pageBean!=null) {
powerlist = (List<Powerinfo>)pageBean.getList();
} else {
powerlist = (List<Powerinfo>)request.getAttribute("powerlist");
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
<script type="text/javascript" src="<%=basePath %>js/dtree-ck.compress.js"></script>
<link rel="stylesheet" href="<%=basePath %>css/jquery.fancybox.css">
<link rel="stylesheet" href="<%=basePath %>css/style.css">
<script type="text/javascript">

 
 function delete_(id) {
		window.location.href="deletePowerinfo.action?id="+id;
 }

	function updatePname(id,pname,purl_) {
		var newname = document.getElementById(pname).value;
		var purl =  document.getElementById(purl_).value;
		if(newname.trim()==""||newname==null) {
		alert("输入不能为空！");
		return;
		}
	if (confirm("您确定要更改此权限?")) {
				
				window.location.href = "/Managehospital/updatePnamePowerinfo.action?id="+id+"&purl="+purl+"&newname="+newname;
			} else {
				return;
			}
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
										<h3>权限管理</h3>
										
										<ul class='nav nav-tabs'>
										
										<li class='active'>
										<form action="searPowerSearch.action" class="navbar-form navbar-left" role="search">
								        <input type="text" name="searchPower" class="form-control" placeholder="Search">
								      <button type="submit" class="btn btn-default">Submit</button>
								    </form>
									</li>
								<li class='active'>
								
									<a href="javascript:void" data-toggle="modal" data-target="#myModalAddPower"><img alt="" src='<%=basePath %>img/icons/essen/16/plus.png'>添加权限</a>
								</li>
								
										</ul>
									</div>
									
									
								<div class="jumbotron">


<div id="div" class="table">
<table class="table table-responsive" width="680px" align="center">
  <tr class="success">
   <td width="80px"><h3>编号</h3></td>
   <td width="150px"><h3>权限名</h3></td>
  <td width="200px" colspan="2"><h3>操作</h3></td>
  </tr>
  <%
  if(powerlist.size()!=0&&powerlist!=null) {
  		for(int i = 0;i<powerlist.size();i++) {
  	%>
  	<tr class="success">
  <td width="80px"><b><%=powerlist.get(i).getId() %></b></td>
   <td width="100px"><b><%=powerlist.get(i).getPname() %></b></td>
  <td width="200px">
    
     <button class="btn btn-danger" data-toggle="modal" data-target="#myModal<%=powerlist.get(i).getId() %>">
  删除
	</button>
	
	 <button class="btn btn-success"  data-toggle="modal" data-target="#myModalUpdatePname<%=powerlist.get(i).getId() %>">
 修改权限
	</button>
    
    </td>
  </tr>
  
  <!-- Modal 修改权限名-->
<div class="modal fade" id="myModalUpdatePname<%=powerlist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">修改权限</h4>
      	</div>
      <div class="modal-body">
     	<label for="uname" class="control-label">权限名</label>
		<div class="controls">
			<input type="text" placeholder="powername" value="<%=powerlist.get(i).getPname() %>"  id="updatepowername<%=powerlist.get(i).getId()%>"  class='required'>
		</div>
		
		 <label for="uname" class="control-label">权限路径</label>
		<div class="controls">
			<input type="text" placeholder="purl" value="<%=powerlist.get(i).getPurl() %>"  id="updatepurl<%=powerlist.get(i).getId()%>"  class='required'>
		</div>
      </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="updatePname('<%=powerlist.get(i).getId() %>','updatepowername<%=powerlist.get(i).getId() %>','updatepurl<%=powerlist.get(i).getId()%>')">修改权限</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->	
  
    <!-- Modal 删除的模态窗口-->
<div class="modal fade" id="myModal<%=powerlist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">专家删除</h4>
      	</div>
      <div class="modal-body">
     确定删除姓名为：<font color="red"><%=powerlist.get(i).getPname() %></font>编号为：<font color="red"><%=powerlist.get(i).getId() %></font>的权限？
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="delete_('<%=powerlist.get(i).getId()%>')">确定</button>
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
<li><s:a href="showPowerPowerinfo.action?pageBean.firstPage=0&pageBean.pageButton=0">首页 </s:a></li>
  	
	<s:if test="%{#request.pageBean.pageNum!=1}">
	<li><a href="showPowerPowerinfo.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=1">上一页  </a></li>
	</s:if>
	
	
	<s:if test="%{#request.pageBean.maxPageNum!=#request.pageBean.pageNum}">
	<li><a href="showPowerPowerinfo.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=2">下一页  </a></li>
	</s:if>
	
	
<li><a href="showPowerPowerinfo.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=3">尾 页</a></li>

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
	</div>		
</div>	
<!-- Modal 添加权限-->
<div class="modal fade" id="myModalAddPower" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      <form action="AddpowerPowerinfo.action" method="post">
        <h4 class="modal-title" id="myModalLabel">添加权限</h4>
      	</div>
      <div class="modal-body">
      <div class="control-group">
			<label for="uname" class="control-label">权限名</label>
			<div class="controls">
				<input type="text" placeholder="rolename" name="addpname"  class='required'>
			</div>
	</div>
	
	<div class="control-group">
			<label for="uname" class="control-label">权限路径</label>
			<div class="controls">
				<input type="text" placeholder="purl" name="addpurl"  class='required'>
			</div>
	</div>
	
	<div class="control-group">
			<label for="uname" class="control-label">父级权限</label>
			<label class="radio"><input type="radio" checked="checked" name="addpid" value="4" class='{required:true}'>菜单管理 &nbsp;&nbsp;&nbsp;&nbsp;<font color="red">一级菜单</font></label>
			
			<%
				for(int i = 0;i<listall.size();i++) {
					if(listall.get(i).getPid()==4) {
					%>
					<div class="controls">
					<label class="radio"><input type="radio" name="addpid" value="<%=listall.get(i).getMid() %>" class='{required:true}'><%=listall.get(i).getPname()%>&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">二级菜单</font></label>
					</div>
					<%
					}				
				}
			 %>
	</div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" >确认添加</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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