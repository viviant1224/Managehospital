<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%@ page import="cn.com.shxt.beans.*" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
PageBean pageBean = (PageBean)request.getAttribute("pageBean");
List<Orderinfo> orderlist = null;
if(pageBean!=null) {
orderlist = (List<Orderinfo>)pageBean.getList();
} else {
orderlist = (List<Orderinfo>)request.getAttribute("orderlist");
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
<script src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
 function deleteyuyue(id) {
		window.location.href="deleteyuyueUserinfoDoc.action?id="+id;
 }
 
function checkUpTime(UpyuyueTime) {
	var UpyuyueTime_=document.getElementById(UpyuyueTime).value;
		if(UpyuyueTime_.trim()=="") {
		alert("请输入预约日期");
		return false;
		} else {
		return true;
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
										<h3>查看所有预约</h3>
										<ul class='nav nav-tabs'>
										<li class='active'>
											<form action="searyuyueSearch.action" class="navbar-form navbar-left" role="search">
									        <input type="text" name="searchyuyue" class="form-control" placeholder="Search">
									      <button type="submit" class="btn btn-default">Submit</button>
									    </form>
										</li>
										</ul>
									</div>
								<div class="jumbotron">


<div id="div" class="table">
<table class="table table-responsive" width="680px" align="center">
  <tr class="success">
   <td width="80px"><b>预约号</b></td>
  <td width="100px"><b>病人姓名</b></td>
  <td width="100px"><b>医保卡号</b></td>
  <td width="100px"><b>专家编号</b></td>
  <td width="100px"><b>专家姓名</b></td>
  <td width="100px"><b>预约时间</b></td>
  <td width="100px"><b>就诊时间</b></td>
  <td width="100px"><b>预约状态</b></td>
  <td width="100px"><b>科室</b></td>
  <td width="100px" colspan="2"><b>操作</b></td>
  </tr>
  <%
  if(orderlist.size()!=0&&orderlist!=null) {
  		for(int i = 0;i<orderlist.size();i++) {
  	%>
  	<tr class="success">
  <td width="80px"><b><%=orderlist.get(i).getId() %></b></td>
  <td width="100px"><b><%=orderlist.get(i).getPname() %></b></td>
  <td width="100px"><b><%=orderlist.get(i).getPid()%></b></td>
  <td width="100px"><b><%=orderlist.get(i).getDid() %></b></td>
  <td width="100px"><b><%=orderlist.get(i).getDname()%></b></td>
  <td width="100px"><b><%=orderlist.get(i).getOrderdate()%></b></td>
  <%
  	if(orderlist.get(i).getOrderstate().equals("预约过期")||orderlist.get(i).getOrderstate().equals("预约取消")) {
  	%>
  	<td width="200px"><b>------</b></td>
  	<%
  	} else if(orderlist.get(i).getOrderstate().equals("预约中")){
  	%>
  <td width="100px"><b>待定</b></td>
  	<%
  	} else if(orderlist.get(i).getOrderstate().equals("预约完成")) {
  	%>
  	<td width="100px"><b><%=orderlist.get(i).getJiuzhenTime()%></b></td>
  	<%
  	}
   %>
  <td width="100px"><b><%=orderlist.get(i).getOrderstate() %></b></td>
  <td width="100px"><b><%=orderlist.get(i).getKname()%></b></td>
  <td width="100px">
  <%
  	if(orderlist.get(i).getOrderstate().equals("预约过期")||orderlist.get(i).getOrderstate().equals("预约取消")) {
  	%>
  	 <button class="btn btn-danger" data-toggle="modal" data-target="#myModalde<%=orderlist.get(i).getId() %>">
  删除记录
	</button>
  	<%
  	} else if(orderlist.get(i).getOrderstate().equals("预约中")){
  	%>
 <button class="btn btn-primary" data-toggle="modal" data-target="#myModal<%=orderlist.get(i).getId() %>" >
  预约延迟
	</button>
  	<%
  	} else if(orderlist.get(i).getOrderstate().equals("预约完成")) {
  		%>
 <button class="btn btn-success" data-toggle="modal" data-target="#myModalwangcehng<%=orderlist.get(i).getId() %>" disabled>
预约完成
	</button>
  	<%
  	
  	}
   %>
    </td>
  </tr>
  
   <!-- Modal 修改预约时间的模态窗口-->
<div class="modal fade" id="myModal<%=orderlist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">预约时间修改</h4>
      	</div>
      <div class="modal-body">
      <form action="upYuyueTimeUserinfoDoc.action?yuyuenum=<%=orderlist.get(i).getId()%>" onSubmit="return checkUpTime('UpyuyueTime<%=orderlist.get(i).getId()%>')" method="post">
      <input class="Wdate"value="<%=orderlist.get(i).getOrderdate() %>" id="UpyuyueTime<%=orderlist.get(i).getId()%>" type="text" onblur="checkUpTime('UpyuyueTime<%=orderlist.get(i).getId()%>')" name="UpyuyueTime" onfocus="WdatePicker({skin:'whyGreen',minDate:'<%=orderlist.get(i).getOrderdate()%>'})"/> 
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" >确定修改</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
  
  
    <!-- Modal 删除的模态窗口-->
<div class="modal fade" id="myModalde<%=orderlist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">预约删除</h4>
      	</div>
      <div class="modal-body">
     确定删除日期为：<font color="red"><%=orderlist.get(i).getOrderdate()%></font>编号为：<font color="red"><%=orderlist.get(i).getId() %></font>的预约记录？
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="deleteyuyue('<%=orderlist.get(i).getId()%>')">确定</button>
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
<li><s:a href="showAllyuyueUserinfoDoc.action?pageBean.firstPage=0&pageBean.pageButton=0">首页 </s:a></li>
	<s:if test="%{#request.pageBean.pageNum!=1}">
	<li><a href="showAllyuyueUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=1">上一页  </a></li>
	</s:if>
	<s:if test="%{#request.pageBean.maxPageNum!=#request.pageBean.pageNum}">
	<li><a href="showAllyuyueUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=2">下一页  </a></li>
	</s:if>
<li><a href="showAllyuyueUserinfoDoc.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=3">尾 页</a></li>

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