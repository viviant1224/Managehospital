<%@ page language="java" import="java.util.*" import="cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Keshi> keshiList = (List<Keshi>)request.getSession().getAttribute("keshiList");
List<YuyueTime> weeklist = (List<YuyueTime>)request.getSession().getAttribute("weeklist");
UserinfoDoc userinfodoc = (UserinfoDoc)request.getSession().getAttribute("userinfoDoc");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改专家</title>
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
	
	<script src="My97DatePicker/WdatePicker.js"></script>
   <script src="<%=basePath%>js/form_valid.js" charset="utf-8"></script>
<script src="<%=basePath %>js/imagePreview.js"></script>
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
			result = true;
		}
		if (result&&uploadcheck()) {
			if (confirm("    确认修改用户的【详细信息】信息无误?  " 
					+ "\n\n点击【确定】提交信息，点击【取消】继续修改.")) {
				return true;
			}
		}
		return false;
	}
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
  
  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=basePath %>js/bootstrap.min.js"></script>
  
  <body>
   <nav class="nav  navbar-inverse" role="navigation">
    
	<div class="navbar-header">
		
    <ul class="nav navbar-nav navbar-right">
      <li><a href="javascript:void"><img src="<%=path%>/upload/<%=userinfodoc.getDimageFileName() %>" height="30px" width="30px" /></a></li>
      <li><a href="javascript:void">当前用户：<%=userinfodoc.getDname() %></a></li>
       <li><a href="javascript:void">当前要操作的专家：${userinfo1.dname}</a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>


<div class="jumbotron">
					<div class="container" align="center">
						<form action="changeUserinfoDoc.action" method="post" onsubmit="return validForm()" id="saveUserinfoForm"  enctype="multipart/form-data">
						<table>
				<tr>
				<td>
					<div class="control-group">
							<label for="uname" class="control-label">姓名</label>
							<div class="controls">
							<input type="text" class="form-control" cnName="姓名" valid="required|isChinese" errmsg="|姓名必须是中文" value="${userinfo1.dname}" placeholder="username" name="userinfo1.dname">
							<input type="hidden" value="${userinfo1.id}" name="userinfo1.id">
							</div>
					</div>
				</td>
				<td>
					<div class="control-group">
							<label for="uname" class="control-label">生日</label>
							<div class="controls">
  		<input type="text" class="form-control" value="${userinfo1.dbirthday}" onClick="WdatePicker()" cnName="生日" valid="required" placeholder="birthday" name="userinfo1.dbirthday">
							</div>
					</div>
				</td>
				</tr>
				
				<tr>
					<td>
					<div class="control-group">
								<label for="pw3" class="control-label">密码</label>
								<div class="controls">
  		<input type="text" class="form-control" cnName="密码" valid="required" value="${userinfo1.password}" placeholder="password" name="userinfo1.password">
								</div>
						</div>
					</td>
					<td>
					<div class="control-group">
								<label for="uname" class="control-label">电话</label>
								<div class="controls">
								  		<input type="text" class="form-control" cnName="电话" valid="required|isMobile" errmsg="|电话格式不规范" value="${userinfo1.dtel}" placeholder="tel" name="userinfo1.dtel">
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
						<label class="checkbox"><input type="checkbox" class='uniform' name="yuyuetime1" value="<%=weeklist.get(i).getId()%>"><%=weeklist.get(i).getWeek() %></label>
						<%
						}
						 %>
						</div>
					</div>
					
					</td>
					<td>
					<div class="control-group">
													<label for="sela" class="control-label">科室</label>
													<div class="controls">
														<select  id="sela" name="keshi1" class='{required:true}'>
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
								<label for="pw4" class="control-label">专家详情</label>
<textarea class="form-control" rows="10" cols="12" name="userinfo1.info">${userinfo1.info}</textarea>
								</div>
					</td>
					<td>
					
					<div class="control-group">
						<label for="file" class="control-label">头像</label>
						<div class="controls">
							<input type="file"  onblur="uploadcheck()" id="exampleInputFile" cnName="头像" valid="required" value="${userinfo1.dimageFileName}"name="userinfo1.dimage" onchange="preview(this,'preview','imghead')">
						</div>
					</div>
				  		 <div id="imagePreview" >图片预览
				  		 <div id="preview">
					     <img id="imghead" src="<%=basePath%>upload/${userinfo1.dimageFileName}" width="200px" height="200px" border=0 />
						 </div>
				  		 </div>
					</td>
				</tr>

<tr>
	<td>
	<input type="reset" class="btn btn-primary" value="重置" />
	
	</td>
	<td>
	<input type="submit" class="btn btn-primary" value="修改" />
	</td>
	</tr>
</table>
</form>

  
 					</div>
				</div>
  </body>
</html>
