<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%@ page import="cn.com.shxt.beans.*" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<UserinfoDoc> userdoclist = new ArrayList<UserinfoDoc>();
List<Keshi> keshilist = (List<Keshi>)request.getAttribute("Keshi");
List<YuyueTime> yuyuelist = (List<YuyueTime>)request.getAttribute("yuyuelist");
Patient patient  = (Patient)request.getSession().getAttribute("patient");
userdoclist = (List<UserinfoDoc>)request.getAttribute("userinfotiaojianT_U");
%>


<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en" class="no-js" ><!--<![endif]-->
    <head>
        <!-- BEGIN: basic page needs -->
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <meta name="viewport" content="width=100%; initial-scale=1; maximum-scale=1; minimum-scale=1; user-scalable=no;" />
        <title>红心医院</title>
        <!-- END: basic page needs -->
        
        <!-- BEGIN: css -->
        <link href="<%=basePath %>qiantai/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="<%=basePath %>qiantai/css/bootstrap-responsive.css" rel="stylesheet" type="text/css" />
        <link href="<%=basePath %>qiantai/css/style.css" rel="stylesheet" type="text/css" />
        <link href="<%=basePath %>qiantai/css/responsive.css" rel="stylesheet" type="text/css" />
        <link href="<%=basePath %>qiantai/css/skin-default.css" rel="stylesheet" type="text/css" />
        <link href="<%=basePath %>qiantai/css/prettyPhoto.css" rel="stylesheet" type="text/css" />
        <!-- END: css -->
        <!-- BEGIN: js -->
    	<script type="text/javascript" src="<%=basePath %>qiantai/js/jquery.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/google-code-prettify/prettify.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/modernizr.js"></script> 
        <script type="text/javascript" src="<%=basePath %>qiantai/js/respond.js"></script> 
        <script type="text/javascript" src="<%=basePath %>qiantai/js/superfish.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/hoverIntent.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/jquery.easing.1.3.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/jquery.prettyPhoto.js"></script> 
        <script type="text/javascript" src="<%=basePath %>qiantai/js/jquery.hoverdir.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/jquery.flexslider.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/jquery.elastislide.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/jquery.tweet.js"></script>
        <script type="text/javascript" src="<%=basePath %>qiantai/js/bootstrap.js"></script> 
        <script type="text/javascript" src="<%=basePath %>qiantai/js/main.js"></script>
        <!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
        <!-- END: js -->
    </head>
    <script type="text/javascript">
    function Sign() {
		str = window.showModalDialog('<%=basePath%>initProvincePatient.action', '', 'dialogWidth:800px;dialogHeight:700px');
		if (str == 'OK') {
				winReload();
		}
	}
    </script>
<body>
<!-- .container -->
<section class="container">
    <!-- #header .row -->
    <header id="header">
        <div class="row">

            <!-- .span3.logo -->
            <div class="span3">
                <a href="javascript:void" ><img src="<%=path %>/qiantai/images/logo.jpg" alt="Logo" /></a>
            </div><!-- /.span3.logo -->
            
            <!-- .span9 -->
            <nav class="span9">

                <!-- #menu -->
                <ul id="menu">
                    <li><h3><a type="button" data-toggle="modal" data-target="#myModalliucheng">预约流程</a></h3></li>
                   
                    </li>
 <li class="dropdown">
       <h3> <a href="javascript:void" class="dropdown-toggle" data-toggle="dropdown">按科室查找<b class="caret"></b></a></h3>
        <ul class="dropdown-menu">
        <%
        	for(int i=0;i<keshilist.size();i++) {
        	%>
        	<li><a href="getDocbyKeshiPatient.action?kname=<%=keshilist.get(i).getKname()%>#zhengwen"><%=keshilist.get(i).getKname()%></a></li>
        	<%
        	}
         %>
          
        </ul>
        
        
      </li>
<li class="dropdown">
       <h3> <a href="javascript:void" class="dropdown-toggle" data-toggle="dropdown">按预约时间查找<b class="caret"></b></a></h3>
        <ul class="dropdown-menu">
        <%
        	for(int i=0;i<yuyuelist.size();i++) {
        	%>
        	<li><a href="getDocbyWeekPatient.action?week=<%=yuyuelist.get(i).getWeek()%>#zhengwen"><%=yuyuelist.get(i).getWeek()%></a></li>
        	<%
        	}
         %>
          
        </ul>
      </li>

                    <li>
					<form class="navbar-form navbar-left" action="searchT_UPatient.action" method="post" role="search">
					<%
						if(patient!=null) {
						%>
						 <input type="hidden" value="<%=patient.getId()%>">
						<%
						}
					 %>
					 
					  <div class="form-group">
					    <input type="text" class="form-control" name="tiaojianT_U" placeholder="请输入专家大致的电话号码或姓名">
					  </div>
					<button type="submit" class="btn btn-default">  <h4>查找</h4></button>
					</form>
                    </li>
                    <%
                    if(patient!=null) {
                    String pid = ""+patient.getId();
                    %>
					<li class="dropdown">
					       <h3> <a href="javascript:void" class="dropdown-toggle" data-toggle="dropdown"><img src="<%=basePath %>upload/<%=patient.getPimageFileName() %>" width="40px" height="40px"><font color="red"><%=patient.getPname() %></font></a>，您好！</h3>
					        <ul class="dropdown-menu">
					        	<li><a href="patientInfoPatient.action?pid=<%=patient.getId()%>"><font color="black"><b>个人中心</b></font></a></li>
					        	<li><a href="yuyueInfoPatient.action?pid=<%=pid%>"><font color="black"><b>个人预约详情</b></font></a></li>
					        	<li><a href="LoginoutPatient.action"><font color="black"><b>退出</b></font></a></li>
					        </ul>
					      </li>
                    <%
                    } else {
                    %>
                     <li><h3><a href="javascript:void" onClick="Sign()" class="current" >注册</a></h3></li>
                     <li><h3> <a href="javascript:void" data-toggle="modal" data-target="#myModalAdd">登录</a></h3></li>
                    <%
                    }
                     %>
            </nav><!-- .span9-->
        
        </div>
    </header><!-- /#header .row -->
	
    <div class="copyrights">Collect from <a href="http://www.cssmoban.com/"  title="网页模板">网页模板</a></div>

    <!-- #welcome -->
    <section id="welcome">

        <!-- .span5 -->
        <div class="span5">
            <h1>欢迎进入<br><span class="color">红心医院</span><br>网上预约系统</h1>
        </div><!-- /.span5 -->

        <!-- .span6 -->
        <div class="span6">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;红心医院一直遵循“大医厚德、精博至善”之院训，
            禀承“团结、严谨、进取、奉献”之风，坚持“病人的生命、健康、安全高于一切”之服务理念，悬壶济世，治病救人，
            以“艺精德高”而蜚声杏林、驰誉全国以及海外，2004年在我国最大规模读者投票评选活动中，我院被评为“中国市民最信赖的内地医疗机构”。
            </p>
        </div><!-- /.span6 -->

    </section><!-- /#welcome -->


    <!-- #home_slider -->


    <section id="home_slider">
    <h3 class="title">红心医院风采欣赏</h3>

        <!-- .slides -->
        <ul class="slides">
            <li>
                <img src="<%=path%>/upload/yiyuan2.jpg" height="570px" width="1200px" alt="Slider" />
            </li>
            
              <li>
                <img src="<%=path%>/upload/yiyuan3.jpg" height="570px" width="1200px" alt="Slider" />

              
            </li>
            
              <li>
                <img src="<%=path%>/upload/yiyuan4.jpg" height="570px" width="1200px" alt="Slider" />

              
            </li>
            
              <li>
                <img src="<%=path%>/upload/yiyuan5.jpg" height="570px" width="1200px" alt="Slider" />

              
            </li>
            
             <li>
                <img src="<%=path%>/upload/yiyuan1.jpg" height="570px" width="1200px" alt="Slider" />

            </li>

            <li>
                <video src="<%=path%>/upload/kobe.mp4" height="570px" width="1200px" controls="controls">

            </li>

           
        </ul><!-- /.slides -->

    </section><!-- /#home_slider -->
    <!-- BEGIN: .portfolio .da-thumbs .clearfix -->
    <section class="portfolio da-thumbs clearfix">

    
        <%
        if(userdoclist!=null&&userdoclist.size()!=0) {
        %>
      <a name="zhengwen"><h3 class="title">专家查看<small>Search the Dcotor</small></h3></a>
        <%
         for(int i = 0;i<userdoclist.size();i++) {
       Keshi keshi = userdoclist.get(i).getKeshi();
        %>
        <article>
            <img src="<%=path%>/upload/<%=userdoclist.get(i).getDimageFileName()%>" width="300px" height="200px" alt="Images" />
           <span class="p-text">
               <b> <h1>专家姓名：<%=userdoclist.get(i).getDname() %></h1></b>
                <h2>所属科室：<font color="red"><%=keshi.getKname() %></font></h2>
            </span>
            <div>
                <a href="<%=path%>/upload/<%=userdoclist.get(i).getDimageFileName()%>" data-rel="prettyPhoto" class="portfolio-view" title="Lorem ipsum dolor"></a>
                <a href="showDocInfoPatient.action?did=<%=userdoclist.get(i).getId() %>" class="portfolio-link"></a>    
            </div>
        </article>
        <%
        }
         } else {
         %>
         <h3 class="title">医院简介<small>introduce the hospital</small></h3>
            <!-- .row -->
            <div class="row">

                <!-- .span3 -->
                <div class="span3">

                                	<font size="+1" color="red">医训：</font><font size="+1">若有疾危求救者,不得以其<i>贵贱.贫富.长幼.妍媚</i>,怨亲善友,化夷愚智,普同一等,皆如至亲之想,亦不得瞻前顾后,自虑吉凶,护惜身命,勿避险夷,昼夜寒暑,饥渴疲劳,一心扑救....

                </div><!-- /.span3 -->





                <!-- .span6 -->
                <div class="span6">
                    
&nbsp;&nbsp;&nbsp;&nbsp;红心 医院建成于1921年，由洛克菲勒基金会创办。建院之初，就志在“建成亚洲最好的医学中心”。90年来，医院形成了“严谨、求精、勤奋、奉献”的协和精神和兼容并蓄的特色文化风格，创立了“三基”、“三严”的现代医学教育理念，形成了以“教授、病案、图书馆”著称的协和“三宝”，培养造就了张孝骞、林巧稚等一代医学大师和多位中国现代医学的领军人物，并向全国输送了大批的医学管理人才，创建了当今知名的10余家大型综合及专科医院。2011年在总结90年发展经验的基础上，创新性提出了“待病人如亲人，提高病人满意度；待同事如家人，提高员工幸福感”新办院理念。
                    <!-- .row.features -->
                    <div class="row features">

                        <div class="span2">
                            <div class="box">
                                <img src="<%=path%>/upload/jiangzhuang1.jpg" alt="Features">
                                <p>2009年，获得先进集体荣誉</p>
                            </div>
                        </div>
                        
                        <div class="span2">
                            <div class="box">
                                <h4>院所获荣誉</h4>
                                <img src="<%=path%>/upload/jiangzhuang2.jpg" alt="Features">
                                <p>全院人员共同获得表彰</p>
                            </div>
                        </div>
                        
                        <div class="span2">
                            <div class="box">
                                <h4>科室快速入口</h4>
                                	<%
                                	for(int i = 0;i<keshilist.size();i++) {
                                	%>
                                	<p><%=keshilist.get(i).getKname() %></p>
                                	<%
                                	}
                                	
                                	 %>
                            </div>
                        </div>
                        
                    </div><!-- /.row.features -->

                </div><!-- /.span6 -->

            </div><!-- /.row -->

        </div><!-- /.span9 -->
         <%
         }
         %>
    </section>
    <!-- #footer.container -->
    <footer id="footer" class="container">
    <p align="center">红心医院 (c)2005-2010 版权所有 [闽ICP备05085434]地址：XXXX市XXXX街1246号</p><br>
    <p align="center">联系方式：137.....4657</p>
    </footer><!-- /#footer .container -->
</section><!-- /.container -->
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
								<input type="text" placeholder="cardnum" name="patient.id"  class='required'>
							</div>
							
							<label for="uname" class="control-label">密码</label>
							<div class="controls">
								<input type="password" placeholder="password" name="patient.password"  class='required'>
							</div>
	</div>
      </div>
      <div class="modal-footer">
      <a href="lostpassword.jsp" target="_blank"><font size="+1">忘记密码？</font></a>
        <button type="submit" class="btn btn-primary" ><font size="+1">登录</font></button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><font size="+1"> 取消</font></button>
      </div>
      </form>
     
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


</body>
</html>