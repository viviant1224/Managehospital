<%@ page language="java" import="java.util.*" import="cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Powerinfo> listall = (List<Powerinfo>)request.getSession().getAttribute("listall");
UserinfoDoc userinfodoc = (UserinfoDoc)request.getSession().getAttribute("userinfoDoc");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>用户详情</title>
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
	<script src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
	<script src="<%=basePath%>/js/form_valid.js" charset="utf-8"></script>
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
		var pw1 = document.getElementById("pw1").value;
		var pw2 = document.getElementById("pw2").value;
		var pw = document.getElementById("pw").value;
		var yuanmima = document.getElementById("yuanmima").value;
		result = true;
		if(pw!=yuanmima) {
		alert("原密码输入错误");
		return false;
		}
		if(pw1==pw2) {
		result = true;
		} else {
		alert("两次密码不一致或者原密码输入错误");
		return false;
		}
		}
		if (result&&uploadcheck()) {
			if (confirm("    确认修改个人的【详细信息】信息无误?  " 
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
  	</script>
  </head>
  
  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=basePath %>js/bootstrap.min.js"></script>
  
  <body>
  <nav class="nav  navbar-inverse" role="navigation">
    
	<div class="navbar-header">
    <ul class="nav navbar-nav navbar-right">
      <li><a href="javascript:void" onClick="Sign()" class="current" >当前页面：修改个人信息</a></li>
       <li><a href="javascript:void"><img src="<%=path%>/upload/<%=userinfodoc.getDimageFileName() %>" height="30px" width="30px" /></a></li>
     <li><a href="javascript:void">当前用户：    <%=userinfodoc.getDname()%>
      </a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>
  
<div class="jumbotron">
					<div class="container" align="center">
						<form action="updategerenUserinfoDoc.action" method="post" onsubmit="return validForm()" id="saveUserinfoForm"  enctype="multipart/form-data">
						<table>
				<tr>
				<td width="300px">
					<div class="control-group">
							  
    			用户名：<input type="text" class="form-control" value="<%=userinfodoc.getDname()%>"  cnName="姓名" disabled>
  								
					</div>
				</td>
				<td width="300px">
					<div class="control-group">
				出生日期:<input type="text" class="form-control" value="<%=userinfodoc.getDbirthday()%>" onClick="WdatePicker()" cnName="生日" valid="required" placeholder="birthday" name="userinfo.dbirthday">
					</div>
				</td>
				</tr>
				<tr>
				<td width="300px">
					<div class="control-group">
					<input type="hidden" value="<%=userinfodoc.getId() %>" name="userinfo.id"> 
					<input type="hidden" value="<%=userinfodoc.getPassword() %>" id="yuanmima">
					</div>
				</td>
				<td width="300px">
					<div class="control-group">
					原密码：<input type="password" id="pw"   cnName="输入密码" valid="required" class="form-control" placeholder="password">
					</div>
				</td>
				</tr>
				
				<tr>
					<td>
					<div class="control-group"> 
								修改密码：<input type="password" name="userinfo.password" id="pw1"   cnName="输入密码" valid="required" class="form-control" placeholder="password">
						</div>
					</td>
					<td>
					<div class="control-group">
												
							<div class="control-group">
						</div>						
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
								确认密码：<input type="password" id="pw2" class="form-control" placeholder="password">
						</div>
					</td>
					<td>
					<div class="control-group">
							电话：<input type="text" name="userinfo.dtel" cnName="电话" value="<%=userinfodoc.getDtel() %>" valid="required|isMobile" errmsg="|电话格式不规范" class="form-control" placeholder="tel">
						</div>
					</td>
				</tr>
				<tr>
					<td>
					<div class="control-group">
					编号：<font color="blue"><%=userinfodoc.getId() %></font>
					
					
					</div>
					</td>
					<td>
					<div class="control-group">
						<div class="controls">
						头像：<input type="file" onblur="uploadcheck()" id="exampleInputFile" value="<%=userinfodoc.getDimageFileName() %>" cnName="头像" valid="required" name="userinfo.dimage" onchange="preview(this,'preview','imghead')">
						</div>
					</div>
				  		 <div id="imagePreview" >头像预览
				  		 <div id="preview">
					     <img id="imghead" src="<%=basePath%>upload/<%=userinfodoc.getDimageFileName() %>" width="200px" height="200px" border=0 />
						 </div>
				  		 </div>
					</td>
				</tr>
	<tr>
	<td align="right">
	<input type="reset" class="btn btn-primary" value="重置" />
	
	</td>
	<td align="right">
	<input type="submit" class="btn btn-primary" value="修改" />
	</td>
	</tr>
</table>
</form>
 					</div>
 				</div>
  </body>
</html>
