<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%@ page import="cn.com.shxt.beans.*" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Set<Powerinfo> havepower = (Set<Powerinfo>)request.getAttribute("havepower");
List<Powerinfo> listquanbu = (List<Powerinfo>)request.getAttribute("listquanbu");
System.out.println(havepower.size());

System.out.println(listquanbu.size());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test___.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>/admin/dtree/dtree-ck.source.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <script type="text/javascript">
	var d = new dTree('d');
	d.config.check=true;
		d.addCbx(0, -1, '权限分配',"javascript:;",true,  '提示');
		<%
			for(Powerinfo powerinfo : listquanbu){		
		%>	
		
d.addCbx(<%=powerinfo.getPid() %>, '<%=powerinfo.getPname()%>', '<%=powerinfo.getPurl() %>','<%=powerinfo.getPname() %>','Mainframe');			
	<%
				System.out.println(powerinfo.getPid()+powerinfo.getPname()+powerinfo.getMid()+powerinfo.getPurl());
		%>
		<%		
			}
		%>
		<%
			for(Powerinfo powerinfo : havepower){		
		%>	
d.addCbx(<%=powerinfo.getMid() %>, <%=powerinfo.getPid() %>, '<%=powerinfo.getPname()%>', '<%=powerinfo.getPurl() %>', true,'<%=powerinfo.getPname() %>','Mainframe');			
	<%
				System.out.println(powerinfo.getPid()+powerinfo.getPname()+powerinfo.getMid()+powerinfo.getPurl());
		%>
		<%		
			}
		%>
	document.write(d);
</script>
  <input type="button" value="获取选中节点id" onclick="alert(d.getSelectedNodes()['value'].join())" />
    
  </body>
</html>
