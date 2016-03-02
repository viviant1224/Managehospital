<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>预约人数统计</title>
<link href="/myshoppingsys/admin/style/main1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
#footer11 { padding-top:12px;
			 width:100%;
			  height:100px;
			   text-align:center;}
</style>
</head>
<body>
	<div id="right">
		<div id="tit">
			<span>当前操作：网上商城货物-- <strong>销量统计</strong></span>
		</div>
		<div class="leftbg"></div>
		<div class="rightbg"></div>
		<ul id="btn">
			<li><img src="/myshoppingsys/admin/img1/btn2.gif" alt="" /></li>
			<li><img src="/myshoppingsys/admin/img1/btn4.gif" alt="" /></li>
			<li><img src="/myshoppingsys/admin/img1/btn3.gif" alt="" /></li>
		</ul>
		<div class="main">
			<form action="/myshoppingsys/admin/sysjsp/occupation_statistics_show.jsp" method="post" target="show_detail">
			<table cellpadding="0" cellspacing="0" border="1" summary="职业规划师管理" class="table_list">
				<colgroup>
					<col width="10%" />
					<col width="34%" />
					<col width="10%" />
					<col width="14%" />
					<col width="10%" />
					<col width="16%" />
					<col width="6%" />
				</colgroup>
				<tbody>
					<tr>
						<th>图形:</th>
						<td>
							<select name="graph" class="set_18">
								<option value="Column3D" >柱状图</option>
								<option value="Pie3D" >饼图</option>
								<option value="Doughnut3D">环形图</option>
								<option value="Line" >折线图</option>
								<option value="Funnel" >漏斗图</option>
								<option value="Pyramid">金字塔</option>
								<option value="SSGrid">报表</option>
								<!-- 无破解 -->
								<option value="Spline">曲线图</option>
								<option value="SplineArea">曲线面积图</option>
							</select>
						</td>
						<td colspan="3" align="right">
							<input type="submit" value="查 询" class="btn_bg" />&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</tbody>
			</table>
			</form>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="border_Bg">
				<tr>
					<td height="470">
						<iframe width="100%" height="100%" scrolling="no" frameborder="0" name="show_detail" ></iframe>
					</td>
				</tr>
			</table>
			<div id="footer11"><font size="4px" color="black">制作人：黄威威   Copyright © 2013 company.All Rights Reserved. 版权号：W5.0.005<br />
						联系方式：tel 18686672327 qq :839562677</font>
</font>
</div>
		</div>
	</div>
</body>
</html>
