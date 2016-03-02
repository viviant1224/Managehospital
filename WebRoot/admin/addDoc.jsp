<%@ page language="java" import="java.util.List" pageEncoding="UTF-8"%>
<%@ page import="cn.com.shxt.model.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
List<Keshi> keshiList = (List<Keshi>)request.getSession().getAttribute("keshiList");
List<YuyueTime> weeklist = (List<YuyueTime>)request.getSession().getAttribute("weeklist");
UserinfoDoc userinfodoc = (UserinfoDoc)request.getSession().getAttribute("userinfoDoc");
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>红心医院后台管理系统</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">
<script src="<%=basePath%>/js/form_valid.js" charset="utf-8"></script>
<script src="<%=basePath %>js/imagePreview.js"></script>
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.css">
<link rel="stylesheet" href="<%=basePath%>css/bootstrap-responsive.css">
<link rel="stylesheet" href="<%=basePath%>css/jquery.fancybox.css">
<link rel="stylesheet" href="<%=basePath%>css/uniform.default.css">
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.datepicker.css">
<link rel="stylesheet" href="<%=basePath%>css/jquery.cleditor.css">
<link rel="stylesheet" href="<%=basePath%>css/jquery.plupload.queue.css">
<link rel="stylesheet" href="<%=basePath%>css/jquery.tagsinput.css">
<link rel="stylesheet" href="<%=basePath%>css/jquery.ui.plupload.css">
<link rel="stylesheet" href="<%=basePath%>css/chosen.css">
<link rel="stylesheet" href="<%=basePath%>css/jquery.jgrowl.css">
<link rel="stylesheet" href="<%=basePath%>css/style.css">
<script src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function uploadcheck(){
    		//取得file里面的值
    		var path = document.getElementById("exampleInputFile").value;
    		if(path.endsWith('.jpg')||path.endsWith('.png')){
    			return true;
    		} else {
    		alert("图片上传格式错误，只能上传以jpg、png格式的图片");
    		return false;
    		}
    	}
   //表单验证
  	function validForm() {
		var result = false;
		var frm = document.getElementById("saveUserinfoForm");
		if(validator(frm)) {
		var pw1 = document.getElementById("pw1").value;
		var pw2 = document.getElementById("pw2").value;
		if(pw1==pw2) {
		result = true;
		} else {
		alert("两次密码不一致");
		return false;
		}
		
		}
		if (result&&uploadcheck()) {
			if (confirm("    确认注册用户的【详细信息】信息无误?  " 
					+ "\n\n点击【确定】提交信息，点击【取消】继续修改.")) {
				return true;
			}
		}
		return false;
	}
	//图片预览
  	function preview(file,preview,imghead){
		if($.browser.msie){
					//参数 是否是IE，div的id，img的id，高,宽 
			previewImage(true,file,preview,imghead,200,200);
	}else{
					//参数 是否是IE，div的id，img的id，高,宽 
			previewImage(false,file,preview,imghead,200,200);
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
			<li>
			 <img src="<%=path%>/upload/<%=userinfodoc.getDimageFileName() %>" height="30px" width="60px" />
			</li>
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
										<h3>添加专家</h3>
									</div>
				<div class="jumbotron">
					<div class="container" align="center">
						<form action="addUserinfoDoc.action" method="post" onsubmit="return validForm()" id="saveUserinfoForm"  enctype="multipart/form-data">
						<table>

				<tr>
				<td>
					<div class="control-group">
							<label for="uname" class="control-label">姓名</label>
							<div class="controls">
								<input type="text" cnName="姓名" placeholder="输入中文名" valid="required|isChinese" errmsg="|姓名必须是中文" name="userinfo.dname"  class='required'>
							</div>
					</div>
				</td>
				<td>
					
					<div class="control-group">
							<label for="uname" class="control-label">生日</label>
							<div class="controls">
							  		<input type="text" class="form-control" onClick="WdatePicker()" cnName="生日" valid="required" placeholder="birthday" name="userinfo.dbirthday">
						</div>
					</div>
				</td>
				</tr>
				
				<tr>
					<td>
					<div class="control-group">
								<label for="pw3" class="control-label">密码</label>
								<div class="controls">
									<input type="password"  placeholder="password"  cnName="密码" valid="required" name="userinfo.password" id="pw1"  class='required'>
								</div>
						</div>
					</td>
					<td>
					<div class="control-group">
								<label for="uname" class="control-label">电话</label>
								<div class="controls">
									<input type="text"  placeholder="tel"  cnName="电话" valid="required|isMobile" errmsg="|电话格式不规范" name="userinfo.dtel"  class='required'>
								</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
								<label for="pw4" class="control-label">确认密码</label>
								<div class="controls">
									<input type="password" id="pw2" placeholder="两次密码必须一致" class='required' equalTo="#pw3">
								</div>
						</div>
					</td>
					<td>
					<div class="control-group">
													<label for="sela" class="control-label">科室</label>
													<div class="controls">
														<select  id="sela" name="keshi" class='{required:true}'>
														<%
															for(int k = 0;k<keshiList.size();k++) {
															%>
															<option value="<%= keshiList.get(k).getId()%>"><%= keshiList.get(k).getKname()%></option>
															<%
															}
														 %>
															
														</select>
													</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
					<div class="control-group">
						<label for="check2" class="control-label">预约时间</label>
						<div class="controls">
						<%
						for(int i = 0;i<weeklist.size();i++) {
						%>
						<label class="checkbox"><input type="checkbox" class='uniform' name="yuyuetime" value="<%=weeklist.get(i).getId()%>"><%=weeklist.get(i).getWeek() %></label>
						<%
						}
						 %>
						</div>
					</div>
					</td>
					<td>
					
					<div class="control-group">
						<label for="file" class="control-label">头像</label>
						<div class="controls">
							<input type="file" onblur="uploadcheck()" id="exampleInputFile" cnName="头像" valid="required" name="userinfo.dimage" onchange="preview(this,'preview','imghead')">
						</div>
					</div>
				  		 <div id="imagePreview" >图片预览
				  		 <div id="preview">
					     <img id="imghead" width="200px" height="200px" border=0 />
						 </div>
				  		 </div>
					</td>
				</tr>

<tr>
	<td>
	<input type="reset" class="btn btn-primary" value="重置" />
	
	</td>
	<td>
	<input type="submit" class="btn btn-primary" value="添加" />
	</td>
	</tr>
</table>
</form>

  
 					</div>
				</div>
			</div>	
		</div>
	</div>	
</div>	
<script src="<%=basePath %>js/jquery.js"></script>
<script src="<%=basePath %>js/jquery.js"></script>
<script src="<%=basePath %>js/less.js"></script>
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/jquery.uniform.min.js"></script>
<script src="<%=basePath %>js/bootstrap.timepicker.js"></script>
<script src="<%=basePath %>js/bootstrap.datepicker.js"></script>
<script src="<%=basePath %>js/chosen.jquery.min.js"></script>
<script src="<%=basePath %>js/jquery.fancybox.js"></script>
<script src="<%=basePath %>js/plupload/plupload.full.js"></script>
<script src="<%=basePath %>js/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script src="<%=basePath %>js/jquery.cleditor.min.js"></script>
<script src="<%=basePath %>js/jquery.inputmask.min.js"></script>
<script src="<%=basePath %>js/jquery.tagsinput.min.js"></script>
<script src="<%=basePath %>js/jquery.mousewheel.js"></script>
<script src="<%=basePath %>js/jquery.textareaCounter.plugin.js"></script>
<script src="<%=basePath %>js/ui.spinner.js"></script>
<script src="<%=basePath %>js/jquery.jgrowl_minimized.js"></script>
<script src="<%=basePath %>js/jquery.form.js"></script>
<script src="<%=basePath %>js/jquery.validate.min.js"></script>
<script src="<%=basePath %>js/bbq.js"></script>
<script src="<%=basePath %>js/jquery-ui-1.8.22.custom.min.js"></script>
<script src="<%=basePath %>js/jquery.form.wizard-min.js"></script>
<script src="<%=basePath %>js/jquery.cookie.js"></script>
<script src="<%=basePath %>js/jquery.metadata.js"></script>
<script src="<%=basePath %>js/custom.js"></script><script src="<%=basePath %>js/demo.js"></script>
</body>
</html>