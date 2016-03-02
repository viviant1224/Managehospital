<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%@ page import="cn.com.shxt.beans.*" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
List<Roleinfo> rolelist = (List<Roleinfo>)request.getAttribute("rolelist");
Set<Powerinfo> powerset = (Set<Powerinfo>)request.getAttribute("powerset");
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
<script type="text/javascript" src="<%=basePath %>/admin/dtree/dtree-ck.source.js"></script>

<script type="text/javascript">
	 function delete_(id) {
			window.location.href="deleteRoleinfo.action?id="+id;
	 }

	
	function updateRname(id,rname) {
		var newname = document.getElementById(rname).value;
		if(newname.trim()==""||newname==null) {
		alert("输入不能为空！");
		return;
		}
	if (confirm("您确定要更改此角色名?")) {
				window.location.href = "/Managehospital/updateRnameRoleinfo.action?id="+id+"&newname="+newname;
			} else {
				return;
			}
	}
function update_R_P(id,R_power) {
		//创建js数组
		var R_powerids = new Array();
		var xiaoxiidArray = document.getElementsByName(R_power);

		var flag = true;

		for ( var i = 0; i < xiaoxiidArray.length; i++) {
			if (xiaoxiidArray[i].checked) {
				var xiaoxiid = xiaoxiidArray[i].value;
				//将选中的用户id放入数组
				R_powerids.push(xiaoxiid);
				flag = false;
			}
		}
		if (flag) {
			alert("请选择要修改的权限！");
		} else {
			if (confirm("您确定要应用所选权限?")) {

				window.location.href = "/Managehospital/updateR_PRoleinfo.action?rid="+id+"&R_powerids="
						+ R_powerids.join(",");
			} else {
				return;
			}
		}

	}
	
	//移除某个用户
	function removeuser(rid,uid) {
	if (confirm("您确定要移除该用户?")) {
				window.location.href = "/Managehospital/removeUserRoleinfo.action?uid="+uid+"&rid="+rid;
			} else {
				return;
			}
	}
	//分配用户
	function fenPeiUser(rid) {
		str = window.showModalDialog('showfenpeiUserRoleinfo.action?rid='+rid+'&'+ Math.random(), '', 'dialogWidth:800px;dialogHeight:700px');
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
										<h3>角色查看</h3>
										<ul class='nav nav-tabs'>
								<li class='active'>
									<a href="javascript:void" data-toggle="modal" data-target="#myModalAdd">添加角色</a>
								</li>
								
										</ul>
									</div>
									
									
								<div class="jumbotron">


<div id="div" class="table">
<table class="table table-responsive" width="680px" align="center">
  <tr class="success">
   <td width="50px"><b>编号</b></td>
   <td width="100px"><b>角色名</b></td>
  <td width="100px"><b>拥有权限</b></td>
  <td width="100px"><b>拥有用户</b></td>
  <td width="200px" colspan="2"><b>操作</b></td>
  </tr>
  <%
  if(rolelist.size()!=0&&rolelist!=null) {
  		for(int i = 0;i<rolelist.size();i++) {
  	%>
  	<tr class="success">
  <td width="50px"><b><%=rolelist.get(i).getId() %></b></td>
   <td width="100px"><b><%=rolelist.get(i).getRname()%></b></td>
  <td width="100px"><b>
    <button class="btn btn-primary" data-toggle="modal" data-target="#myModalPower<%=rolelist.get(i).getId() %>">
点击查看拥有权限
	</button>
  </b></td>
  <td width="100px"><b>
    <button class="btn btn-primary" data-toggle="modal" data-target="#myModalhaveUser<%=rolelist.get(i).getId() %>">
  点击查看拥有用户
	</button>
  </b></td>
  <td width="200px">
    
     <button class="btn btn-danger" data-toggle="modal" data-target="#myModal<%=rolelist.get(i).getId() %>">
  删除
	</button>
	
	 <button class="btn btn-success"  data-toggle="modal" data-target="#myModalUpdateRname<%=rolelist.get(i).getId() %>">
 修改角色名
	</button>
    
    </td>
  </tr>
  
    <!-- Modal 删除的模态窗口-->
<div class="modal fade" id="myModal<%=rolelist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">角色删除</h4>
      	</div>
      <div class="modal-body">
     确定删除名字为：<font color="red"><%=rolelist.get(i).getRname()%></font>编号为：<font color="red"><%=rolelist.get(i).getId() %></font>的角色？
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="delete_('<%=rolelist.get(i).getId()%>')">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


 <!-- Modal 修改角色名-->
<div class="modal fade" id="myModalUpdateRname<%=rolelist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">修改角色名</h4>
      	</div>
      <div class="modal-body">
     <label for="uname" class="control-label">角色名</label>
		<div class="controls">
			<input type="text" placeholder="rolename" value="<%=rolelist.get(i).getRname() %>"  id="updaterolename<%=rolelist.get(i).getId()%>"  class='required'>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="updateRname('<%=rolelist.get(i).getId() %>','updaterolename<%=rolelist.get(i).getId() %>')">修改角色名</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->	

 <!-- Modal 查看拥有用户窗口-->
<div class="modal fade" id="myModalhaveUser<%=rolelist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">所拥有的用户</h4><br>
      	</div>
      <div class="modal-body">
      	<h4>点击相应的按钮可进行操作</h4>
      <a href="javascript:void" onClick="fenPeiUser('<%=rolelist.get(i).getId()%>')" type="button" class="btn btn-info" >分配用户</a>
      <%
      Set<UserinfoDoc> setUser = rolelist.get(i).getUserinfodoc();
      if(setUser.size()!=0) {
      for(UserinfoDoc userinfo :setUser) {
		%>
		<div><h3>姓名：&nbsp;&nbsp;
		<%=userinfo.getDname()%>
		<!-- <button type="button" class="btn btn-primary" data-dismiss="modal">	点此查看完整信息</button> -->
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <button type="button" class="btn btn-danger" onClick="removeuser('<%=rolelist.get(i).getId() %>','<%=userinfo.getId()%>')">移除用户</button>
		 </h3>
		</div>
		<%
		}
      } else {
      %>
      暂无用户
      <%
      }
       %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->	
		
	  <!-- Modal 查看权限模态窗口-->
<div class="modal fade" id="myModalPower<%=rolelist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">所拥有的权限</h4>
         <h5 class="modal-title" id="myModalLabel"><font color="red">
      	   注：分配角色时，注意父子级别权限的相互关系。
         </font></h5>
      	</div>
      <div class="modal-body">
    <%
    	//原有的权限
    	Set<Powerinfo> powerinfo = rolelist.get(i).getPowerinfo();
    	
    	for(Powerinfo power:powerinfo) {
    %>
    <label>
      <input type="checkbox" checked="checked" value="<%=power.getId()%>" name="R_power<%=i%>"><%=power.getPname() %>
    </label>
    <%
    }
    Set<Powerinfo> haveset = new HashSet<Powerinfo>();
    haveset.addAll(powerset);
    //没有的权限
     haveset.removeAll(rolelist.get(i).getPowerinfo());
    for(Powerinfo power1:haveset) {
     %>
    <label>
      <input type="checkbox" value="<%=power1.getId()%>" name="R_power<%=i%>"><%=power1.getPname() %>
    </label>
  
    <%
    
    }
    %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="update_R_P('<%=rolelist.get(i).getId() %>','R_power<%=i%>')">修改权限</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->	
  	
  	<%
  	haveset.addAll(powerset);//重新添加进去
  	}
  
  } else {
  %>
  
  暂无数据
  <%
 
  }
   %>
</table>
</div>

</div>
			
									
				</div>
			</div>
		</div>
	</div>		
</div>	


<!-- Modal 添加角色-->
<div class="modal fade" id="myModalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      <form action="AddRolenameRoleinfo.action" method="post">
        <h4 class="modal-title" id="myModalLabel">添加角色</h4>
      	</div>
      <div class="modal-body">
      <div class="control-group">
							<label for="uname" class="control-label">角色名</label>
							<div class="controls">
								<input type="text" placeholder="rolename" name="addrolename"  class='required'>
							</div>
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