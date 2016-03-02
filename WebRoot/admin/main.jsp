<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
UserinfoDoc userinfodoc = (UserinfoDoc)request.getSession().getAttribute("userinfoDoc");
List<Keshi> keshiList = (List<Keshi>)request.getSession().getAttribute("keshiList");

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
<style type="text/css">
	#div{
		height:200px;
		width:350px;
		margin:auto;}

</style>

<body>
<div class="style-toggler">
	<img src="<%=basePath %>img/icons/fugue/color.png" alt="" class='tip' title="Toggle style-switcher" data-placement="right">
</div>					
<div class="style-switcher">
	<h3>Pattern-switcher</h3>
	<ul class='pattern'>
		<li>
			<a href="javascript:void" class='default'>Default</a>
		</li>
		<li>
			<a href="javascript:void" class='dark'>Dark wood</a>
		</li>
		<li><a href="javascript:void" class='light'>Light</a></li>
		<li><a href="javascript:void" class='wood'>Wood</a></li>
		<li><a href="javascript:void" class='retina-wood'>Retina-wood</a></li>
		<li><a href="javascript:void" class='linen'>Linen</a></li>
		<li><a href="javascript:void" class='paper'>Paper</a></li>
	</ul>
</div>


<div class="topbar">
	<div class="container-fluid">
		<a href="javascript:void" class='company'>红心医院后台管理系统</a>
		<ul class='mini'>
			<%--  <li>
			 <img src="<%=path%>/upload/<%=userinfodoc.getDimageFileName() %>" height="40px" width="60px" />
			 </li> --%>
		<li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">当前用户：<%=userinfodoc.getDname() %><b class="caret"></b></a>
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
				<a href="javascript:void" class='light'>
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
	<div class="content" >
	
	
	
			<div class="row-fluid">
				<div class="span6">
					<div class="box">
						<div class="box-head">
							<h3>红心医院后台管理</h3>
						</div>
						<div class="box-content">
							<div class="alert alert-info">
								<strong>操作及使用指南</strong>
							</div>
							<font color="red">1.关于管理员： </font>
							管理员有权对角色、权限、用户进行调度、管理。<br>
							<font color="red">2.专家用户： </font>
							专家可以使用病人的预约号添加病人，专家的预约时间归管理员所管，如若想修改预约时间，可以联系管理员。<br>
							......
						</div>
					</div>
				</div>
				<div class="span6">
					<div class="box">
						<div class="box-head">
							<h3>医训</h3>
						</div>
						<div class="box-content">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<font size="+1">若有疾危求救者,不得以其<i>贵贱.贫富.长幼.妍媚</i>,怨亲善友,化夷愚智,普同一等,皆如至亲之想,亦不得瞻前顾后,自虑吉凶,护惜身命,勿避险夷,昼夜寒暑,饥渴疲劳,一心扑救....
							</font>


						</div>
					</div>
				</div>
			</div>
			
				
				<div class="span12">
					<div class="box">
						<div class="box-head">
							<h3>科室专家</h3>
						</div>
						<div class="box-content box-nomargin">
							<div class="accordion" id="accordion2">
							
							
							<%
								for(int  i = 0;i<keshiList.size();i++) {
								%>
								<div class="accordion-group">
					              <div class="accordion-heading">
					                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne<%=keshiList.get(i).getId() %>">
					                  <%=keshiList.get(i).getKname() %>
					                </a>
					              </div>
					              <div id="collapseOne<%=keshiList.get(i).getId() %>" class="accordion-body collapse in">
					                <div class="accordion-inner">
					                <%
					                	Set<UserinfoDoc> userset = keshiList.get(i).getUserinfodoc();
					                	for(UserinfoDoc user:userset) {
					                	%>
					                	
					                	<table> 
					                	<tr>
					                	
					                	<td  rowspan="3">
					                 <a href="<%=path%>/upload/<%=user.getDimageFileName()%>" class='preview fancy'>      <img src="<%=path%>/upload/<%=user.getDimageFileName()%>" width="200px" height="300px" alt="专家图片" /></a>
					                	</td>
					                	
					                	<td>
					                	</td>
					                	
					                	</tr>
					                	
					                	<tr>
					                	<td>
					                	</td>
					                	<td>
					                	<b> <h5>专家姓名：<%=user.getDname() %></h5></b>
					                	</td>
					                	</tr>
					                	
					                	<tr>
					                	<td>
					                	</td>
					                	<td>
					                	 <h6>电话：<font color="red"><%=user.getDtel() %></font></h6>
					                	</td>
					                	</tr>
          
           <span class="p-text">
               
               
            </span>
            
            
										</table>	
					                	<%
					                	}
					                
					                 %>
<!-- 					                  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
 -->					                </div>
					              </div>
					            </div>
								<%
								}
							 %>
							
					            
					          
					          
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