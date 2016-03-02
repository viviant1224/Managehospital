<%@ page language="java" import="java.util.*" import="cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.beans.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Patient patient = (Patient)request.getSession().getAttribute("patient");
PageBean pageBean = (PageBean)request.getAttribute("pageBean");
List<Orderinfo> orderlist = (List<Orderinfo>)pageBean.getList();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户预约详情</title>
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
    function quxiao(id) {
		window.location.href="quxiaoyuyuePatient.action?id="+id;
 	}
  	</script>
  	
  	</script>
  </head>
  
  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=basePath %>js/bootstrap.min.js"></script>
  
  <body>
  <nav class="nav  navbar-inverse" role="navigation">
    
	<div class="navbar-header">
    <ul class="nav navbar-nav navbar-right">
      <li><a href="javascript:void" onClick="Sign()" class="current" >当前页面：用户预约详情</a></li>
       <li><a href="javascript:void"><img src="<%=path%>/upload/<%=patient.getPimageFileName() %>" height="30px" width="30px" /></a></li>
     <li><a href="javascript:void">当前用户：    <%=patient.getPname()%>
      </a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>
<div class="jumbotron">
					<div class="container" align="center">
						<form action="changePatient.action" method="post" onsubmit="return validForm()" id="saveUserinfoForm"  enctype="multipart/form-data">
						预约历史记录：
		<table class="table table-responsive" width="900px" align="center">
				<tr>
				<td><b>序号</b></td>
				<td><b>挂号</b></td>
				<td><b>主治医生</b></td>
				<td><b>预约时间</b></td>
				<td><b>所属科室</b></td>
				<td><b>预约状态</b></td>
				<td><b>操作</b></td>
				</tr>
				<%
					if(orderlist.size()!=0&&orderlist!=null) {
					for(int i = 0;i<orderlist.size();i++) {
					%>
						<tr>
				<input type="hidden" value="<%=orderlist.get(i).getId() %>">
				<td><%=i+1%></td>
				<td><%=orderlist.get(i).getId()%></td>
				<td><%=orderlist.get(i).getDname() %></td>
				<td><%=orderlist.get(i).getOrderdate()%></td>
				<td><%=orderlist.get(i).getKname()%></td>
				<td><%=orderlist.get(i).getOrderstate()%></td>
				<td>
				<%
					if(orderlist.get(i).getOrderstate().equals("预约中")) {
					%>
					<button class="btn btn-primary" data-toggle="modal" data-target="#myModal<%=orderlist.get(i).getId() %>">
 					取消预约
					</button>
					<%
					} else if(orderlist.get(i).getOrderstate().equals("预约取消")){
					%>
					该预约已取消
					<%
					} else {
					%>
					详情
					<%
					}
				 %>
				</td>
				</tr>
					 <!-- Modal 取消预约窗口-->
<div class="modal fade" id="myModal<%=orderlist.get(i).getId() %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">取消预约</h4>
      	</div>
      <div class="modal-body">
     确定取消预约日期为：<%=orderlist.get(i).getOrderdate()%> 主看专家为：<%=orderlist.get(i).getDname() %>的预约？
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="quxiao('<%=orderlist.get(i).getId()%>')">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
					<%
					}
					
					} else {
					%>
					<h3>暂无预约详情</h3>
					
					<%
					}
				 %>
		</table>
		<ul class="pagination" align="right">
<li><s:a href="yuyueInfoPatient.action?pageBean.firstPage=0&pageBean.pageButton=0">首页 </s:a></li>
  	
	<s:if test="%{#request.pageBean.pageNum!=1}">
	<li><a href="yuyueInfoPatient.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=1">上一页  </a></li>
	</s:if>
	
	
	<s:if test="%{#request.pageBean.maxPageNum!=#request.pageBean.pageNum}">
	<li><a href="yuyueInfoPatient.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=2">下一页  </a></li>
	</s:if>
	
	
<li><a href="yuyueInfoPatient.action?pageBean.firstPage=<s:property value="pageBean.firstPage"/>&pageBean.pageButton=3">尾 页</a></li>

 共<font color="red">
 <s:property value="pageBean.maxNum"/></font>
 条记录,共
 <font color="red"><s:property value="pageBean.maxPageNum"/></font>
 页,当前为第<font color="red"><s:property value="pageBean.pageNum"/></font>页
</ul>
</form>
 					</div>
 				</div>
  </body>
</html>
