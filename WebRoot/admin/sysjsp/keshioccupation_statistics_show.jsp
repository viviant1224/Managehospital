<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.LinkedList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.math.BigDecimal"%>

<%@ page import="cn.com.shxt.utils.*,java.net.URLEncoder"%>

<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

ChartTools gt = new ChartTools();
List rsList = gt.keshiload();

//获取图形类别
String graph = "Column3D";

System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~ jsp graph is : " + graph);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预约人数统计</title>
<!-- <link href="/myshoppingsys/admin/style/main1.css" rel="stylesheet" type="text/css" /> -->
</head>
<body>
			<table align="center">
				<colgroup>
					<col />
				</colgroup>
				<tbody>
					
					<tr>
						<th>
						<%
						StringBuffer strBuf = new StringBuffer();
						strBuf.append("<chart caption='' showNames='1' decimalPrecision='0'>");
						for (int i = 0; i < rsList.size(); i++) {
							Object[] obj  =  (Object[])rsList.get(i);
							String key = (String)obj[0];   //科室
							BigDecimal value = (BigDecimal)obj[1]; //数量
							System.out.println(key+"----------"+value);
							strBuf.append("<set label='" + key + "' value='" + value + "' />");
							System.out.println(key+"----"+value);
						}
						strBuf.append("</chart>");
						String graphType = "../Includes/swf/" + graph + ".swf";
						String str_xml="";
						//中文乱码的解决 
						str_xml=URLEncoder.encode(strBuf.toString(),"UTF-8");
						%> 
						<jsp:include page="../Includes/jsp/FusionChartsHTMLRenderer.jsp" flush="true"  >
					    	<jsp:param name="chartSWF" value="<%=graphType %>"/>
							<jsp:param name="strURL" value="" /> 
							<jsp:param name="strXML" value="<%=str_xml %>" /> 
							<jsp:param name="chartId" value="accounts_code" /> 
							<jsp:param name="chartWidth" value="820" /> 
							<jsp:param name="chartHeight" value="287" /> 
							<jsp:param name="debugMode" value="false" /> 	 
						</jsp:include>
					</th>
				</tr>
				<tr>
						<th align="center">按日期统计预约人数</th>
					</tr>
			</tbody>
			</table>
</body>
</html>